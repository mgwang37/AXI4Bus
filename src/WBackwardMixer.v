/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: WBackwardMixer
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

module WBackwardMixer
(
	input      [7:0] BID,
	input      [1:0] BRESP,
	input      [3:0] BUSER,
	input            BVALID,
	output           BREADY,

	output    [13:0] DATA,
	output           VALID,
	input            READY
);

assign DATA = {BID,BRESP,BUSER};
assign BREADY = READY;
assign VALID = BVALID;

endmodule
