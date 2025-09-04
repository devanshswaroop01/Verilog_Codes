//8 Bit ALU Design 
module ALU_8bit(A,B,sel,result,carry);
  input [7:0] A, B;
  input [3:0] sel;
  output reg [15:0] result;
  output reg carry;

always @(*) begin
  carry = 0; result = 0;
case (sel)
    4'b0000: {carry, result} = A + B;            // Add
    4'b0001: {carry, result} = A - B;             // Sub
    4'b0010: {carry, result} = A * B;            // Mul
    4'b0011: result = (B != 0) ? A / B : 16'hxxxx; // Division
    4'b0100: result = A & B;                       // AND
    4'b0101: result = A | B;                       // OR
    4'b0110: result = A ^ B;                       // XOR
    4'b0111: result = ~A;                          // NOT A
    4'b1000: result = A << 1;                      // Left Shift
    4'b1001: result = A >> 1;                      // Right Shift
    default: begin result = 0; carry = 0; end
  endcase
end
endmodule

