`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:04:08 02/02/2019 
// Design Name: 
// Module Name:    CLOCK 
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
module CLOCK(
    input reset,
	 input enable,
	 input clk,
	 input set_time,
	 input [5:0] load_time,
    output reg [6:0] sec_count,
    output reg [6:0] min_count,
    output reg [4:0] hour_count
    );
//internal registers
reg [32:0] clk_count;


//comparators
assign clk_reached = (clk_count == 50000000);
assign sec_reached = (sec_count == 60);
assign min_reached = (min_count == 60);
assign hour_reached = (hour_count == 12);

always@(posedge clk) //1second clock
begin

if(reset)
 clk_count = 0;
 
else if(clk_reached)
 clk_count = 0;

else if(enable)
 clk_count = clk_count + 1;
 
else 
 clk_count = clk_count;
 
end 


always@(posedge clk) //seconds clock
begin

if(reset)
 sec_count = 0;
 

else if(set_time)
 sec_count = load_time[1:0];

else if(sec_reached)
 sec_count = 0;
 
else if(clk_reached)
 sec_count = sec_count + 1;

else
 sec_count = sec_count;

end

always@(posedge clk) //minutes clock
begin

if(reset)
 min_count = 0;

else if(set_time)
 min_count = load_time[3:2];

else if(min_reached)
 min_count = 0;

else if(sec_reached)
 min_count = min_count + 1;
 
else
 min_count = min_count;

end

always@(posedge clk) //hour clock
begin

if(reset)
 hour_count = 0;

else if(set_time)
 hour_count = load_time[5:4];
 
else if(hour_reached)
 hour_count = 0;

else if(min_reached)
 hour_count = hour_count + 1;
 
else 
 hour_count = hour_count;
 
end


endmodule
