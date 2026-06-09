//=========================================================
// 7-Tap Symmetric Pipelined FIR Filter
// Verilog HDL Implementation
//
// Author : Banushree M
// Description:
// High-speed 7-tap FIR filter using
// coefficient symmetry and pipelining.
//
// Coefficients:
// h = [1 2 3 4 3 2 1]
//
//=========================================================

module symmetric_fir_pipeline(
    input clk,
    input rst,
    input signed [7:0] x_in,
    output reg signed [31:0] y_out
);

/////////////////////////////////////////////////
// STAGE 1 : Delay Line
/////////////////////////////////////////////////

reg signed [7:0] x0, x1, x2, x3, x4, x5, x6;

always @(posedge clk)
begin
    if(rst)
    begin
        x0 <= 0;
        x1 <= 0;
        x2 <= 0;
        x3 <= 0;
        x4 <= 0;
        x5 <= 0;
        x6 <= 0;
    end
    else
    begin
        x6 <= x5;
        x5 <= x4;
        x4 <= x3;
        x3 <= x2;
        x2 <= x1;
        x1 <= x0;
        x0 <= x_in;
    end
end

/////////////////////////////////////////////////
// STAGE 2 : Symmetric Pair Addition
/////////////////////////////////////////////////

reg signed [15:0] s0, s1, s2, s3;

always @(posedge clk)
begin
    if(rst)
    begin
        s0 <= 0;
        s1 <= 0;
        s2 <= 0;
        s3 <= 0;
    end
    else
    begin
        s0 <= x0 + x6;
        s1 <= x1 + x5;
        s2 <= x2 + x4;
        s3 <= x3;
    end
end

/////////////////////////////////////////////////
// STAGE 3 : Multiplication
/////////////////////////////////////////////////

parameter h0 = 1;
parameter h1 = 2;
parameter h2 = 3;
parameter h3 = 4;

reg signed [31:0] m0, m1, m2, m3;

always @(posedge clk)
begin
    if(rst)
    begin
        m0 <= 0;
        m1 <= 0;
        m2 <= 0;
        m3 <= 0;
    end
    else
    begin
        m0 <= s0 * h0;
        m1 <= s1 * h1;
        m2 <= s2 * h2;
        m3 <= s3 * h3;
    end
end

/////////////////////////////////////////////////
// STAGE 4 : Final Accumulation
/////////////////////////////////////////////////

always @(posedge clk)
begin
    if(rst)
        y_out <= 0;
    else
        y_out <= m0 + m1 + m2 + m3;
end

endmodule
