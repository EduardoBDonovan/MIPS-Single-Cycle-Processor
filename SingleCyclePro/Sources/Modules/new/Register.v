`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 05:19:41 PM
// Design Name: 
// Module Name: Register
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


module Register #(parameter dataW = 32)(
input clk, rst, en,
input [dataW - 1:0] dataIn,
output reg [dataW - 1:0] dataOut
    );
    
    always @(posedge clk)
    if(rst) dataOut <= 0;
    else if(en) dataOut <= dataIn;
    
endmodule
