//Testbench :
module encoder4x2_tb;
  reg [3:0] in;          
  wire [1:0] out;      
encoder4x2 DUT(in, out); 
  
  initial begin 
    $dumpfile("waveform.vcd");      
    $dumpvars(0, encoder4x2_tb);       
 $monitor("Time = %0t, in = %b, out = %b", $time, in, out);
    
    in = 4'b0001; #10;
    in = 4'b0010; #10;
    in = 4'b0100; #10;
    in = 4'b1000; #10;

    $finish;
  end
endmodule   