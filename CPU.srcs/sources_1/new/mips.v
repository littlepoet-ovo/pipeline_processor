`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:40:19
// Design Name: 
// Module Name: mips
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


module mips( clk, rst);
   input	clk;
   input	rst;  
   wire [5:0]  op;
   wire [5:0]  func,func_EX;
   wire [31:0] PC, NPC_t,NPC;
   wire [15:0] imm16; 
   wire [25:0] imm26;
   wire [4:0]  imm5,imm5_EX;
   wire [4:0]  rs,rt,rd;
   wire [31:0] Din_WB_t,Din_WB;//送入RF数据端口的值
   wire rezero_EX,RaDst_EX;
   
   
   //使用流水线后增加的连线
   wire [31:0] Branch_addr;
   wire Jump_stall,stall,clear;//beq指令满足跳转条件或j指令时需要清空IF_ID和ID_EX两个流水段寄存器
   //IF/ID
   wire [3:0] PC31_28_IF,PC31_28_ID;
   wire [31:0] PCplus1_IF,PCplus1_ID;
   wire [31:0] im_dout_IF,im_dout_ID;
   
   //ID/EX
   wire [31:0] Jump_addr_ID,Branch_addr_ID;
   wire Jump_ID, MemtoReg_ID, Beq_ID, MemWr_ID, ALUsrc_ID,RegWr_ID,RegDst_ID,rezero_ID,RaDst_ID,JrDst_ID,ExDst_ID;
   wire [1:0] ExtOp_ID;
   wire [3:0]ALUctr_ID;
   wire [31:0] R1_ID,R2_ID,Ext_imm32_ID;
   wire [4:0] Rw_ID;
   wire [31:0] Jump_addr_EX,Branch_addr_EX;
   wire Jump_EX, MemtoReg_EX, Beq_EX, MemWr_EX,RegWr_EX,ALUsrc_EX,JrDst_EX,ExDst_EX;
   wire [3:0] ALUctr_EX;
   wire [5:0] ALUctr_True;
   wire [31:0] R1_EX,R2_EX,Ext_imm32_EX;
   wire [4:0] Rw_EX;
   wire [29:0] sign29;
   wire [31:0] PCplus1_EX;
   
   //EX/MEM
   wire [31:0] ALU_B;
   wire	  Branch,Zero,RaDst_MEM,Zero_t;
   wire[31:0] result_EX_t,result_EX;
   wire  MemtoReg_MEM,MemWr_MEM,RegWr_MEM;
   wire[31:0] result_MEM,R2_MEM;
   wire [4:0] Rw_MEM;
   wire [31:0] PCplus1_MEM;
   //MEM/WB
   wire[31:0] dm_dout_MEM;
   wire MemtoReg_WB,MemWr_WB,RegWr_WB,RaDst_WB;
   wire[31:0] result_WB,dm_dout_WB,PCplus1_WB;
   wire [4:0] Rw_WB_t,Rw_WB;

   mux2 #(32) U_Branch (PCplus1_IF, Branch_addr_EX, Branch, Branch_addr);
   mux2 #(32) U_Jump (Branch_addr,Jump_addr_EX,Jump_EX,NPC_t);
   mux2 #(32) U_Jr(NPC_t,R1_EX,JrDst_EX,NPC);
   PC U_PC (clk, rst,stall, NPC, PC);
   
   assign PCplus1_IF=PC+4;
   
   im_4k U_IM (rst,PC , im_dout_IF);//指令寄存器
   
   assign PC31_28_IF=PC[29:26];
   
   //流水段IF_ID
   IF_ID U_IF_ID(clk,rst,stall,Jump_stall,PC31_28_IF,im_dout_IF,PCplus1_IF,
                PC31_28_ID,PCplus1_ID,im_dout_ID);
   
   assign op = im_dout_ID[31:26];
   assign func = im_dout_ID[5:0];
   assign rs = im_dout_ID[25:21];
   assign rt = im_dout_ID[20:16];
   assign rd = im_dout_ID[15:11];
   assign imm16 = im_dout_ID[15:0];
   assign imm26 = im_dout_ID[25:0];
   assign imm5=im_dout_ID[10:6];
   
   
   ctrl_top U_CTRL (op,func,
       Jump_ID, MemtoReg_ID,
       Beq_ID, MemWr_ID, ALUctr_ID,
       ALUsrc_ID, RegWr_ID, ExtOp_ID, RegDst_ID, rezero_ID, RaDst_ID,JrDst_ID,ExDst_ID
   );  
   //控制器可能还需要增加一些信号，以后再说
   
   mux2 #(5) U_MUX2_RegDst (rt, rd, RegDst_ID, Rw_ID);//目的寄存器选择 RegDst=0选rt,=1选rd,
  
   RF U_RF (rs, rt, Rw_WB, Din_WB, clk,RegWr_WB, R1_ID,R2_ID); 
            
   EXT U_EXT (imm16, ExtOp_ID, Ext_imm32_ID);//立即数带符号或无符号扩展
  
   
  assign sign29={{14{imm16[15]}},imm16};
  assign Branch_addr_ID={PCplus1_ID[31:2]+sign29,2'b00};//生成30位branch跳转地址
  assign Jump_addr_ID={{PC31_28_ID,imm26},2'b00};//生成30位jump跳转地址
  assign clear = Jump_stall | stall;
  
  //流水段ID_EX
  ID_EX U_ID_EX(clk,rst,clear,
               Jump_ID, MemtoReg_ID, Beq_ID, MemWr_ID,ALUsrc_ID,
               RegWr_ID,ALUctr_ID,
               R1_ID,R2_ID,Rw_ID,
               Ext_imm32_ID,Jump_addr_ID,Branch_addr_ID,func,imm5,rezero_ID,RaDst_ID,PCplus1_ID,JrDst_ID,ExDst_ID,//id输入
               Jump_EX, MemtoReg_EX, Beq_EX, MemWr_EX, ALUsrc_EX,
               RegWr_EX,ALUctr_EX,
               R1_EX,R2_EX,Rw_EX,
               Ext_imm32_EX,Jump_addr_EX,Branch_addr_EX,func_EX,imm5_EX,rezero_EX,RaDst_EX,PCplus1_EX,JrDst_EX,ExDst_EX    //ex输出
               );
     
   mux2 #(32) U_MUX2_ALUsrc (R2_EX,Ext_imm32_EX, ALUsrc_EX, ALU_B);//设计图中多路选择器好像画反了
    ALUControl alucontrol(ALUctr_EX,func_EX,ALUctr_True);
    //ALU(A,B,ALUctrl,shamt,Result,ZF);
   ALU U_ALU (R1_EX,ALU_B,ALUctr_True,imm5_EX,result_EX_t, Zero_t);//ALU
   mux2 #(32) U_MUX2_ExDst(result_EX_t,Ext_imm32_EX,ExDst_EX,result_EX);
   assign Zero = rezero_EX?~Zero_t:Zero_t;
   assign Branch=Zero & Beq_EX;
   assign Jump_stall=Branch || Jump_EX;
   // op,Rw_EX,Rw_MEM,RegWr_EX,RegWr_MEM,rs,rt,stall
   relationcheck U_relationcheck(op,Rw_EX,Rw_MEM,RegWr_EX,RegWr_MEM,rs,rt,stall);
   
   //流水段EX_MEM
   EX_MEM  U_EX_MEM(clk,rst,
      MemtoReg_EX,MemWr_EX,RegWr_EX,result_EX, R2_EX,Rw_EX,RaDst_EX,PCplus1_EX,//选择信号，写主存信号，写寄存器信号，ALU计算结果（主存地址），RF的bus2结果（要写入主存内容），寄存器写信号
      MemtoReg_MEM,MemWr_MEM,RegWr_MEM,result_MEM,R2_MEM,Rw_MEM,RaDst_MEM,PCplus1_MEM
   ); 
   // module dm_4k( addr, din, MemWr, clk, dout );
   dm_4k U_DM (result_MEM[11:2], R2_MEM, MemWr_MEM, clk, dm_dout_MEM);//数据存储器
   
    //流水段MEM_WB
   MEM_WB U_MEM_WB(clk,rst,
                 MemtoReg_MEM,RegWr_MEM,result_MEM,dm_dout_MEM,Rw_MEM,RaDst_MEM,PCplus1_MEM,
                 MemtoReg_WB,RegWr_WB,result_WB,dm_dout_WB,Rw_WB_t,RaDst_WB,PCplus1_WB);
   
    
   mux2 #(32) U_MUX2_MemtoReg (result_WB, dm_dout_WB, MemtoReg_WB,Din_WB_t);//回写数据选择:来自数据存储器或ALU_result或PC+4
   mux2 #(32) U_MUX2_RaDst_Data(Din_WB_t,PCplus1_WB,RaDst_WB,Din_WB);
   mux2 #(32) U_MUX2_RaDst_Address(Rw_WB_t,5'b11111,RaDst_WB,Rw_WB);
   
endmodule

