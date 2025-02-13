/*
 * Copyright (c) 2024 Jacob Schroll
 * SPDX-License-Identifier: Apache-2.0
 */

`include "TOP.v"

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  top #(.N(2)) Processor(clk, ~rst_n, ui_in[7:1], uo_out, uio_out);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_oe  = 01;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[0], uio_in[7:0], 1'b0};

endmodule
