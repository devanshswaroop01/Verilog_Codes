//Testbench:
module encoder8x3_tb;
  reg [7:0] in;          
  wire [2:0] out;        
encoder8x3 DUT(in, out); 

  initial begin 
    $dumpfile("waveform.vcd");      
    $dumpvars(0, encoder8x3_tb);       
$monitor("Time = %0t, in = %b, out = %b", $time, in, out);

    in = 8'b00000001; #10;
    in = 8'b00000010; #10;
    in = 8'b00000100; #10;
    in = 8'b00001000; #10;
    in = 8'b00010000; #10;
    in = 8'b00100000; #10;
    in = 8'b01000000; #10;
    in = 8'b10000000; #10;

    $finish;
  end
endmodule