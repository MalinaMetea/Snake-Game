`include "my_defines.v"
module random_location_generator(
    input clk_25,
    output reg [`APPLE_POS_SIZE-1:0] random_x,
    output reg [`APPLE_POS_SIZE-1:0] random_y,
    input reset_game);
always@(posedge clk_25)
begin
    if(reset_game) random_x <= `RAND_X_INIT;
    else
    begin      
        if(random_x > `APPLE_POS_LIMIT_RIGHT)
            random_x <= `RAND_X_INIT;
        else if(random_x < `APPLE_POS_LIMIT_LEFT)
            random_x <= `RAND_X_INIT;
        else
            random_x <= random_x + `RAND_X_INCREMENT;
    end
end
always @(posedge clk_25)
begin
    if(reset_game) random_y <= `RAND_Y_INIT;
    else
    begin      
        if(random_y > `APPLE_POS_LIMIT_DOWN)
            random_y <= `RAND_Y_INIT;
        else if(random_y < `APPLE_POS_LIMIT_UP)
            random_y <= `RAND_Y_INIT;
        else
            random_y <= random_y + `RAND_Y_INCREMENT;
    end
end
endmodule	