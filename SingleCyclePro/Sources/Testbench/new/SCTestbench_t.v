`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 06:27:11 PM
// Design Name: 
// Module Name: SCTestbench_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SCTestbench_tb;

reg clk, rst;

TopModule top (.clk(clk), .rst(rst));

always #5 clk <= ~clk;

initial begin
clk = 1; rst = 1;
#1 rst = 0;
#500;
#10 $finish;
end

endmodule
