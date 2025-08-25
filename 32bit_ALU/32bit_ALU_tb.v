`timescale 1ns/1ps
module ALU_32bit_tb;

  reg [31:0] A, B;
  reg [5:0]  opcode;
  reg        CarryIn;
  wire [31:0] Result;
  wire ZeroFlag, SignFlag, CarryFlag, OverflowFlag;
  ALU_32bit uut (
A, B, opcode, CarryIn, Result, ZeroFlag, SignFlag, CarryFlag, OverflowFlag);


  initial begin
   
    $dumpfile("waveform.vcd");
    $dumpvars(0, ALU_32bit_tb);
     $monitor("%4t | opcode=%06b | A=%4d | B=%4d | Result=%10d | CI=%b | CF=%b | ZF=%b | SF=%b | OF=%b",
             $time, opcode, A, B, Result, CarryIn, CarryFlag, ZeroFlag, SignFlag, OverflowFlag);

    A = 32'd10;
    B = 32'd5;
    CarryIn = 1'b0;

    opcode = 6'b000000; #10; // ADD
    opcode = 6'b000001; #10; // SUB
    opcode = 6'b000010; #10; // AND
    opcode = 6'b000011; #10; // OR
    opcode = 6'b000100; #10; // XOR
    opcode = 6'b000101; #10; // NOT
    opcode = 6'b000111; #10; // Shift Left
    opcode = 6'b001000; #10; // Shift Right
    opcode = 6'b001001; #10; // Rotate Left
    opcode = 6'b001010; #10; // Rotate Right
    opcode = 6'b001011; #10; // Compare
    opcode = 6'b001100; #10; // Increment
    opcode = 6'b001101; #10; // Decrement
    opcode = 6'b001110; #10; // Pass A
    opcode = 6'b001111; #10; // Pass B
    opcode = 6'b010000; #10; // NAND
    opcode = 6'b010001; #10; // NOR
    opcode = 6'b010010; #10; // XNOR
    opcode = 6'b010011; #10; // Clear
    opcode = 6'b010100; #10; // Set
    opcode = 6'b111111; #10; // Custom opcode (test)

    #10 $finish;
  end
endmodule
