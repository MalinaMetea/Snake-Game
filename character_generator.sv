`include "my_defines.v"
module character_generator(
    input clk_25,
    input game_over,
    input [`COUNT_H_SIZE-1:0] count_H,        
    input [`COUNT_V_SIZE-1:0] count_V,        
    input [`SCORE_DIGIT_SIZE -1:0] score0,         
    input [`SCORE_DIGIT_SIZE -1:0] score1,        
    input [`SCORE_DIGIT_SIZE -1:0] score2,         
    output reg text);
wire [10:0] rom_addr;  
reg  [6:0] char_addr;
reg  [6:0] char_addr_s;
reg  [3:0] row_addr;
wire [3:0] row_addr_s; 
wire [7:0] data;
reg  [2:0] bit_addr;
wire [2:0] bit_addr_s;
wire score_on;     
wire font_bit;        
characters_ROM characters(
    .clk_25(clk_25),
    .address(rom_addr),
    .data(data));
assign score_on = (count_V[9:5]==0) && (count_H[9:4]<38);
assign row_addr_s = count_V[4:1];
assign bit_addr_s = count_H[3:1];
always @(*) 
begin
    case(count_H[9:4])
    6'h00: char_addr_s = game_over? 7'h11 : 7'h1a;      
    6'h01: char_addr_s = game_over? 7'h0b : 7'h16;     
    6'h02: char_addr_s = game_over? 7'h17 : 7'h0b;     
    6'h03: char_addr_s = game_over? 7'h0f : 7'h23;     
    6'h04: char_addr_s = game_over? 7'h00 : 7'h13;     
    6'h05: char_addr_s = game_over? 7'h19 : 7'h18;      
    6'h06: char_addr_s = game_over? 7'h20 : 7'h11;    
    6'h07: char_addr_s = game_over? 7'h0f : 7'h00;     
    6'h08: char_addr_s = game_over? 7'h1c : 7'h00;     
    6'h09: char_addr_s = 7'h00;     
    6'h0a: char_addr_s = game_over? 7'h25 : 7'h00;     
    6'h0b: char_addr_s = 7'h00;     
    6'h0c: char_addr_s = 7'h00;      
    6'h0d: char_addr_s = 7'h00;     
    6'h0e: char_addr_s = 7'h00;      
    6'h0f: char_addr_s = 7'h00;     
    6'h10: char_addr_s = 7'h00;    
    6'h11: char_addr_s = 7'h00;    
    6'h12: char_addr_s = 7'h00;      
    6'h13: char_addr_s = 7'h00;      
    6'h14: char_addr_s = 7'h00;    
    6'h15: char_addr_s = 7'h00;    
    6'h16: char_addr_s = 7'h00;       
    6'h17: char_addr_s = 7'h00;     
    6'h18: char_addr_s = 7'h00;      
    6'h19: char_addr_s = 7'h00;       
    6'h1a: char_addr_s = 7'h00;      
    6'h1b: char_addr_s = 7'h00;     
    6'h1c: char_addr_s = 7'h00;        
    6'h1d: char_addr_s = 7'h1d;      
    6'h1e: char_addr_s = 7'h0d;      
    6'h1f: char_addr_s = 7'h19;       
    6'h20: char_addr_s = 7'h1c;     
    6'h21: char_addr_s = 7'h0f;      
    6'h22: char_addr_s = 7'h00;      
    6'h23: char_addr_s = {4'b0,(score2+1)};     
    6'h24: char_addr_s = {4'b0,(score1+1)};        
    6'h25: char_addr_s = {4'b0,(score0+1)};   
    endcase
end
always@(*)  
begin 
    text = 0;    
    if (score_on)
        begin
            char_addr = char_addr_s;
            row_addr = row_addr_s;
            bit_addr = bit_addr_s;
            if (font_bit)
               text = 1;
         end
end
assign rom_addr = {char_addr, row_addr};
assign font_bit = data[bit_addr];
endmodule 