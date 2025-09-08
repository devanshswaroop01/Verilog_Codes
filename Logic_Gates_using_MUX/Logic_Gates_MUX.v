//Design Logic Gates using MUX  
// 2-to-1 Multiplexer Module
module mux_2_1(
    input [1:0] i,
    input select,
    output y_out    );
    assign y_out = select ? i[1] : i[0];
endmodule

// Logic Gates implemented using only MUXes
module gates_mux(
    input a, b,
    output and_out, or_out, not_out,
    nand_out, nor_out, xor_out, xnor_out );
 wire bbar;
 mux_2_1 mbbar({1'b1, 1'b0}, b, bbar);       // Select=0 => 1, Select=1 => 0 // NOT b => bbar
 mux_2_1 mand({1'b0, b}, a, and_out);        // AND
 mux_2_1 mor({b, 1'b1}, a, or_out);         // OR

mux_2_1 mnot({1'b1, 1'b0}, a, not_out);     // NOT a
mux_2_1 mnand({1'b1, bbar}, a, nand_out);   // NAND
mux_2_1 mnor({bbar, 1'b0}, a, nor_out);     // NOR

mux_2_1 mxor({b, bbar}, a, xor_out);        // XOR
mux_2_1 mxnor({bbar, b}, a, xnor_out);      // XNOR
  
endmodule




