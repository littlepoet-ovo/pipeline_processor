`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 20:23:22
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(ALUop,func,ALUCtr);
	input wire [3:0] ALUop;
	input wire [5:0] func;
	output reg [5:0]ALUCtr;
    always @(*)begin
        if (ALUop == 4'b0000) begin
            ALUCtr <= func;
        end
        else if(ALUop == 4'b0001) begin //�����żӷ�
            ALUCtr <= 6'b100000;
        end
        else if(ALUop == 4'b0010) begin // �����ż���
            ALUCtr <= 6'b100010;
        end
        else if(ALUop == 4'b0011) begin//���
            ALUCtr <= 6'b100110;
        end
        else if(ALUop ==4'b0100) begin//�߼���
            ALUCtr <=6'b100101;
        end
        else if(ALUop ==4'b0101) begin//�޷��żӷ�
            ALUCtr <=6'b100001;
        end
        else if(ALUop ==4'b0110) begin//��������
            ALUCtr <=6'b100100;
        end
        else if(ALUop ==4'b0111) begin//�޷��ż���
            ALUCtr <=6'b100011;        
        end
        else if(ALUop ==4'b1000) begin//slt IF A<B RETURN 1
            ALUCtr <=6'b101010;   
        end
        else if(ALUop ==4'b1001) begin//sltu IF A<B RETURN 1
            ALUCtr <=6'b101011;   
        end
    end
endmodule



