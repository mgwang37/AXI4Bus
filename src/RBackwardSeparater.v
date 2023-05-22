/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: RBackwardSeparater
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

module RBackwardSeparater
(
	input    [78:0] DATA,
	input           VALID,
	output          READY,

	output    [7:0] RID,
	output   [63:0] RDATA,
	output    [1:0] RRESP,
	output    [3:0] RUSER,
	output          RLAST,
	output          RVALID,
	input           RREADY
);

assign {RID,RDATA,RRESP,RUSER,RLAST} = DATA;
assign RVALID = VALID;
assign READY = RREADY;

endmodule

