module jkff(input wire j, k, clk, output wire q, qbar);

inout wire a, b;

assign a = j ~& clk ~& qbar;
assign b = k ~& clk ~& q;

assign q = a ~& qbar;
assign qbar = b ~& q;

endmodule

