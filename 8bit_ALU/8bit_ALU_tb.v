//Testbench:
module ALU_8bit_tb;
reg [7:0] A, B;
  reg [3:0] sel;
  wire [15:0] result;
  wire carry;
ALU_8bit uut (.A(A), .B(B), .sel(sel), .result(result), .carry(carry) );

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, ALU_8bit_tb);
    $display("Time\tA\tB\tSel\tResult\t\tCarry");
 $monitor("%0t\t%0d\t%0d\t%b\t%h\t%b", $time, A, B, sel, result, carry);

    A = 8'd10; B = 8'd5;
    sel = 4'b0000; #10;  // Add
    sel = 4'b0001; #10;  // Subtract
    sel = 4'b0010; #10;  // Multiply
    sel = 4'b0011; #10;  // Divide
    sel = 4'b0100; #10;  // AND
    sel = 4'b0101; #10;  // OR
    sel = 4'b0110; #10;  // XOR
    sel = 4'b0111; #10;  // NOT A
    sel = 4'b1000; #10;  // Left shift A
    sel = 4'b1001; #10;  // Right shift A
 $finish;
end
endmodule