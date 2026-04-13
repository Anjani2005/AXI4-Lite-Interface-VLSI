module AXI_lite_slave (
    input clk,
    input reset,
    input [3:0] awaddr,
    input awvalid,
    output reg awready,
    input [31:0] wdata,
    input wvalid,
    output reg wready,
    output reg bvalid,
    input bready,
    input [3:0] araddr,
    input arvalid,
    output reg arready,
    output reg [31:0] rdata,
    output reg rvalid,
    input rready
);
reg [31:0] memory [0:15];
always @(posedge clk)
begin
    if (reset) begin
        awready <= 0;
        wready  <= 0;
        bvalid  <= 0;
    end
    else begin
        if (awvalid && wvalid) begin
            memory[awaddr] <= wdata;
            awready <= 1;
            wready  <= 1;
            bvalid  <= 1; 
        end
        else begin
            awready <= 0;
            wready  <= 0;
            bvalid  <= 0;
        end
    end
end
always @(posedge clk)
begin
    if (reset) begin
        arready <= 0;
        rvalid  <= 0;
    end
    else begin
        if (arvalid) begin
            rdata  <= memory[araddr];
            arready <= 1;
            rvalid  <= 1;
        end
        else begin
            arready <= 0;
            rvalid  <= 0;
        end
    end
end

endmodule
