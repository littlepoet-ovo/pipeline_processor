`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/15 09:14:37
// Design Name: 
// Module Name: MEM_WB
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

module MEM_WB(clk,rst,
              MemtoReg_MEM,RegWr_MEM,result_MEM,dm_dout_MEM,Rw_MEM,
              MemtoReg_WB,RegWr_WB,result_WB,dm_dout_WB,Rw_WB
    );
    input clk,rst;
    input MemtoReg_MEM,RegWr_MEM;
    input[31:0] result_MEM,dm_dout_MEM;
    input [4:0] Rw_MEM;
    output reg MemtoReg_WB,RegWr_WB;
    output reg[31:0] result_WB,dm_dout_WB;
    output reg [4:0] Rw_WB;
    always @(posedge clk or rst)
           begin
              if (rst==1)
                  begin              
                      MemtoReg_WB<=0;         
                      RegWr_WB<=0;
                      result_WB<=0;
                      dm_dout_WB<=0;
                      Rw_WB<=0; 
                  end 
               else
                  begin             
                      MemtoReg_WB<=MemtoReg_MEM;         
                      RegWr_WB<=RegWr_MEM;
                      result_WB<=result_MEM;
                      dm_dout_WB<=dm_dout_MEM;
                      Rw_WB<=Rw_MEM;       
                  end
           end          
endmodule
