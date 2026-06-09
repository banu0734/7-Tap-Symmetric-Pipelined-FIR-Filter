//=========================================================
// Testbench for 7-Tap Symmetric Pipelined FIR Filter
//
// Author : Banushree M
//
// Description:
// Generates clock, reset, and input stimuli
// for verifying the FIR filter operation.
//
//=========================================================

module tb_symmetric_fir;

    reg clk = 0;
    reg rst;
    reg signed [7:0] x_in;

    wire signed [31:0] y_out;

    // Instantiate DUT
    symmetric_fir_pipeline dut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .y_out(y_out)
    );

    /////////////////////////////////////////////////
    // Clock Generation
    /////////////////////////////////////////////////

    always #5 clk = ~clk;

    /////////////////////////////////////////////////
    // Test Stimulus
    /////////////////////////////////////////////////

    initial
    begin

        rst = 1;
        x_in = 0;

        #12;
        rst = 0;

        // Ramp Input Sequence

        #10 x_in = 1;
        #10 x_in = 2;
        #10 x_in = 3;
        #10 x_in = 4;
        #10 x_in = 5;
        #10 x_in = 6;
        #10 x_in = 7;
        #10 x_in = 8;
        #10 x_in = 9;
        #10 x_in = 10;

        // Keep constant to observe steady state

        #100;

        $finish;

    end

    /////////////////////////////////////////////////
    // Display Output
    /////////////////////////////////////////////////

    always @(negedge clk)
    begin
        $display(
            "time=%0t x=%0d y=%0d",
            $time,
            x_in,
            y_out
        );
    end

endmodule
