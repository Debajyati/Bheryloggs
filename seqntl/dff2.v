module DFlipFlop (
    input wire clk,  // Clock input
    input wire D,    // Data input
    output reg Q     // Data output
);

always @(posedge clk) begin
    Q <= D;
end

endmodule

//`timescale 1ns/1ps

module DFlipFlop_wb;

    // Internal signals
    reg clk;
    reg D;
    wire Q;

    // Instantiate the DFlipFlop module
    DFlipFlop uut (
        .clk(clk),
        .D(D),
        .Q(Q)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        D = 0;
        $monitor("Time = %d, clk = %b, D = %b, Q = %b", $time, clk, D, Q);

        // Apply test vectors
        #10 D = 1;
        #10 D = 0;
        #10 D = 1;
        #10 D = 0;
        #10 D = 1;
        #10 D = 0;
        #10 D = 1;

        // End simulation after some time
        #10 $finish;
    end

    // Monitor outputs
    initial begin
        $dumpfile("DFlipFlop.vcd");
        $dumpvars(0, DFlipFlop_wb);
    end

endmodule

