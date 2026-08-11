`timescale 1ns/1ps

module shift_register #(
    parameter WIDTH = 8
)(
    input                  clk,
    input                  rst,

    // Operation select
    // 00 = Hold
    // 01 = Shift Right
    // 10 = Shift Left
    // 11 = Parallel Load
    input  [1:0]            mode,

    input                  serial_in_left,
    input                  serial_in_right,

    input  [WIDTH-1:0]      parallel_in,

    output reg [WIDTH-1:0]  q
);

    always @(posedge clk) begin

        if (rst) begin
            q <= {WIDTH{1'b0}};
        end

        else begin

            case (mode)

                // Hold
                2'b00: begin
                    q <= q;
                end

                // Shift Right
                // New bit enters from MSB
                2'b01: begin
                    q <= {serial_in_left, q[WIDTH-1:1]};
                end

                // Shift Left
                // New bit enters from LSB
                2'b10: begin
                    q <= {q[WIDTH-2:0], serial_in_right};
                end

                // Parallel Load
                2'b11: begin
                    q <= parallel_in;
                end

                default: begin
                    q <= q;
                end

            endcase
        end
    end

endmodule