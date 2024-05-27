`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 20:10:07
// Design Name: 
// Module Name: im_4k
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


module im_4k(rst,  addr, dout );
    input wire rst;
    input [31:0] addr;
    output [31:0] dout;

    reg [31:0] imem[4096:3072];

    always @(posedge rst)
    if(rst)
    begin    
        imem[3072]=32'h341d000c;
        imem[3073]=32'h34021234;
        imem[3074]=32'h34033456;
        imem[3075]=32'h00432020;
        imem[3076]=32'h00643022;
        imem[3077]=32'h08000c07;
        imem[3078]=32'h00643822;
        imem[3079]=32'hac020000;
        imem[3080]=32'hac030004;
        imem[3081]=32'h8c050000;
        imem[3082]=32'hafa40004;
        imem[3083]=32'h10450001;
        imem[3084]=32'h8fa30004;
        imem[3085]=32'h8c050004;
        imem[3086]=32'h1464ffff;
    end

    assign dout = imem[addr[31:2]];

endmodule

