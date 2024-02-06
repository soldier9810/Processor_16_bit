`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 16:50:37
// Design Name: 
// Module Name: instruction_register
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


module instruction_register(
    input clk,
    input [15:0] instruction_in,
    output [15:0] instruction_out
    );
    reg current_instruction;
    always@ (posedge clk) begin
        current_instruction <= instruction_in;
    end
    assign instruction_out = current_instruction;
endmodule
