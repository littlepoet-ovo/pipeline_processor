`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/29 08:12:54
// Design Name: 
// Module Name: relation_check
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


module relation_check(op_EX,rs_EX,rt_EX,RegWr_MEM,RegWr_WB,
                      Rw_MEM,Rw_WB,ALU_SrcA,ALU_SrcB);
   input [5:0] op_EX;
   input [4:0]rs_EX,rt_EX,Rw_MEM,Rw_WB;
   input RegWr_MEM,RegWr_WB;
   output [1:0] ALU_SrcA,ALU_SrcB;
   wire C1_A,C1_B,C2_A,C2_B;
   assign C1_A=(RegWr_MEM==1 && Rw_MEM!=0 && Rw_MEM==rs_EX)?1:0;
   assign C1_B=(op_EX!=6'b101011 && RegWr_MEM==1 && Rw_MEM!=0 && Rw_MEM==rt_EX)?1:0;
   assign C2_A=(RegWr_WB==1 && Rw_WB!=0 && Rw_MEM!=rs_EX && Rw_WB==rs_EX)?1:0;
   assign C2_B=(op_EX!=6'b101011 && RegWr_WB==1 && Rw_WB!=0 && Rw_MEM!=rt_EX && Rw_WB==rt_EX)?1:0;
   assign ALU_SrcA=C1_A==1?2'b01:(C2_A==1?2'b10:2'b00);
   assign ALU_SrcB=C1_B==1?2'b01:(C2_B==1?2'b10:2'b00);
endmodule

