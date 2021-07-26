module update(
	input clk,
	output reg movement_clock);
reg [17:0] count;	
always@(posedge clk)
begin
		count <= count + 1;
		if(count == 100000)
		begin
			movement_clock <= ~movement_clock;
			count <= 0;
		end	
end
endmodule