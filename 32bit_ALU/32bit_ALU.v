
module ALU_32bit( A,B, opcode, CarryIn, Result,ZeroFlag,SignFlag,  CarryFlag,OverflowFlag );
  input  [31:0] A, B;
  input  [5:0]  opcode;
    input         CarryIn;
  output reg [31:0] Result;
    output reg ZeroFlag;
    output reg SignFlag;
    output reg CarryFlag;
    output reg OverflowFlag;

    reg [32:0] temp;             // 33-bit for carry tracking
    reg signed [31:0] sA, sB;    // signed numbers

    // Function to detect signed overflow
    function signed_overflow;
        input signed [31:0] x, y, r;
        begin
            signed_overflow = ((x[31] == y[31]) && (r[31] != x[31]));
        end
    endfunction

    always @(*) begin
        // Defaults
        Result       = 32'b0;
        CarryFlag    = 1'b0;
        OverflowFlag = 1'b0;

        sA = A;
        sB = B;

        case (opcode)
            // ---------------- Arithmetic ----------------
            6'b000000: begin // ADD
                temp = A + B;
                Result = temp[31:0];
                CarryFlag = temp[32];
                OverflowFlag = signed_overflow(sA, sB, Result);
            end

            6'b000001: begin // ADC
                temp = A + B + CarryIn;
                Result = temp[31:0];
                CarryFlag = temp[32];
                OverflowFlag = signed_overflow(sA, sB, Result);
            end

            6'b000010: begin // SUB
                temp = A - B;
                Result = temp[31:0];
                CarryFlag = temp[32];
                OverflowFlag = signed_overflow(sA, -sB, Result);
            end

            6'b000011: begin // SBC
                temp = A - B - CarryIn;
                Result = temp[31:0];
                CarryFlag = temp[32];
                OverflowFlag = signed_overflow(sA, -sB, Result);
            end

            6'b000100: begin // INC
                temp = A + 1;
                Result = temp[31:0];
                CarryFlag = temp[32];
                OverflowFlag = signed_overflow(sA, 32'd1, Result);
            end

            6'b000101: begin // DEC
                temp = A - 1;
                Result = temp[31:0];
                CarryFlag = temp[32];
                OverflowFlag = signed_overflow(sA, -32'd1, Result);
            end

            6'b000110: begin // NEG
                temp = -A;
                Result = temp[31:0];
                CarryFlag = temp[32];
                OverflowFlag = signed_overflow(32'd0, -sA, Result);
            end

            // ---------------- Logical ----------------
            6'b001000: Result = A & B;  // AND
            6'b001001: Result = A | B;  // OR
            6'b001010: Result = A ^ B;  // XOR
            6'b001011: Result = ~A;     // NOT

            // ---------------- Shift / Rotate ----------------
            6'b001100: Result = A << B[4:0];  // LSL
         6'b001101: Result = A >> B[4:0];  // LSR

         6'b001110: Result = $signed(A) >>> B[4:0]; // ASR

    6'b001111: Result = (A << B[4:0]) | (A >> ((32 - B[4:0]) & 5'h1F)); // ROL

    6'b010000: Result = (A >> B[4:0]) | (A << ((32 - B[4:0]) & 5'h1F)); // ROR


            // ---------------- Comparison ----------------
            6'b010001: begin // CMP (like SUB, only flags)
                temp = A - B;
                CarryFlag = temp[32];
                OverflowFlag = signed_overflow(sA, -sB, temp[31:0]);
                Result = 32'd0; 
            end

            6'b010010: Result = (sA < sB) ? 32'd1 : 32'd0; // SLT (signed)
            6'b010011: Result = (A < B)  ? 32'd1 : 32'd0; // SLTU (unsigned)

            // ---------------- Pass-through ----------------
            6'b010100: Result = A; // PASS A
            6'b010101: Result = B; // PASS B
            6'b111111: Result = 32'd0; // NOP

            default: begin
                Result = 32'b0;
                CarryFlag = 1'b0;
                OverflowFlag = 1'b0;
            end
        endcase

        // ---------------- Flags ----------------
        ZeroFlag = (Result == 32'b0);
        SignFlag = Result[31];
    end

endmodule