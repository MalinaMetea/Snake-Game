`include "my_defines.v"
module snake_logic#(
    parameter total_H=`TOTAL_HORIZONTAL_PIXELS,
    parameter total_V= `TOTAL_VERTICAL_PIXELS,
    parameter active_H=`ACTIVE_HORIZONTAL_PIXELS,
    parameter active_V=`ACTIVE_VERTICAL_PIXELS) 
   (input clk_25,
    input clk,
    input reset_game,
    input clk_ps2,
    input [`COUNT_H_SIZE-1:0] count_H,       
    input [`COUNT_V_SIZE-1:0] count_V,      
    input [`DIRECTION_SIZE-1:0] direction,    
    input rst,                
    output reg Red,           
    output reg Green,
    output reg Blue);
reg [`APPLE_POS_SIZE-1:0] random_x;           
reg [`APPLE_POS_SIZE-1:0] random_y;           
reg [`APPLE_POS_SIZE-1:0] apple_pos_x;   
reg [`APPLE_POS_SIZE-1:0] apple_pos_y;    
reg [`APPLE_COUNTER_SIZE-1:0] apple_count;    
reg [`SNAKE_POS_SIZE-1:0] sh_pos_x;       
reg [`SNAKE_POS_SIZE-1:0] sh_pos_y;       
reg [`SNAKE_POS_SIZE-1:0] snake_x[0:`MAX_SNAKE_LENGTH-1];   
reg [`SNAKE_POS_SIZE-1:0] snake_y[0:`MAX_SNAKE_LENGTH-1];
reg [`SNAKE_LENGTH_SIZE-1:0] snake_length;          
reg [`MAX_SNAKE_LENGTH-1:0]  snake_display_condition;
reg apple;              
reg border;             
reg snake_head;              
wire active_area;      
reg game_over;             
reg snake_tail;
reg snake_eats_apple;  
reg snake_hits_border; 
reg snake_head_hits_body; 
wire text;
reg [`MAX_SNAKE_LENGTH-1:0] j;
reg [`MAX_SNAKE_LENGTH-1:0] k;
reg movement_clock;
wire [`SCORE_DIGIT_SIZE -1:0] score0;
wire [`SCORE_DIGIT_SIZE -1:0] score1;
wire [`SCORE_DIGIT_SIZE -1:0] score2;   
assign active_area=(count_H <= active_H && count_V <= active_V);  
split_digits score_digits(
    .snake_length(snake_length), 
    .hundreds(score2), 
    .tens(score1), 
    .ones(score0)); 
snake_body body_display(
    .count_H(count_H),
    .count_V(count_V),
    .snake_length(snake_length),                
    .snake_x(snake_x),
    .snake_y(snake_y),
    .clk_25(clk_25),
    .reset_game(reset_game),
    .snake_display_condition(snake_display_condition),
    .snake_tail(snake_tail));
character_generator char_gen(
    .clk_25(clk_25),
    .game_over(game_over),
    .count_H(count_H),         
    .count_V(count_V),        
    .score0(score0),         
    .score1(score1),         
    .score2(score2),         
    .text(text));
update continuous_movement(
    .clk(clk_25),
    .movement_clock(movement_clock));
random_location_generator random_gen(
    .clk_25(clk_25),
    .random_y(random_y),
    .random_x(random_x),
    .reset_game(reset_game));
always @ (posedge clk_25)
begin
   snake_head <= (((count_V>=sh_pos_y)    && (count_V-`SNAKE_SQUARE_SIZE<=sh_pos_y)) && ((count_H>= sh_pos_x)   && (count_H-`SNAKE_SQUARE_SIZE<=sh_pos_x))) ;   
   apple <= (((count_V>=apple_pos_y) && (count_V<=apple_pos_y+`APPLE_SQUARE_SIZE)) && ((count_H>= apple_pos_x) && (count_H<=apple_pos_x+`APPLE_SQUARE_SIZE)));   
   border <= ((((count_H <= `BORDER_LEFT_POSITION) || (count_H >= `BORDER_RIGHT_POSITION)) || ((count_V <= `BORDER_UP_POSITION )  || (count_V >= `BORDER_DOWN_POSITION))) && count_V>=30);
end
always @ (posedge movement_clock)  
begin
    if(reset_game)
    begin
        sh_pos_y<=`INITIAL_SNAKE_HEAD_POS_Y;
        sh_pos_x<=`INITIAL_SNAKE_HEAD_POS_X;
        snake_head_hits_body <= 0;
        for(k=`MAX_SNAKE_LENGTH-1; k>0; k=k-1)    
        begin
            snake_x[k]<=700; 
            snake_y[k]<=500;
        end
    end
    else
    begin
        snake_x[0]<=sh_pos_x;   
        snake_y[0]<=sh_pos_y;  
        if(game_over==0)
        begin 
            for(j=`MAX_SNAKE_LENGTH-1; j>0; j=j-1)    
            begin
                if(j<=snake_length)
                begin         
                    snake_x[j]<=snake_x[j-1];   
                    snake_y[j]<=snake_y[j-1];
                    if(sh_pos_x==snake_x[j] && sh_pos_y==snake_y[j])
                       snake_head_hits_body<=1;  
                end                       
            end
            if (direction==`DIRECTION_UP) sh_pos_y<=sh_pos_y-1; 
            else if (direction==`DIRECTION_DOWN) sh_pos_y<=sh_pos_y+1;   
            else if (direction==`DIRECTION_LEFT) sh_pos_x<=sh_pos_x-1;   
            else if (direction==`DIRECTION_RIGHT) sh_pos_x<=sh_pos_x+`SPEED;  
        end
        else if (game_over) 
        begin
            sh_pos_x<=sh_pos_x;
            sh_pos_y<=sh_pos_y;
        end
   end
end
always @ (posedge clk_25)  
begin
    if(reset_game)
    begin        
        apple_pos_x<=`INITIAL_APPLE_POSITION_X;
        apple_pos_y<=`INITIAL_APPLE_POSITION_Y; 
        apple_count<=0;    
        snake_length<=0;  
    end
    
    else
    begin
        if(apple && snake_head)
        begin
            snake_eats_apple<=1;
            if(snake_eats_apple==0) snake_length<=snake_length + `LENGTH_INCREASE;  
            apple_pos_x<=random_x;  
            apple_pos_y<=random_y; 
        end   
        else
        begin
            snake_length <= snake_length;
            snake_eats_apple<=0;
        end
    end
end
always @ (posedge clk_25)
begin
    snake_hits_border    <= ((sh_pos_y)<=`BORDER_UP_POSITION || (sh_pos_y+`SNAKE_SQUARE_SIZE )>=`BORDER_DOWN_POSITION || (sh_pos_x)<=`BORDER_LEFT_POSITION || (sh_pos_x+`SNAKE_SQUARE_SIZE )>=`BORDER_RIGHT_POSITION);
end
always @ (posedge clk_25)
begin
    if(snake_hits_border || snake_head_hits_body) game_over<=1; 
    else game_over<=0; 
end
always @ (posedge clk_25)
begin
    Red <= (active_area && (apple || text)) ? 1:0;
    Green <= (active_area && (snake_head || snake_tail)) ? 1:0;
    Blue <= (active_area &&  border) ? 1:0;
end
endmodule