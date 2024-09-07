// file: srlatch_simul.v
// Using a testbench and workbench to simulate our module
`include "srlatch.v"
module srlatch_tb(
  output reg s, r, 
  input wire q, q_not
);

integer x;

initial begin
  // case 1 (latch w/o state)
  s=0; r=0; #1
  $display("s=%b, r=%b ==> q=%b, q_not=%b # should be undefined",
    s, r, q, q_not);

  // case 2 (reset)
  s=0; r=1; #1
  $display("s=%b, r=%b ==> q=%b, q_not=%b # reset, so q=0",
    s, r, q, q_not);

  // case 3 (set)
  s=1; r=0; #1
  $display("s=%b, r=%b ==> q=%b, q_not=%b # set, so q=1",
    s, r, q, q_not);

  // case 4 (latch with state)
  s=0; r=0; #1
  $display("s=%b, r=%b ==> q=%b, q_not=%b # latch, so q=q (keep state)",
    s, r, q, q_not);

  // case 5 (invalid state)
  s=1; r=1; #1
  $display("s=%b, r=%b ==> q=%b, q_not=%b # invalid state, so discount error",
    s, r, q, q_not);
  #1 $finish;
end 

endmodule

module srlatch_wb;
wire s, r, q, q_not;

// instantiate our module

sr_latch latch(s, r, q, q_not);
srlatch_tb testbench(s, r, q, q_not);

initial begin
  // for waveform analysis
  $dumpfile("srlatch.vcd");
  $dumpvars(0, srlatch_wb);

end

endmodule
