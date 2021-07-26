`include "my_defines.v"
module snake(
    input clk,
	input rst,
	input reset_game,
	input clk_ps2,
	input data_ps2,
	output reg o_Red,
	output reg o_Green,
	output reg o_Blue,
	output  o_hsync,
	output  o_vsync);
parameter total_H  = `TOTAL_HORIZONTAL_PIXELS;
parameter total_V  = `TOTAL_VERTICAL_PIXELS; 
parameter active_H = `ACTIVE_HORIZONTAL_PIXELS;
parameter active_V = `ACTIVE_VERTICAL_PIXELS; 
wire [`COUNT_H_SIZE-1:0] count_H;
wire [`COUNT_V_SIZE-1:0] count_V;
wire [2:0] direction;
wire clk_25;
wire  Red;
wire  Green;
wire  Blue;
clock_divider clk_div(
	.clk(clk),
	.rst(rst),
	.clk_25(clk_25));
HVsync #(
    .total_H(total_H),
    .total_V(total_V),
    .active_H(active_H),
    .active_V(active_V))          
	HV(
	.clk_25(clk_25),
	.h_sync(o_hsync), 
	.v_sync(o_vsync),
	.count_H(count_H),
	.count_V(count_V));
keyboard kb_ps2(
    .KB_clk(clk_ps2),
    .clk_25(clk_25),
    .data(data_ps2), 
    .direction(direction));
snake_logic #(
    .total_H(total_H),
    .total_V(total_V),
    .active_H(active_H),
    .active_V(active_V)) 
    snake_logic(
    .clk_25(clk_25),
    .clk(clk),
    .reset_game(reset_game),
    .rst(rst),
    .clk_ps2(clk_ps2),
    .count_H(count_H),
    .count_V(count_V),
    .direction(direction),
    .Red(o_Red),
    .Green(o_Green),
    .Blue(o_Blue));
endmodule 