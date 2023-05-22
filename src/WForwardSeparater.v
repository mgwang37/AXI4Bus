/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: WForwardSeparater
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

module WForwardSeparater
(
	input            CLK,
	input            RESETn,

	input     [76:0] DATA,
	input            VALID,
	output           READY,

	output     [7:0] AWID,
	output    [35:0] AWADDR,
	output     [7:0] AWLEN,
	output     [2:0] AWSIZE,
	output     [1:0] AWBURST,
	output           AWLOCK,
	output     [3:0] AWCACHE,
	output     [2:0] AWPROT,
	output     [3:0] AWQOS,
	output     [3:0] AWREGION,
	output     [3:0] AWUSER,
	output           AWVALID,
	input            AWREADY,

	output    [63:0] WDATA,
	output     [7:0] WSTRB,
	output           WLAST,
	output     [3:0] WUSER,
	output           WVALID,
	input            WREADY
);

reg    cmd_en;
assign {AWID,AWADDR,AWLEN,AWSIZE,AWBURST,AWLOCK,AWCACHE,AWPROT,AWQOS,AWREGION,AWUSER} = DATA;
assign {WDATA,WSTRB,WUSER,WLAST} = DATA;

assign READY   = cmd_en ? AWREADY : WREADY;
assign AWVALID = cmd_en ? VALID   : 1'b0;
assign WVALID  = cmd_en ? 1'b0    : VALID;

always @(posedge CLK or negedge RESETn)begin
	if (!RESETn)begin
		cmd_en <= 1'b1;
	end if (cmd_en)begin
		if (VALID && READY)begin
			cmd_en <= 1'b0;
		end
	end else begin
		if (VALID && READY && DATA[0])begin
			cmd_en <= 1'b1;
		end
	end
end

endmodule
