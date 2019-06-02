`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:56:39 01/17/2019 
// Design Name: 
// Module Name:    Basic_counter_final 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Basic_counter_final(
    input reset,
    input clk,
    output reg [7:0] cout
    
    
    );
	
	 
   reg [32:0] temp;
	
	assign reached = (temp == 50000000);
	
	always@(posedge clk) //clk_counter
	begin
	if(reset)
	 temp <= 0;
	else if(reached)
	 temp <= 0;
	
	else 
	 temp <= temp + 1;
	
	end
	
	always@(posedge clk) //actual_counter
	begin
	if(reset)
	 cout <= 0;
	else if(reached)
	 cout <= cout + 1;
	else
	 cout <= cout;
	
	end


endmodule
