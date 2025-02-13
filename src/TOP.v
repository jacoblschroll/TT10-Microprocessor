`include "Control Unit/ICU.v"
`include "Program Hardware/COUNTER.v"
`include "Program Hardware/ROM.v"
`include "Data Selection/OutputSelector.v"
`include "Data Selection/InputSelector.v"

module top #(parameter N = 2) (clk, rst, moveIn, outScratch, outSys);
    input clk, rst;
    input [6:0] moveIn;

    output [7:0] outScratch;
    output [7:0] outSys;

    wire [N-1:0] addr;
    wire [7:0] instruction;

    wire [7:0] scratch;
    wire [7:0] out;

    wire zed;
    wire topDataBus;

    wire write, result;

    COUNTER #(.N(2)) programCounter (clk, rst, addr);
    ROM #(.N(2)) programROM (addr, instruction);
    ICU controlUnit(clk, rst, instruction[7:4], zed, write, result);

    OutSelector SysScatch (rst, zed, write, instruction[3], clk, instruction[2:0], outScratch);
    OutSelector SysOut (rst, zed, write, ~instruction[3] & write, clk, instruction[2:0], outSys);

    InSelector SysIn (~clk & ~write & ~instruction[3], 1'b0, zed, {result, moveIn}, instruction[2:0]);
endmodule