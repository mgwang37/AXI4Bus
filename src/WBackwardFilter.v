/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: WBackwardFilter
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

module WBackwardFilter#(
	parameter ID_MASK = 8'h00,
	parameter ID_BANK = 8'h00
)(
	input     [13:0] DATAi,
	input            VALIDi,
	output           READYi,

	output    [13:0] DATAo,
	output           VALIDo,
	input            READYo
);

wire   addr_ok;

assign addr_ok = ((DATAi[13:6] & ID_MASK) == ID_BANK) ? 1'b1 : 1'b0;
assign VALIDo  = addr_ok & VALIDi;
assign READYi  = addr_ok & READYo;
assign DATAo   = DATAi;

endmodule
