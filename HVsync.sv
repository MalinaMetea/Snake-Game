`include "my_defines.v"

module HVsync  
  #(parameter total_H      = `TOTAL_HORIZONTAL_PIXELS  ,
    parameter total_V      = `TOTAL_VERTICAL_PIXELS    ,
    parameter active_H     = `ACTIVE_HORIZONTAL_PIXELS ,
    parameter active_V     = `ACTIVE_VERTICAL_PIXELS   
    )
   
   (input clk_25,
    output reg h_sync, 
    output reg v_sync,
    output reg [`COUNT_H_SIZE-1:0] count_H=0,
    output reg [`COUNT_V_SIZE-1:0] count_V=0
    );

always @(posedge clk_25)
begin
    if(count_H==total_H-1)
		 begin
			count_H <= 0;
			if(count_V == total_V-1)
			  count_V <= 0;
			else  
			  count_V <= count_V + 1;
		 end
    else
		 count_H <= count_H + 1;
end


//localparam FP_H = `FRONT_PORCH_H ; //18; //horizontal front porch
//localparam BP_H = `BACK_PORCH_H  ; //50; //horizontal back porch
//localparam FP_V = `FRONT_PORCH_V ; //10; //vertical front porch
//localparam BP_V = `BACK_PORCH_V  ; //33; //vertical back porch

always @(posedge clk_25)
  begin
    if ((count_H < `FRONT_PORCH_H + active_H) || (count_H > total_H - `BACK_PORCH_H - 1))
      h_sync <= 1;
    else
      h_sync <= 0;
    
    if ((count_V < `FRONT_PORCH_V + active_V) ||(count_V > total_V - `BACK_PORCH_V - 1))
      v_sync <= 1;
    else
      v_sync <= 0;
  end


endmodule