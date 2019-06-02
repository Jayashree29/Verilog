`timescale 1ns / 1ps

module comparator(
    input a,
    input b,
    output reg e,
    output reg g,
    output reg l
    );
always@(*)
begin
 
 if(a > b) begin
   g = 1;
   l = 0;
   e = 0;
   end
 else if(a < b) begin
   l = 1;
   g = 0;
   e = 0;
   end
 else if(a == b) begin
   e = 1;
   g = 0;
   l = 0;
   end
 else begin
   g = 0;
   l = 0;
   e = 0;
   end
end

endmodule
