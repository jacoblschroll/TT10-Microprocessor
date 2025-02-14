module InSelector(clk, enable, inhibit, zed, ins, addr);
    input clk, enable;
    input inhibit;
    input [2:0] addr;
    input [7:0] ins;

    output reg zed;

    always @ (posedge clk) begin
        if (~enable) begin
            zed <= 1'b0;
        end else if (inhibit) begin
            zed <= 1'b0;
        end else begin
            zed <= ins[addr];
        end
    end
endmodule