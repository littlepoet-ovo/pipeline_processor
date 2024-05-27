`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 23:49:35
// Design Name: 
// Module Name: relationcheck
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


module relationcheck(op,Rw_EX,Rw_MEM,RegWr_EX,RegWr_MEM,rs,rt,stall);
   input[5:0]op;
   input [4:0] Rw_EX,Rw_MEM; //写入寄存器的地址
   input RegWr_EX,RegWr_MEM; //寄存器写使能
   input [4:0]  rs,rt;
   output reg stall;  
   wire s1,s2,s3,s4,s5,s6,s7,stall_raw;
   assign s1=(Rw_EX==0)?0:1;
   assign s2=(Rw_MEM==0)?0:1;
   assign s3=(rs==Rw_EX)?1:0;
   assign s4=(rs==Rw_MEM)?1:0;
   assign s5=(rt==Rw_EX)?1:0;
   assign s6=(rt==Rw_MEM)?1:0;
   //||op==6'b101011
   assign s7=(op==6'b000000||op==6'b100011||op==6'b001101||op==6'b001000||op==6'b001001||op==6'b001100||op==6'b001110||op==6'b001010||op==6'b001011||op==6'b101011||op==6'b000100||op==6'b000101)?1:0;
//R型，lw，ori,beq,bne,addi, addiu,andi,xori,sw,slti,sltiu,才有可能冲突
   assign stall_raw =(s1 & s3 & RegWr_EX & s7)|(s2 & s4 & RegWr_MEM & s7)
                |(s1 & s5 & RegWr_EX & s7)|(s2 & s6 & RegWr_MEM & s7);
    always @(*) begin
       if (stall_raw === 1'bx) // 检测到 x 值
           stall = 1'b0;       // 将 stall 设置为 0
       else
           stall = stall_raw;
   end
endmodule

