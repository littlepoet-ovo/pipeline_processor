`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/15 09:25:10
// Design Name: 
// Module Name: ctrl_top
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
//op,func,ALUOp,RegDst,ALUsrc,MemtoReg,MemWrite,RegWrite,Branch,Jump,Extop,rezero,RaDst,JrDst,SfDst,ExDst
//未使用：RaDst,JrDst,SfDst,ExDst
module ctrl_top(op,func,Jump,MemtoReg,Branch,MemWrite,ALUOp,ALUsrc,RegWrite,Extop,RegDst,rezero);
    input [5:0] op;
    input [5:0] func;
    output reg [3:0] ALUOp;
    output reg RegDst;
    output reg ALUsrc;
    output reg MemtoReg;
    output reg MemWrite;
    output reg RegWrite;
    output reg Branch;
    output reg Jump;
    output reg [1:0] Extop;
    output reg rezero;//为1则对zero信号进行反转，实现beq功能！
     reg RaDst;
     reg JrDst;
     reg SfDst;
     reg ExDst;
    always @(*)begin
        case(op)
            6'b000000: begin //R指令
                if(func!=6'b001000&&func!=6'b101010&&func!=6'b101011) begin
                    ALUOp <= 4'b0000;
                    RegDst <= 1'b1;
                    ALUsrc <= 1'b0;
                    MemtoReg <= 1'b0;
                    MemWrite <= 1'b0;
                    RegWrite <= 1'b1;
                    Branch <= 1'b0;
                    Jump <= 1'b0;
                    Extop <= 2'bxx;
                    RaDst <= 1'b0;
                    JrDst <= 1'b0;
                    SfDst <= 1'b1;
                    ExDst <= 1'b0;
                end 
                else if(func==6'b001000) begin//jr
                    ALUOp <= 4'bxxxx;
                    RegDst <= 1'bx;
                    ALUsrc <= 1'bx;
                    MemtoReg <= 1'bx;
                    MemWrite <= 1'b0;
                    RegWrite <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 1'b0;
                    Extop <= 2'bxx;
                    RaDst <= 1'b0;
                    JrDst <= 1'b1;
                    SfDst <= 1'b1;
                    ExDst <= 2'b00;
                end
                else if(func==6'b101010) begin//slt
                    ALUOp <= 4'b0010;
                    RegDst <= 1'b1;
                    ALUsrc <= 1'b0;
                    MemtoReg <= 1'b0;
                    MemWrite <= 1'b0;
                    RegWrite <= 1'b1;
                    Branch <= 1'b0;
                    Jump <= 1'b0;
                    Extop <= 2'bxx;                                                                                 
                    RaDst <= 1'b0;
                    JrDst <= 1'b0;
                    SfDst<=1'b0;
                    ExDst <= 1'b0;
                end else if(func==6'b101011) begin//sltu
                    ALUOp <= 4'b0111;
                    RegDst <= 1'b1;
                    ALUsrc <= 1'b0;
                    MemtoReg <= 1'b0;
                    MemWrite <= 1'b0;
                    RegWrite <= 1'b1;
                    Branch <= 1'b0;
                    Jump <= 1'b0;
                    Extop <= 2'bxx;
                    RaDst <= 1'b0;
                    JrDst <= 1'b0;
                    SfDst<=1'b0;
                    ExDst <= 1'b0;
                end
            end
            6'b001000:begin// addi
                ALUOp <= 4'b0001;
                RegDst <= 1'b0;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b01;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b100011:begin// lw
                ALUOp <= 4'b0001;
                RegDst <= 1'b0;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'b1;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b01;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b101011:begin// sw
                ALUOp <= 4'b0001;
                RegDst <= 1'bx;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'bx;
                MemWrite <= 1'b1;
                RegWrite <= 1'b0;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b01;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b000100:begin// beq
                ALUOp <= 4'b0010;
                RegDst <= 1'bx;
                ALUsrc <= 1'b0;
                MemtoReg <= 1'bx;
                MemWrite <= 1'b0;
                RegWrite <= 1'b0;
                Branch <= 1'b1;
                Jump <= 1'b0;
                Extop <= 2'bxx;
                rezero <= 0;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b000010:begin// j
                ALUOp <= 4'bxxxx;
                RegDst <= 1'bx;
                ALUsrc <= 1'bx;
                MemtoReg <= 1'bx;
                MemWrite <= 1'b0;
                RegWrite <= 1'b0;
                Branch <= 1'b0;
                Jump <= 1'b1;
                Extop <= 2'bxx;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b000101:begin // bne
                ALUOp <= 4'b0010;
                RegDst <= 1'bx;
                ALUsrc <= 1'b0;
                MemtoReg <= 1'bx;
                MemWrite <= 1'b0;
                RegWrite <= 1'b0;
                Branch <= 1'b1;
                Jump <= 1'b0;
                Extop <= 2'bxx;
                rezero <= 1;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b001110:begin// xori
                ALUOp <= 4'b0011;
                RegDst <= 1'b0;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b00;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
             6'b001101:begin// ori
                ALUOp <= 4'b0100;
                RegDst <= 1'b0;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b00;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b001001:begin// addiu
                ALUOp <= 4'b0101;
                RegDst <= 1'b0;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b01;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b000011:begin//jal
                ALUOp <= 4'bxxxx;
                RegDst <= 1'bx;
                ALUsrc <= 1'bx;
                MemtoReg <= 1'bx;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b1;
                Extop <= 2'bxx;
                RaDst <= 1'b1;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
            6'b001010:begin//slti
                ALUOp <= 4'b0010;
                RegDst <= 1'b0;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b01;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b0;
                ExDst <= 1'b0;
            end
            6'b001111:begin//lui
                ALUOp <= 4'bxxxx;
                RegDst <= 1'b0;
                ALUsrc <= 1'bx;
                MemtoReg <= 1'bx;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b10;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b1;
            end
            6'b001100:begin//andi
                ALUOp <= 4'b0110;
                RegDst <= 1'b0;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 1'b0;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b1;
                ExDst <= 1'b0;
            end
             6'b001011:begin//sltiu
                ALUOp <= 4'b0010;
                RegDst <= 1'b0;
                ALUsrc <= 1'b1;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                RegWrite <= 1'b1;
                Branch <= 1'b0;
                Jump <= 1'b0;
                Extop <= 2'b00;
                RaDst <= 1'b0;
                JrDst <= 1'b0;
                SfDst <= 1'b0;
                ExDst <= 1'b0;
            end                   
        endcase
    end
endmodule
