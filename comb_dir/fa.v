module ha(
    input a, b,
    output sum, carry
);

assign sum = b ^ a;
assign carry = b & a;

endmodule

module fa(
  input a, b, cin,
  output sum, carry
);

wire s, c1, c2;

ha h1(a, b, s, c1);
ha h2(s, cin, sum, c2);

assign carry = c1 | c2;

endmodule

module fatb(
  output reg a, b, cin,
  input sum, carry
);

initial begin
  $monitor($time,,,"a = %b, b = %b, cin = %b, sum = %b, carry = %b", a, b, cin, sum, carry);
  a = 1'b0; b = 1'b0; cin = 1'b0;
  #5 a = 1'b1; b = 1'b0; cin = 1'b0;
  #5 a = 1'b0; b = 1'b1; cin = 1'b0;
  #5 a = 1'b1; b = 1'b1; cin = 1'b0;
  #5 a = 1'b0; b = 1'b0; cin = 1'b1;
  #5 a = 1'b1; b = 1'b0; cin = 1'b1;
  #5 a = 1'b0; b = 1'b1; cin = 1'b1;
  #5 a = 1'b1; b = 1'b1; cin = 1'b1;
  #5 $finish;
end

endmodule

module fawb;
  wire a, b, cin, sum, carry;
  initial begin
    $dumpfile("fa.vcd");
    $dumpvars(0,fawb);
  end
  fa dut(a, b, cin, sum, carry);
  fatb tb(a, b, cin, sum, carry);
endmodule
