module DFlipFlop (
    input wire clk,  // Clock input
    input wire D,    // Data input
    output reg Q     // Data output
);

always @(posedge clk) begin
    Q <= D;
end

endmodule

