module snake_body(
    input [`COUNT_H_SIZE-1:0] count_H,
    input [`COUNT_V_SIZE-1:0] count_V,
    input [`SNAKE_LENGTH_SIZE-1:0] snake_length,                     
    input [`SNAKE_POS_SIZE-1:0] snake_x[0:`MAX_SNAKE_LENGTH-1],    
    input [`SNAKE_POS_SIZE-1:0] snake_y[0:`MAX_SNAKE_LENGTH-1],
    input clk_25,
    input reset_game,
    output reg [`MAX_SNAKE_LENGTH-1:0] snake_display_condition,
    output reg snake_tail        
    );
reg [`MAX_SNAKE_LENGTH-1:0] snake_compare_condition;
generate
    genvar i;
    for(i=0; i<`MAX_SNAKE_LENGTH; i=i+1)  
    begin   
    always @ (posedge clk_25) 
        begin
        snake_display_condition[i]<= (((count_V>=snake_y[i]) && (count_V-`SNAKE_SQUARE_SIZE<=snake_y[i] )) && ((count_H-`SNAKE_SQUARE_SIZE<=snake_x[i] ) && (count_H>=snake_x[i])));  
        end  
    end            
endgenerate
generate
    genvar k;
    for(k=0; k<`MAX_SNAKE_LENGTH; k=k+1)   
    begin  
    always @ (posedge clk_25)  
        begin
        snake_compare_condition[k] <=  snake_display_condition[k] & (snake_length >= k);
        end  
    end            
endgenerate
always @ (posedge clk_25) 
begin
    snake_tail<= |snake_compare_condition;
end
endmodule