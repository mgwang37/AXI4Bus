/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: RForwardSeparater
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

module RForwardSeparater
(
	input            CLK,
	input            RESETn,

	input     [76:0] DATA,
	input            VALID,
	output           READY,

	output     [7:0] ARID,
	output    [35:0] ARADDR,
	output     [7:0] ARLEN,
	output     [2:0] ARSIZE,
	output     [1:0] ARBURST,
	output           ARLOCK,
	output     [3:0] ARCACHE,
	output     [2:0] ARPROT,
	output     [3:0] ARQOS,
	output     [3:0] ARREGION,
	output     [3:0] ARUSER,
	output           ARVALID,
	input            ARREADY
);

assign {ARID,ARADDR,ARLEN,ARSIZE,ARBURST,ARLOCK,ARCACHE,ARPROT,ARQOS,ARREGION,ARUSER} = DATA;
assign READY = ARREADY;
assign ARVALID = VALID;

endmodule
