`timescale 1ns/1ps

// Adder #(.inw1(), .inw2()) adder (.in1(), .in2(), .dataOut());
module Adder #(parameter inw1 = 32, inw2 = 32, outw = (inw1 > inw2) ? inw1 + 1 : inw2 + 1)(
input signed [inw1 - 1:0] in1, 
input signed [inw2 - 1:0] in2,
output signed [outw - 1:0] dataOut
);

assign dataOut = in1 + in2; 

endmodule