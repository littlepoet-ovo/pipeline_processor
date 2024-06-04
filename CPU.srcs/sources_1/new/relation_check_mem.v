`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/29 12:18:52
// Design Name: 
// Module Name: relation_check_mem
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


module relation_check_mem(rt_MEM,Rw_WB,RegWr_WB,Src);
   input [4:0] rt_MEM,Rw_WB;
   input RegWr_WB;
   output Src;
   assign Src = (RegWr_WB==1&&rt_MEM==Rw_WB)?1:0;
endmodule
