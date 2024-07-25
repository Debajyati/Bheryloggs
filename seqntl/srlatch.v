module SRLatch (
    input wire S,  // Set input
    input wire R,  // Reset input
    output reg Q   // Data output
);

always @* begin
    if (S && !R)
        Q <= 1;
    else if (!S && R)
        Q <= 0;
    // if both S and R are low, Q retains its value
end

endmodule

