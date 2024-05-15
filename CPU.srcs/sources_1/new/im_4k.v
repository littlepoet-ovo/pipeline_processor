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
//        imem[3072]=32'h10000001;
//        imem[3073]=32'h20010003;
//        imem[3074]=32'h20020003;
        imem[3072]=32'h341d000c;
        imem[3073]=32'h340b3456;
        imem[3074]=32'h34021234;
        imem[3075]=32'h34033456;
        imem[3076]=32'h340c0001;
        imem[3077]=32'h340d3456;
        imem[3078]=32'h340e0001;
        imem[3079]=32'h00432020;
        imem[3080]=32'h340f0001;
        imem[3081]=32'h3412ffff;
        imem[3082]=32'h3413ffff;
        imem[3083]=32'h3414ffff;
        imem[3084]=32'h11ec0003;
        imem[3085]=32'h340dffff;
        imem[3086]=32'h3410ffff;
        imem[3087]=32'h3411ffff;
        imem[3088]=32'h018c6020;
        imem[3089]=32'h00643022;
        imem[3090]=32'hac020000;
        imem[3091]=32'hac030004;
        imem[3092]=32'hafa40004;
        
        
    end

    assign dout = imem[addr[31:2]];

endmodule

