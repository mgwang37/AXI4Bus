/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: WForwardMixer
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

module WForwardMixer
(
	input            CLK,
	input            RESETn,

	input      [7:0] AWID,
	input     [35:0] AWADDR,
	input      [7:0] AWLEN,
	input      [2:0] AWSIZE,
	input      [1:0] AWBURST,
	input            AWLOCK,
	input      [3:0] AWCACHE,
	input      [2:0] AWPROT,
	input      [3:0] AWQOS,
	input      [3:0] AWREGION,
	input      [3:0] AWUSER,
	input            AWVALID,
	output           AWREADY,

	input     [63:0] WDATA,
	input      [7:0] WSTRB,
	input            WLAST,
	input      [3:0] WUSER,
	input            WVALID,
	output           WREADY,

	output    [76:0] DATA,
	output           VALID,
	input            READY
);

reg cmd_en;
wire [76:0] cmd_info;
wire [76:0] data_info;

assign cmd_info  = {AWID,AWADDR,AWLEN,AWSIZE,AWBURST,AWLOCK,AWCACHE,AWPROT,AWQOS,AWREGION,AWUSER};
assign data_info = {WDATA,WSTRB,WUSER,WLAST};

assign DATA    = cmd_en ? cmd_info : data_info;
assign VALID   = cmd_en ? AWVALID  : WVALID;
assign AWREADY = cmd_en ? READY    : 1'b0;
assign WREADY  = cmd_en ? 1'b0     : READY;

always @(posedge CLK or negedge RESETn)begin
	if (!RESETn)begin
		cmd_en <= 1;
	end if (cmd_en)begin
		if (VALID && READY)begin
			cmd_en <= 0;
		end
	end else begin
		if (VALID && READY && DATA[0])begin
			cmd_en <= 1;
		end
	end
end

endmodule
