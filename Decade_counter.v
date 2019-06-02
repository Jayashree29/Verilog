`timescale 1ns / 1ps


module Decade_counter(
    output reg [3:0] out,
	 input clk,
	 input enable,
	 input reset
    );
	 
	 wire reached9;
	 
	always@(posedge clk)
	begin
	 if(reset)
	  out <= 0;
	 else if(reached9)
		out <= 0;
	 else if(enable)
	   out <= out + 1;
	 else
	  out <= out;
	end

	assign reached9 = (out == 9);
	
	
  endmodule
