`timescale 1ns / 1ps


module JK_FF(
    input J,
    input K,
    input clk,
    input enable,
    output reg Q,
    output reg R
    );
always@(posedge clk)
begin
 if(enable)
   if((J == 0) && (K == 0)) begin
    Q <= 0;
	 R <= 0;
	end
   else if((J == 0) && (K == 1)) begin
    Q <= 0;
	 R <= 1;
	end
   else if((J == 1) && (K == 0)) begin
    Q <= 1;
	 R <= 0;
	end
   else begin
    Q <= ~Q;
	 R <= ~R;
	end
 else begin
  Q <= 0;
  R <= 0;
 end
end
endmodule
