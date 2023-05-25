/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: RForwardFilter
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

module RForwardFilter#(
	parameter ADDR_MASK = 36'h000000000,
	parameter ADDR_BANK = 36'h000000000
)(
	input     [76:0] DATAi,
	input            VALIDi,
	output           READYi,

	output    [76:0] DATAo,
	output           VALIDo,
	input            READYo
);

wire   addr_ok;
assign addr_ok = ((DATAi[68:33] & ADDR_MASK) == ADDR_BANK) ? 1'b1 : 1'b0;

assign VALIDo = addr_ok & VALIDi;
assign READYi = addr_ok & READYo;
assign DATAo  = DATAi;

endmodule
