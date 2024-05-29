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
        imem[3072]=32'h34021234;
        imem[3073]=32'h34033456;
        imem[3074]=32'h00430820;
        imem[3075]=32'h00232022;
        imem[3076]=32'hac020000;
        imem[3077]=32'h8c090000;
        imem[3078]=32'h35283456;
        imem[3079]=32'h00223020;
        imem[3080]=32'h00233820;
//        imem[3072]=32'h20020005;
//        imem[3073]=32'h20030007;
//        imem[3074]=32'h14430001;
//        imem[3075]=32'h2c430fff;
//        imem[3076]=32'h30440005;

//        imem[3072]=32'h00000026;
//        imem[3073]=32'h20020005;
//        imem[3074]=32'h2003fffa;
//        imem[3075]=32'h00432020;
//        imem[3076]=32'h00622822;
//        imem[3077]=32'hac020000;
//        imem[3078]=32'hac030004;
//        imem[3079]=32'hac040008;
//        imem[3080]=32'hac050010;
//        imem[3081]=32'h341d000c;
//        imem[3082]=32'h38410013;
//        imem[3083]=32'h00230824;
//        imem[3084]=32'h00240825;
//        imem[3085]=32'hac01000c;
//        imem[3086]=32'h8c050000;
//        imem[3087]=32'h10450001;
//        imem[3088]=32'h8c030004;
//        imem[3089]=32'h8c050004;
//        imem[3090]=32'h1465fffd;
//        imem[3091]=32'h08000c15;
//        imem[3092]=32'hac02000c;
//        imem[3093]=32'h00a23022;
//        imem[3094]=32'hafa6fffc;
//        imem[3095]=32'h08000c19;
//        imem[3096]=32'hac02000c;
//        imem[3097]=32'h00403827;
//        imem[3098]=32'h00064100;
//        imem[3099]=32'h00084903;
//        imem[3100]=32'h240a0004;
//        imem[3101]=32'h240b0008;
//        imem[3102]=32'h014b6021;
//        imem[3103]=32'h016a6823;
//        imem[3104]=32'h0022702a;
//        imem[3105]=32'h014b782b;
//        imem[3106]=32'h00098102;
//        imem[3107]=32'h01498804;
//        imem[3108]=32'h01499006;
//        imem[3109]=32'h01499807;
//        imem[3110]=32'h0c000c2b;
//        imem[3111]=32'h2855fffb;
//        imem[3112]=32'h2c560fff;
//        imem[3113]=32'h30570005;
//        imem[3114]=32'h1464ffff;
//        imem[3115]=32'h3c140064;
//        imem[3116]=32'h03e00008;
    end

    assign dout = imem[addr[31:2]];

endmodule

