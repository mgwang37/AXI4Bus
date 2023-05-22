/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: RForwardMixer
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

module RForwardMixer
(
	input            CLK,
	input            RESETn,

	input      [7:0] ARID,
	input     [35:0] ARADDR,
	input      [7:0] ARLEN,
	input      [2:0] ARSIZE,
	input      [1:0] ARBURST,
	input            ARLOCK,
	input      [3:0] ARCACHE,
	input      [2:0] ARPROT,
	input      [3:0] ARQOS,
	input      [3:0] ARREGION,
	input      [3:0] ARUSER,
	input            ARVALID,
	output           ARREADY,

	output    [76:0] DATA,
	output           VALID,
	input            READY
);

assign DATA = {ARID,ARADDR,ARLEN,ARSIZE,ARBURST,ARLOCK,ARCACHE,ARPROT,ARQOS,ARREGION,ARUSER};
assign ARREADY = READY;
assign VALID = ARVALID;

endmodule
