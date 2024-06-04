`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 20:10:07
// Design Name: 
// Module Name: im_4k
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


module im_4k(rst,  addr, dout );
    input wire rst;
    input [31:0] addr;
    output [31:0] dout;

    reg [31:0] imem[4096:3072];

    always @(posedge rst)
    if(rst)
    begin    
        imem[3072]=32'h20010005;//addi $1,$0,5
        imem[3073]=32'h00211020;//add $2,$1,$1
        imem[3074]=32'h08000c04;//j TEST_J
        imem[3075]=32'h00411822;//sub $3,$2,$1
        //TEST_J:
        imem[3076]=32'h00611822;//sub $3,$3,$1
        imem[3077]=32'h00622021;//addu $4,$3,$2
        imem[3078]=32'h00812823;//subu $5,$4,$1
        imem[3079]=32'h00853024;//and $6,$4,$5
        imem[3080]=32'h00c53825;//or $7,$6,$5
        imem[3081]=32'h00e64026;//xor $8,$7,$6
        imem[3082]=32'h01074827;//nor $9,$8,$7
        imem[3083]=32'h10c70001;//beq $6,$7,TEST_BEQ
        imem[3084]=32'h0121502a;//slt $10,$9,$1
        //TEST_BEQ:
        imem[3085]=32'h000a502a;//slt $10,$0,$10
        imem[3086]=32'h0121582b;//sltu $11,$9,$1
        imem[3087]=32'h00096280;//sll $12,$9,10
        imem[3088]=32'h00096a82;//srl $13,$9,10
        imem[3089]=32'h00097283;//sra $14,$9,10
        imem[3090]=32'h00297804;//sllv $15,$9,$1
        imem[3091]=32'h15cf0001;//bne $14,$15,TEST_BNE
        imem[3092]=32'h00298006;//srlv $16,$9,$1
        //TEST_BNE:
        imem[3093]=32'h00308006;//srlv $16,$16,$1
        imem[3094]=32'h00298807;//srav $17,$9,$1
        imem[3095]=32'h24320005;//addiu $18,$1,5
        imem[3096]=32'h32530011;//andi $19,$18 17
        imem[3097]=32'h36540011;//ori $20,$18 17
        imem[3098]=32'h3c150004;//lui $21,4
        imem[3099]=32'h3a560011;//xori $22,$18 17
        imem[3100]=32'hac160004;//sw $22,4($0)
        imem[3101]=32'h8c170004;//lw $23,4($0)
        imem[3102]=32'h0c000c20;//jal TEST_JAL
        imem[3103]=32'h2af80064;//slti $24,$23,100
        //TEST_JAL:
        imem[3104]=32'h2ef90064;//sltiu $25,$23,100
        imem[3105]=32'h03e00008;//jr $31

 
    end

    assign dout = imem[addr[31:2]];

endmodule

