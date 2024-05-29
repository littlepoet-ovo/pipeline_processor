`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/29 08:17:56
// Design Name: 
// Module Name: mips_t
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


module mips_t( clk, rst );//转发流水线
   input	clk;
   input	rst;  
   wire [5:0]  op;
   wire [5:0]  func;
   wire [29:0] PC, NPC;
   wire [15:0] imm16; 
   wire [25:0] imm26;
   wire [4:0]  rs,rt,rd;
   wire [31:0] Din_WB;//送入RF数据端口的值

   //使用流水线后增加的连线
   wire [29:0] Branch_addr;
   
   //IF/ID
   wire [3:0] PC31_28_IF,PC31_28_ID;
   wire [29:0] PCplus1_IF,PCplus1_ID;
   wire [31:0] im_dout_IF,im_dout_ID;
   wire stall;//Load_use使用
   wire clear;//D/EX流水段寄存器清零
   wire jump_stall;//jump指令和beq指令时跳转使用，IF/ID和ID/EX流水段寄存器清零
   
   //ID/EX
   wire [29:0] Jump_addr_ID,Branch_addr_ID;
   wire Jump_ID, MemtoReg_ID, Beq_ID, MemWr_ID, ALUsrc_ID,RegWr_ID,RegDst_ID;
   wire [1:0] ExtOp_ID;
   wire [2:0]ALUctr_ID;
   wire [31:0] R1_ID,R2_ID,Ext_imm32_ID;
   wire [4:0] Rw_ID;
   wire [29:0] Jump_addr_EX,Branch_addr_EX;
   wire Jump_EX, MemtoReg_EX, Beq_EX, MemWr_EX,RegWr_EX,ALUsrc_EX;
   wire [2:0] ALUctr_EX;
   wire [31:0] R1_EX,R2_EX,Ext_imm32_EX;
   wire [4:0] rs_EX,rt_EX,Rw_EX;
   wire [31:0] sign32;
   
   wire[1:0] ALU_SrcA,ALU_SrcB;//转发控制信号
   wire [31:0] ALU_A_mux3out,ALU_B_mux3out;
   
   //EX/MEM
   wire [31:0] ALU_B;
   wire	  Branch,Zero;
   wire[31:0] result_EX;
   wire  MemtoReg_MEM,MemWr_MEM,RegWr_MEM;
   wire[31:0] result_MEM,R2_MEM;
   wire [4:0] Rw_MEM;
   
   //MEM/WB
   wire[31:0] dm_dout_MEM;
   wire MemtoReg_WB,MemWr_WB,RegWr_WB;
   wire[31:0] result_WB,dm_dout_WB;
   wire [4:0] Rw_WB;

   mux2 #(30) U_Branch ( .d0(PCplus1_IF), .d1(Branch_addr_EX), .s(Branch), .y(Branch_addr));
   
   mux2 #(30) U_Jump (.d0(Branch_addr), .d1(Jump_addr_EX), .s(Jump_EX), .y(NPC));
   
   PC U_PC (
      .clk(clk), .rst(rst),  .NPC(NPC), .PC(PC),.stall(stall)
   ); 
   
   assign PCplus1_IF=PC+1;
   
   im_4k U_IM ( 
      .addr(PC[7:0]) , .Dout(im_dout_IF)
   );
   
   assign PC31_28_IF=PC[29:26];
   
   //流水段IF_ID
   IF_ID U_IF_ID(clk,rst,stall,jump_stall,PC31_28_IF,im_dout_IF,PCplus1_IF,PC31_28_ID,PCplus1_ID,im_dout_ID);
   
   assign op = im_dout_ID[31:26];
   assign func = im_dout_ID[5:0];
   assign rs = im_dout_ID[25:21];
   assign rt = im_dout_ID[20:16];
   assign rd = im_dout_ID[15:11];
   assign imm16 = im_dout_ID[15:0];
   assign imm26 = im_dout_ID[25:0];
   
   load_use_check U_load_use_check(op,MemtoReg_EX,rs,rt,rt_EX,stall);
//load_use冲突检测
   
   ctrl_top U_CTRL (
       .op(op),.func(func), .Jump(Jump_ID), .MemtoReg(MemtoReg_ID),
       .Branch(Beq_ID), .MemWr(MemWr_ID), .ALUctr(ALUctr_ID),
       .ALUsrc(ALUsrc_ID), .RegWr(RegWr_ID), .ExtOp(ExtOp_ID), .RegDst(RegDst_ID)
   );  
   
   mux2 #(5) U_MUX2_RegDst (
      .d0(rt), .d1(rd), .s(RegDst_ID), .y(Rw_ID)
   );//目的寄存器选择 RegDst=0选rt,=1选rd,
  
   RF U_RF (.Ra(rs), .Rb(rt), .Rw(Rw_WB), .Din(Din_WB), .clk(clk),
            .RegWr(RegWr_WB), .R1(R1_ID),.R2(R2_ID),.rst(rst)); 
            
   EXT U_EXT ( 
         .imm16(imm16), .ExtOp(ExtOp_ID), .imm32(Ext_imm32_ID) 
      );//立即数带符号或无符号扩展
  
  assign sign32={{16{imm16[15]}},imm16};
  assign Branch_addr_ID=PCplus1_IF+sign32;//生成30位branch跳转地址
  
  assign Jump_addr_ID={PC31_28_ID,imm26};//生成30位jump跳转地址
  
  //流水段ID_EX
  ID_EX U_ID_EX(clk,rst,clear,
               Jump_ID, MemtoReg_ID, Beq_ID, MemWr_ID, ALUsrc_ID, 
               RegWr_ID,ALUctr_ID,
               R1_ID,R2_ID,rs,rt,Rw_ID,
               Ext_imm32_ID,Jump_addr_ID,Branch_addr_ID,//id输入
               Jump_EX, MemtoReg_EX, Beq_EX, MemWr_EX, ALUsrc_EX,
               RegWr_EX,ALUctr_EX,
               R1_EX,R2_EX,rs_EX,rt_EX,Rw_EX,
               Ext_imm32_EX,Jump_addr_EX,Branch_addr_EX 
               );
     
   mux2 #(32) U_MUX2_ALUsrc (
            .d0(R2_EX), .d1(Ext_imm32_EX), .s(ALUsrc_EX), .y(ALU_B)
             );
             
   mux3 #(32) U_MUX3_ALU_SrcA(.d0(R1_EX), .d1(result_MEM), .d2(Din_WB), 
             .s(ALU_SrcA), .y(ALU_A_mux3out));//数据转发选择 alu_A
                           
   mux3 #(32) U_MUX3_ALU_SrcB(.d0(ALU_B), .d1(result_MEM), .d2(Din_WB), 
              .s(ALU_SrcB), .y(ALU_B_mux3out)); //数据转发选择 alu_B
                                                   
   alu U_ALU ( .A(ALU_A_mux3out), .B(ALU_B_mux3out), 
         .ALUctr(ALUctr_EX), .result(result_EX), .Zero(Zero));
   
   assign Branch=Zero & Beq_EX;
   assign jump_stall=Branch | Jump_EX;
   assign clear=jump_stall | stall;
   
   //流水段EX_MEM
   EX_MEM  U_EX_MEM(clk,rst,
     MemtoReg_EX,MemWr_EX,RegWr_EX,result_EX, R2_EX,Rw_EX,
     MemtoReg_MEM,MemWr_MEM,RegWr_MEM,result_MEM,R2_MEM,Rw_MEM);

     relation_check U_relation_check(rs_EX,rt_EX,RegWr_MEM,RegWr_WB,
Rw_MEM,Rw_WB,ALU_SrcA,ALU_SrcB);    
   
   dm_4k U_DM ( 
      .Addr(result_MEM[9:0]), .Din(R2_MEM), .WE(MemWr_MEM), 
.clk(clk), .Dout(dm_dout_MEM));
   
    //流水段MEM_WB
   MEM_WB U_MEM_WB(clk,rst,MemtoReg_MEM,RegWr_MEM,
result_MEM,dm_dout_MEM,Rw_MEM,
                 MemtoReg_WB,RegWr_WB,result_WB,dm_dout_WB,Rw_WB);
   
   mux2 #(32) U_MUX2_MemtoReg (
         .d0(result_WB), .d1(dm_dout_WB), .s(MemtoReg_WB) , .y(Din_WB)
      );//回写数据选择:来自数据存储器或ALU_result或PC+4
endmodule

