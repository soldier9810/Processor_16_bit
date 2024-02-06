`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.01.2024 17:11:44
// Design Name: 
// Module Name: RISC_Single_Stage_Processor
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


module RISC_Single_Stage_Processor(
    );
    wire [5:0] immediate_value_alu,immediate_value_reg;
    wire clock_enable,clk;
    clock Clock(.clock_enable(clock_enable),.clk(clk)); //clock
    
    wire [5:0] read_address_im,write_address_im;
    wire read_enable_im,write_enable_im;
    wire [15:0] instruction_in_im;
    wire [15:0] instruction_out_im;
    
    memory_instruction instructionMemory(read_address_im, // INSTRUCTION MEMORY
    read_enable_im,
    instruction_in_im, instruction_out_im
    );
    
    wire [5:0] read_address_dm,write_address_dm;
    wire read_enable_dm,write_enable_dm;
    wire [15:0] data_in_dm;
    wire [15:0] data_out_dm;
    
    memory_data dataMemory(read_address_dm,write_address_dm, // DATA MEMORY
    read_enable_dm,write_enable_dm,
    data_in_dm, data_out_dm
    );
    
    wire [15:0] r1_alu,r2_alu;
    wire [4:0] opcode_alu;
    wire  [15:0] accumulator_alu;
    wire carry_alu,overflow_alu,bool_alu,zero_alu;
    
    ALU ( r1_alu,r2_alu,immediate_value_alu, // ARITHEMTIC LOGIC UNIT
      opcode_alu,
       accumulator_alu,
     carry_alu,overflow_alu,bool_alu,zero_alu);
     
    wire [15:0] instruction_in_ir;
    wire [15:0] instruction_out_ir;
     
    instruction_register instructionRegister(clk, instruction_in_ir, // INSTRUCTION REGISTER
    instruction_out_ir);
    
 
  wire   reg_write_en;
  wire   reg_write_dest;
  wire  [15:0] reg_write_data;
 
 wire  [2:0] reg_read_addr_1;
 wire  [15:0] reg_read_data_1;
 
 wire  [2:0] reg_read_addr_2;
 wire  [15:0] reg_read_data_2;
 
 register_module registerModule( // REGISTER
    clk,
    reg_write_en,
     reg_write_dest,
    reg_write_data,
    reg_read_addr_1,
    reg_read_data_1,
   reg_read_addr_2);
  
   
   control_unit controlUnit(
   instruction_out_ir, 
   bool_alu,
   read_address_dm,write_address_dm,
   read_enable_dm,write_enable_dm,
   reg_write_en,
   reg_read_addr_1, reg_read_addr_2, reg_write_dest,
   read_address_im, r2_alu,reg_write_data, 
   immediate_value_alu,immediate_value_reg, clock_enable
   );
   
   assign reg_write_data = (instruction_out_ir[15:14]==2'b00)?accumulator_alu:2'b1;
   
     
endmodule
