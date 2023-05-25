/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: SyncFIFO
** Project Name: AXI4Bus
** Description:
**
** Dependencies:
**
** Revision:
** Revision 0.01 - File Created
** Additional Comments:
*/

`timescale 1ns / 1ps

module SyncFIFO#(
    parameter  WIDTH  = 32,
    parameter  DEPTH  = 4
)(
    input                RESETn,
    input                CLK,

    input    [WIDTH-1:0] WDATA,
    input                WVALID,
    output               WREADY,

    output   [WIDTH-1:0] RDATA,
    output   reg         RVALID,
    input                RREADY
);

reg [DEPTH:0] w_addr;
reg [DEPTH:0] r_addr;
wire          p_RVALID;

assign p_RVALID = (w_addr[DEPTH:0] == r_addr[DEPTH:0]) ? 1'b0 : 1'b1;
assign WREADY   = (w_addr[DEPTH-1:0] == r_addr[DEPTH-1:0]) && (w_addr[DEPTH]^r_addr[DEPTH]) ? 1'b0 : 1'b1;

always @(posedge CLK or negedge RESETn)begin
	if (!RESETn)begin
		w_addr <= 0;
		r_addr <= 0;
		RVALID <= 0;
	end else begin
		if (WVALID & WREADY)begin
			w_addr <= w_addr + 1;
		end
		if (p_RVALID & RREADY)begin
			r_addr <= r_addr + 1;
		end
		RVALID <= p_RVALID;
	end
end

SyncMem #(
	.WIDTH(WIDTH),
	.DEPTH(DEPTH) 
) mem (
	.CLK(CLK),
	.WEN(WREADY&WVALID),
	.REN(p_RVALID),
	.WADDR(w_addr[DEPTH-1:0]),
	.RADDR(r_addr[DEPTH-1:0]),
	.DIN(WDATA),
	.DOUT(RDATA)
);

endmodule
