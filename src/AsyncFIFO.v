/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: AsyncFIFO
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

module AsyncFIFO#(
    parameter  WIDTH  = 32,
    parameter  DEPTH  = 4,
    parameter  STAGES = 2
)(

    input                WRESETn,
    input                WCLK,
    input    [WIDTH-1:0] WDATA,
    input                WVALID,
    output               WREADY,

    input                RRESETn,
    input                RCLK,
    output   [WIDTH-1:0] RDATA,
    output               RVALID,
    input                RREADY
);

reg  [DEPTH:0] w_index;
reg  [DEPTH:0] w_index_g;
wire [DEPTH:0] wr_index_g;

assign WREADY = ((w_index_g[DEPTH:0] ^ wr_index_g[DEPTH:0]) == (2'b11 << (DEPTH-1))) ? 1'b0 : 1'b1;


reg  [DEPTH:0] r_index;
reg  [DEPTH:0] r_index_g;
wire [DEPTH:0] rw_index_g;

assign RVALID = (r_index_g[DEPTH:0] == rw_index_g[DEPTH:0]) ? 1'b0 : 1'b1;

always @(posedge WCLK or negedge WRESETn)begin
	if (!WRESETn)begin
		w_index <= 0;
		w_index_g <= 0;
	end else begin
		w_index_g <= (w_index>>1) ^ w_index;
		if (WVALID && WREADY) begin
			w_index <= w_index +1;
		end
	end
end

SyncLine#(
	.STAGES(STAGES),
	.WIDTH(WIDTH)
)w_sync_line(
	.CLK(WCLK),
	.IN(r_index_g),
	.OUT(wr_index_g)
);

AsyncMem #(
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)
)mem(
	.CLKW(WCLK),
	.WEN(WVALID && WREADY),
	.WADDR(w_index[DEPTH-1:0]),
	.DIN(WDATA),

	.CLKR(RCLK),
	.REN(RVALID),
	.RADDR(r_index[DEPTH-1:0]),
	.DOUT(RDATA)
);

always @(posedge RCLK or negedge RRESETn)begin
	if (!RRESETn)begin
		r_index <= 0;
		r_index_g <= 0;
	end else begin
		r_index_g <= (r_index>>1) ^ r_index;
		if (RVALID && RREADY) begin
			r_index <= r_index +1;
		end
	end
end

SyncLine#(
	.STAGES(STAGES),
	.WIDTH(WIDTH)
)r_sync_line(
	.CLK(RCLK),
	.IN(w_index_g),
	.OUT(rw_index_g)
);

endmodule
