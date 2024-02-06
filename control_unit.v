`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2024 16:52:53
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [15:0] instruction,
    input alu_bool,
    output reg [5:0] read_data_memory,write_data_memory,
    output reg memory_read_enable, memory_write_enable,
    output reg register_write_enable, 
    output reg [2:0] r1_read_address, r2_read_address, register_write_address,
    output reg [5:0] pc_address,
    output reg [5:0] immediate_value_alu,
    output reg[5:0] immediate_value_reg,
    output reg clock_enable
    );
    wire [1:0] type;
    wire [4:0] opcode;
    assign type = instruction[15:14];
    assign opcode = instruction[13:9];
    always @(*) begin
        memory_read_enable =0;
        memory_write_enable =0;
        register_write_enable =0;
         case (type)
          2'b00: begin
            clock_enable <= 1;
            register_write_enable <= 1'b1;
            register_write_address <= instruction[8:6];
            r1_read_address <= instruction[5:3];
            r2_read_address <= instruction[2:0];
          end
          2'b01: begin
            clock_enable <= 1;
            casex (opcode)
                5'b000x1: begin // Add Subtract ALU
                    register_write_address <= instruction[8:6];
                    immediate_value_alu <= instruction[5:0];
                end
                5'b0011x: begin // compare ALU
                    register_write_address <= instruction[8:6];
                    immediate_value_alu <= instruction[5:0];
                end
                5'b01111: begin // load
                     register_write_enable <= 1'b1;
                     memory_read_enable <= 1'b1;
                     register_write_address <= instruction[8:6];
                     read_data_memory <= instruction[5:0];
                end
                5'b10000: begin // load immediately
                     register_write_enable <= 1'b1;
                     register_write_address <= instruction[8:6];
                     immediate_value_reg <= instruction[5:0];
                end
                5'b10001: begin //store
                     memory_write_enable <=1'b1;
                     r1_read_address <= instruction[8:6];
                     write_data_memory <= instruction[5:0];
                end
                
            endcase
            pc_address <= pc_address + 1'b1;
          end
          2'b10: begin
            clock_enable <= 1;
            case (opcode)
                5'b10010: begin // jump
                    pc_address <=instruction[8:3];
                end
                5'b10011: pc_address <= (alu_bool==1)? instruction[8:3]:pc_address+1'b1; // branch
            endcase
          end
          2'b11: clock_enable <= 0;
         endcase
    end
endmodule
