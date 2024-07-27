module ha(
    input a, b,
    output sum, carry
);

assign sum = b ^ a;
assign carry = b & a;

endmodule

module hatb(
  output reg a, b,
  input sum, carry
);

initial begin
  $monitor($time,,,"a = %b, b = %b, sum = %b, carry = %b", a, b, sum, carry);
  a = 1'b0; b = 1'b0;
  #5 a = 1'b1; b = 1'b0;
  #5 a = 1'b0; b = 1'b1;
  #5 a = 1'b1; b = 1'b1;
  #5 $finish;
end

endmodule

module hawb;
  wire a, b, sum, carry;
  initial begin
    $dumpfile("ha.vcd");
    $dumpvars(0,hawb);
  end
  ha dut(a, b, sum, carry);
  hatb tb(a, b, sum, carry);
endmodule
