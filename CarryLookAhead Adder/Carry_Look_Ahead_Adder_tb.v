//Testbench:
module adder4_tb;
  reg [3:0] A, B;  reg cin;
  wire [3:0] S; wire cout;
  adder4 uut ( .S(S),  .cout(cout),  .A(A), .B(B),  .cin(cin) );
initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, adder4_tb);
    $monitor("Time=%0t | A=%b B=%b cin=%b => S=%b cout=%b", $time, A, B, cin, S, cout);

    // Apply test vectors
    A = 4'b0100; B = 4'b1000; cin = 0; #10;
    A = 4'b0001; B = 4'b0010; cin = 0; #10;
    A = 4'b0101; B = 4'b0011; cin = 1; #10;
    A = 4'b1111; B = 4'b0001; cin = 0; #10;
$finish;
  end 
endmodule
