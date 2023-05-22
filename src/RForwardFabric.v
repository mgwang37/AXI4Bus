/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: RForwardFabric
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

module RForwardFabric
(
	input            CLK,
	input            RESETn,

	input     [76:0] DATA0,
	input            VALID0,
	output           READY0,

	input     [76:0] DATA1,
	input            VALID1,
	output           READY1,

	output    [76:0] DATA,
	output           VALID,
	input            READY
);

reg switch;

always @(switch)begin
	if (switch)begin
		DATA   = DATA1;
		VALID  = VALID1;
		READY1 = READY;
		READY0 = 0;
	end else begin
		DATA   = DATA0;
		VALID  = VALID0;
		READY0 = READY;
		READY1 = 0;
	end
end

always @(posedge CLK or negedge RESETn)begin
    if (!RESETn)begin
		switch <= 1'b0;
    end else begin
        if (VALID0 && !VALID1)begin
			switch <= 1'b0;
        end else if (!VALID0 && VALID1)begin
			switch <= 1'b1;
        end else if (VALID0 && VALID1)begin
			switch <= ~switch;
		end
    end
end

endmodule
