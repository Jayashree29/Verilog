`timescale 1ns / 1ps


module jhonson_counter(
    input enable,
    input clear,
    input preset,
    input clk,
    output reg [3:0] out
    );
always@(posedge clk)

begin

if(clear)
 out <= 4'b0000;
else if(preset)
 out <= 4'b1000;
else if(enable)
 begin
 out[3:1] <= out[2:0];
 out[3] <= ~out[0];
 end

end

endmodule
