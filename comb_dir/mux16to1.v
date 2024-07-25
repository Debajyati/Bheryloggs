module mux4bto1s(
  input [3:0] in,
  input [1:0] sel,
  output out
);

wire [3:0] wire_in;

assign wire_in[0] = (~sel[0]) & (~sel[1]) & (in[0]);
assign wire_in[1] = (~sel[0]) & (sel[1]) & (in[1]);
assign wire_in[2] = (sel[0]) & (~sel[1]) & (in[2]);
assign wire_in[3] = (sel[0]) & (sel[1]) & (in[3]);

assign out = wire_in[0] | wire_in[1] | wire_in[2] | wire_in[3];

endmodule

module mux16to1(
  input [15:0] in,
  input [3:0] sel,
  output out
);

wire [3:0] wire_in;

mux4bto1s mux4bto1s_0(
  .in(in[3:0]),
  .sel(sel[1:0]),
  .out(wire_in[0])
);

mux4bto1s mux4bto1s_1(
  .in(in[7:4]),
  .sel(sel[1:0]),
  .out(wire_in[1])
);

mux4bto1s mux4bto1s_2(
  .in(in[11:8]),
  .sel(sel[1:0]),
  .out(wire_in[2])
);

mux4bto1s mux4bto1s_3(
  .in(in[15:12]),
  .sel(sel[1:0]),
  .out(wire_in[3])
);

mux4bto1s internal_mux4bto1s(
  .in(wire_in[3:0]),
  .sel(sel[3:2]),
  .out(out)
);

endmodule

module tb_mux16to1(
  output reg [15:0] in,
  output reg [3:0] sel,
  input out
);
  initial begin
    $monitor ($time,,,"in=%b sel=%b => out=%b",in,sel,out);
    in=16'b0;
    sel=4'b0;
    #5 in=16'b1010110110010010;
    #5 sel=4'b1111;
    #5 sel=4'b1110;
    #5 sel=4'b1100;
    #5 sel=4'b1000;
    #5 sel=4'b0100;
    #5 sel=4'b0010;
    #5 sel=4'b0001;
    #5 $finish;
  end
endmodule

module wb; 
  wire [15:0] in;
  wire [3:0] sel;
  wire out;
  initial begin
    $dumpfile("mux16to1.vcd");
    $dumpvars(0,wb);
  end
  mux16to1 dut (in,sel,out);
  tb_mux16to1 tb (in,sel,out);
endmodule
