`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/15 09:12:57
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(clk,rst,clear,
             Jump_ID, MemtoReg_ID, Beq_ID, MemWr_ID, ALUsrc_ID,
             RegWr_ID,ALUctr_ID,
             Da_ID,Db_ID,Rw_ID,
             Ext_imm32_ID,Jump_addr_ID,Branch_addr_ID,func,imm5,rezero_ID,RaDst_ID,PCplus1_ID,JrDst_ID,ExDst_ID,//id ‰»Î
             Jump_EX, MemtoReg_EX, Beq_EX, MemWr_EX, ALUsrc_EX,
             RegWr_EX,ALUctr_EX,
             Da_EX,Db_EX,Rw_EX,
             Ext_imm32_EX,Jump_addr_EX,Branch_addr_EX,func_EX,imm5_EX,rezero_EX,RaDst_EX,PCplus1_EX,JrDst_EX,ExDst_EX    //ex ‰≥ˆ
    );
    input clk,rst,clear;
    input [31:0] Jump_addr_ID,Branch_addr_ID;
    input Jump_ID, MemtoReg_ID, Beq_ID, MemWr_ID, ALUsrc_ID, RegWr_ID,rezero_ID,RaDst_ID,JrDst_ID,ExDst_ID;
    input [3:0]ALUctr_ID;
    input [31:0] Da_ID,Db_ID,Ext_imm32_ID;
    input [4:0] Rw_ID;
    input [5:0]  func;
    input [4:0]  imm5;
    input wire [31:0] PCplus1_ID;
    output reg [31:0] Jump_addr_EX,Branch_addr_EX;
    output reg Jump_EX, MemtoReg_EX, Beq_EX, MemWr_EX,RegWr_EX,ALUsrc_EX,rezero_EX,RaDst_EX,JrDst_EX,ExDst_EX;
    output reg [3:0] ALUctr_EX;
    output reg [31:0] Da_EX,Db_EX,Ext_imm32_EX;
    output reg [4:0] Rw_EX;
    output reg [5:0] func_EX;
    output reg [4:0] imm5_EX; 
    output reg [31:0] PCplus1_EX;
   always @(posedge clk or rst)
       begin
          if (rst || clear)
              begin
                  Jump_EX<=0;
                  MemtoReg_EX<=0;
                  Beq_EX<=0;
                  MemWr_EX<=0;
                  ALUsrc_EX<=0;
                  RegWr_EX<=0;
                  ALUctr_EX<=0;
                  Da_EX<=0;
                  Db_EX<=0;
                  Rw_EX<=0;
                  Ext_imm32_EX<=0;
                  Jump_addr_EX<=0;
                  Branch_addr_EX<=0;
                  func_EX<=0;
                  imm5_EX<=0;
                  rezero_EX<=0;
                  RaDst_EX<=0;
                  PCplus1_EX<=0;
                  JrDst_EX<=0;
                  ExDst_EX<=0;
              end 
           else
              begin
                  Jump_EX<=Jump_ID;
                  MemtoReg_EX<=MemtoReg_ID;
                  Beq_EX<=Beq_ID;
                  MemWr_EX<=MemWr_ID;
                  ALUsrc_EX<=ALUsrc_ID;
                  RegWr_EX<=RegWr_ID;
                  ALUctr_EX<=ALUctr_ID;
                  Da_EX<=Da_ID;
                  Db_EX<=Db_ID;
                  Rw_EX<=Rw_ID;
                  Ext_imm32_EX<=Ext_imm32_ID;
                  Jump_addr_EX<=Jump_addr_ID;
                  Branch_addr_EX<=Branch_addr_ID; 
                  func_EX<=func; 
                  imm5_EX<=imm5;  
                  rezero_EX<=rezero_ID;   
                  RaDst_EX<=RaDst_ID;  
                  PCplus1_EX<=PCplus1_ID;  
                  JrDst_EX<=JrDst_ID;
                  ExDst_EX<=ExDst_ID;
              end
       end   
endmodule

