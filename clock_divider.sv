module clock_divider(
	input wire clk, //50MHz
	input wire rst, //reset active low 
	output wire clk_25 //25MH
	
	);

reg [7:0] nr;
assign clk_25=nr[1];

always @ (posedge clk)
	begin
		if(rst==0)
		  nr<=0;
		else
		  nr<=nr+1; 
	end

endmodule
  