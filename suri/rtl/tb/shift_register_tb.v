`timescale 1ns/1ps

module shift_register_tb;

    reg clk;
    reg rst;

    reg [1:0] mode;

    reg serial_in_left;
    reg serial_in_right;

    reg [7:0] parallel_in;

    wire [7:0] q;

    shift_register #(
        .WIDTH(8)
    ) dut (
        .clk(clk),
        .rst(rst),

        .mode(mode),

        .serial_in_left(serial_in_left),
        .serial_in_right(serial_in_right),

        .parallel_in(parallel_in),

        .q(q)
    );

    // 50 MHz clock
    always #10 clk = ~clk;


    // Display register value
    task display_value;
        input [127:0] operation;

        begin
            #1;

            $display(
                "TIME=%0t ns | %-20s | Q = %08b | HEX = 0x%02h",
                $time,
                operation,
                q,
                q
            );
        end
    endtask


    initial begin

        $dumpfile("shift_register.vcd");
        $dumpvars(0, shift_register_tb);

        clk = 1'b0;
        rst = 1'b1;

        mode = 2'b00;

        serial_in_left  = 1'b0;
        serial_in_right = 1'b0;

        parallel_in = 8'h00;

        // Reset
        #50;

        rst = 1'b0;

        display_value("RESET");


        // -----------------------------------------
        // Parallel Load
        // -----------------------------------------

        @(posedge clk);

        parallel_in = 8'b10101010;
        mode = 2'b11;

        @(posedge clk);

        display_value("PARALLEL LOAD");


        // -----------------------------------------
        // Shift Right
        // -----------------------------------------

        mode = 2'b01;

        serial_in_left = 1'b1;

        @(posedge clk);
        display_value("SHIFT RIGHT");

        @(posedge clk);
        display_value("SHIFT RIGHT");

        @(posedge clk);
        display_value("SHIFT RIGHT");


        // -----------------------------------------
        // Shift Left
        // -----------------------------------------

        mode = 2'b10;

        serial_in_right = 1'b0;

        @(posedge clk);
        display_value("SHIFT LEFT");

        @(posedge clk);
        display_value("SHIFT LEFT");

        @(posedge clk);
        display_value("SHIFT LEFT");


        // -----------------------------------------
        // Hold
        // -----------------------------------------

        mode = 2'b00;

        @(posedge clk);
        display_value("HOLD");

        @(posedge clk);
        display_value("HOLD");


        // -----------------------------------------

        $display("----------------------------------------");
        $display("       SIMULATION COMPLETE");
        $display("----------------------------------------");

        #100;

        $finish;

    end

endmodule