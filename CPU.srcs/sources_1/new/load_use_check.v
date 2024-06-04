`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/29 08:15:06
// Design Name: 
// Module Name: load_use_check
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

module load_use_check(op,MemtoReg_EX,rs,rt,rt_EX,stall);
   input MemtoReg_EX;
   input [4:0] rs,rt,rt_EX;
   input [5:0] op;
   output reg stall;
   wire s1,s2,s3,s4,stall_raw;
   assign s1=(MemtoReg_EX==1)?1:0;
   assign s2=(rt_EX==rs)?1:0;
   assign s3=(rt_EX==rt)?1:0;
   assign s4=(op==6'b000010)?0:1;
   assign stall_raw=s1 & (s2 | s3) & s4;
   always @(*) begin
       if (stall_raw === 1'bx) 
           stall = 1'b0;       
       else
           stall = stall_raw;
   end
endmodule

