module fa2 (
  input a,b,c,
  output sum,carry
);

  assign sum = a ^ b ^ c;
  assign carry = (a & b) | ( c & ( a ^ b ) );

endmodule

module fa2_tb (
  output reg a,b,c,
  input sum, carry
);

initial begin
  $monitor($time,,,"a=%b, b=%b, c=%b, sum=%b, carry=%b",a,b,c,sum,carry);
  a=1'b0; b=1'b0; c=1'b0;
  #5 a=1'b0; b=1'b1; c=1'b0;
  #5 a=1'b1; b=1'b0; c=1'b0;
  #5 a=1'b1; b=1'b1; c=1'b0;
  #5 a=1'b0; b=1'b0; c=1'b1;
  #5 a=1'b0; b=1'b1; c=1'b1;
  #5 a=1'b1; b=1'b0; c=1'b1;
  #5 a=1'b1; b=1'b1; c=1'b1;
  #5 $finish;
end

endmodule

module fa2_wb;
  wire a,b,c,sum,carry;
  initial begin
    $dumpfile("fa2.vcd");
    $dumpvars(0,fa2_wb);
  end
  fa2 dut (a,b,c,sum,carry);
  fa2_tb tb (a,b,c,sum,carry);
endmodule
