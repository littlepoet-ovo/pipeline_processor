`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/15 09:11:01
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(clk,rst,clear,PC31_28_IF,im_dout_IF,PCplus1_IF,
             PC31_28_ID,PCplus1_ID,im_dout_ID);
   input clk,rst,clear;
   input [3:0] PC31_28_IF;//指令前四
   input [31:0] im_dout_IF;//指令的值
   input [31:0] PCplus1_IF;
   output reg[3:0] PC31_28_ID;//PC前四位
   output reg [31:0] PCplus1_ID;//pc+4的值
   output reg[31:0] im_dout_ID;////指令的值
   always @(posedge clk or rst)
      begin
         if (rst||clear)
             begin
                  PC31_28_ID<=0;
                  PCplus1_ID<=0;
                  im_dout_ID<=0;
             end 
          else
             begin
                  PC31_28_ID<=PC31_28_IF;
                  PCplus1_ID<=PCplus1_IF;
                  im_dout_ID<=im_dout_IF;
             end
      end
endmodule

