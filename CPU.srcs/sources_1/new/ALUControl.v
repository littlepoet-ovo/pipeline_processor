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
	input wire [2:0] ALUop;
	input wire [5:0] func;
	output reg [5:0]ALUCtr;
    always @(*)begin
        if (ALUop == 3'b000) begin
            ALUCtr <= func;
        end
        else if(ALUop == 3'b001) begin //带符号加法
            ALUCtr <= 6'b100000;
        end
        else if(ALUop == 3'b010) begin // 带符号减法
            ALUCtr <= 6'b100010;
        end
        else if(ALUop == 3'b011) begin//异或
            ALUCtr <= 6'b100110;
        end
        else if(ALUop ==3'b100) begin//逻辑或
            ALUCtr <=6'b100101;
        end
        else if(ALUop ==3'b101) begin//无符号加法
            ALUCtr <=6'b100001;
        end
        else if(ALUop ==3'b110) begin//与立即数
            ALUCtr <=6'b100100;
        end
        else if(ALUop ==3'b111) begin//无符号减法
            ALUCtr <=6'b100011;        
        end
    end
endmodule



