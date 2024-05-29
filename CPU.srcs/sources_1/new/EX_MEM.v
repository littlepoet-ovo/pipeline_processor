`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/15 09:13:56
// Design Name: 
// Module Name: EX_MEM
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

module EX_MEM(clk,rst,
              MemtoReg_EX,MemWr_EX,RegWr_EX,result_EX, Db_EX,Rw_EX,RaDst_EX,PCplus1_EX,
              MemtoReg_MEM,MemWr_MEM,RegWr_MEM,result_MEM,Db_MEM,Rw_MEM,RaDst_MEM,PCplus1_MEM
    );
    input clk,rst;
    input MemtoReg_EX,MemWr_EX,RegWr_EX,RaDst_EX;
    input[31:0] result_EX,Db_EX,PCplus1_EX;
    input [4:0] Rw_EX;
    output reg MemtoReg_MEM,MemWr_MEM,RegWr_MEM,RaDst_MEM;
    output reg[31:0] result_MEM,Db_MEM,PCplus1_MEM;
    output reg [4:0] Rw_MEM;
    always @(posedge clk or posedge rst)
           begin
              if (rst==1)
                  begin             
                      MemtoReg_MEM<=0;         
                      MemWr_MEM<=0;
                      RegWr_MEM<=0;
                      result_MEM<=0;
                      Db_MEM<=0;
                      Rw_MEM<=0; 
                      RaDst_MEM<=0;
                      PCplus1_MEM<=0;
                  end 
               else
                  begin             
                      MemtoReg_MEM<=MemtoReg_EX;         
                      MemWr_MEM<=MemWr_EX;
                      RegWr_MEM<=RegWr_EX;
                      result_MEM<=result_EX;
                      Db_MEM<=Db_EX;
                      Rw_MEM<=Rw_EX;     
                      RaDst_MEM<=RaDst_EX;
                      PCplus1_MEM<=PCplus1_EX;    
                  end
           end      
endmodule

