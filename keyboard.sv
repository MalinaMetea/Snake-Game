module keyboard (
    input KB_clk,
    input clk_25,
	input data,
    output reg [2:0] direction);
reg [7:0] code;
reg [7:0] previousCode;
reg [7:0] keyCode;
reg [2:0] others;
reg [3:0] count = 1;
always@(negedge KB_clk)
begin
    case (count)
    1:  others[0]<=data;
    2: 	keyCode[0] <= data;
    3: 	keyCode[1] <= data;	
    4: 	keyCode[2] <= data;
    5: 	keyCode[3] <= data;	
    6: 	keyCode[4] <= data;
    7: 	keyCode[5] <= data;	
    8: 	keyCode[6] <= data;
    9: 	keyCode[7] <= data;
    10:	others[1]<=data;
    11: ;
    endcase		
    if(count == 10)
    begin
        if(previousCode == 8'hF0)
        begin
            code <= keyCode;
        end
        previousCode <= keyCode;
    end
    if(count==11) count<=1;
    else count<=count+1;
end	
always@(code)
begin
    if(code == 8'h1D) 
        direction <= 3; 
    else if(code == 8'h1C) 
        direction <= 2; 
    else if(code == 8'h1B) 
        direction <= 0;
    else if(code == 8'h23)
        direction <= 1;
    else 
        direction<=4;
end
endmodule