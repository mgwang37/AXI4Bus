/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: WBackwardSeparater 
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

module WBackwardSeparater
(
    input     [13:0] DATA,
    input            VALID,
    output           READY,

    output     [7:0] BID,
    output     [1:0] BRESP,
    output     [3:0] BUSER,
    output           BVALID,
    input            BREADY
);

assign {BID,BRESP,BUSER} = DATA;
assign READY = BREADY;
assign BVALID = VALID;

endmodule
