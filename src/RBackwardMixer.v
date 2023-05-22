/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: RBackwardMixer
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

module RBackwardMixer
(
	input      [7:0] RID,
	input     [63:0] RDATA,
	input      [1:0] RRESP,
	input      [3:0] RUSER,
	input            RLAST,
	input            RVALID,
	output           RREADY,

	output    [78:0] DATA,
	output           VALID,
	input            READY
);

assign DATA = {RID,RDATA,RRESP,RUSER,RLAST};
assign RREADY = READY;
assign VALID = RVALID;

endmodule

