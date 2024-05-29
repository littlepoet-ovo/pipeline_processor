`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/29 08:29:24
// Design Name: 
// Module Name: mux3
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


module mux3(A,B,C,SEL,OUT);
    parameter parameter_width = 32; // 默认位宽为 32 位
    input  [parameter_width-1:0] A,B,C;
    input  [1:0] SEL;
    output [parameter_width-1:0] OUT;
    assign OUT = SEL[0]?C:SEL[1]?B:A;
endmodule
