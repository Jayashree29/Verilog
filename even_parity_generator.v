`timescale 1ns / 1ps

module even_parity_generator(
    input [2:0] data,
    output reg parityBit
    );
wire  [2:0] sum;

always@(*)
begin
if((sum % 2) == 0)
  parityBit = 0;
else
  parityBit = 1;

end

assign sum = data[0] + data[1] + data[2];

endmodule
