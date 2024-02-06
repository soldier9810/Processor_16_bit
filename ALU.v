`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2024 15:51:34
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [15:0] r1,r2,immediate_value_alu,
    input [4:0] opcode,
    output reg [15:0] accumulator,
    output reg carry,overflow,bool,zero
    );
    
    always @(*) begin
        case (opcode)
            5'b00000: {carry,accumulator} <= r1 + r2;
            5'b00001: {carry,accumulator} <= r1 + immediate_value_alu; //immediate
            5'b00010: accumulator <= r1 - r2;
            5'b00011: accumulator <= r1 - immediate_value_alu; //immediate
            5'b00100: accumulator <= r1*r2;
            5'b00101: bool <= (r1>r2)?1:0;
            5'b00110: bool <= (r1>immediate_value_alu)?1:0; // immediate
            5'b00111: bool <= (r1==immediate_value_alu)?1:0; // immediate
            5'b01000: bool <= (r1==r2)?1:0; 
            5'b01001: accumulator <= r1<<r2;
            5'b01010: accumulator <= r1>>r2;
            5'b01011: accumulator <= r1&r2;
            5'b01100: accumulator <= r1|r2;
            5'b01101: accumulator <= r1^r2;
            5'b01110: accumulator <= r1^16'b1111111111111111;
        endcase
        
        if (accumulator == 0) zero <= 1'b1;
        else zero <= 1'b0;
    end
endmodule
