//Testbench:
module gates_mux_tb;
    reg a, b;
    wire and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out;

    gates_mux dut(
        .a(a), .b(b),
        .and_out(and_out),
        .or_out(or_out),
        .not_out(not_out),
        .nand_out(nand_out),
        .nor_out(nor_out),
        .xor_out(xor_out),
        .xnor_out(xnor_out)
    );
 initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, gates_mux_tb);
$monitor("Time=%0t | a=%b b=%b | AND=%b OR=%b NOT(a)=%b NAND=%b NOR=%b XOR=%b XNOR=%b",
$time, a, b, and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out);
        a = 0; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 0;
        #10 a = 1; b = 1;
        #10 $finish;
    end
endmodule
