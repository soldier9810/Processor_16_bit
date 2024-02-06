`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2024 19:57:34
// Design Name: 
// Module Name: memory_instruction
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


module memory_instruction(
    input [5:0] read_address,write_address,
    input read_enable,
    input [15:0] instruction_in,
    output [15:0] instruction_out
);
    reg [15:0] memory [0:63];
    always @(*) begin
        memory[write_address] <= instruction_in;
    end
    assign instruction_out = (read_enable==1'b1)?memory[read_address]:16'b0;
endmodule
