`include "jkff.v"

module jkff_testbench(output wire j, k, clk, input wire q, qbar);
initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  $monitor("Time=%d, j=%b, k=%b, clk=%b => q=%b, qbar=%b", $time, j, k, clk, q, qbar);
  #10 j = 0, k = 0;
  for (int i = 0; i < 16; i++) begin
    if (i % 2 == 0) begin
      #10 k = ~(k);
    end else begin
      #10 j = ~(j);
    end
  end

  #10 $finish;
end

endmodule

module jkff_workbench;
wire j, k, clk, q, qbar;

initial begin
  jkff dut(j, k, clk, q, qbar);
  jkff_testbench testbench(j, k, clk, q, qbar);
end

initial begin
  $dumpfile("jkff.vcd");
  $dumpvars(0, jkff_workbench);
end
  
endmodule
