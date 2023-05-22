/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: RBackwardFabric
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

module RBackwardFabric
(
	input            CLK,
	input            RESETn,

	input     [78:0] DATA0,
	input            VALID0,
	output           READY0,

	input     [78:0] DATA1,
	input            VALID1,
	output           READY1,

	output    [78:0] DATA,
	output           VALID,
	input            READY
);

reg       cmd_en;
reg [1:0] switch;

always @(switch)begin
	if (switch == 2'b10)begin
		DATA = DATA0;
		VALID = VALID0;
		READY0 = READY;
		READY1 = 0;
	end else if (switch == 2'b11)begin
		DATA = DATA1;
		VALID = VALID1;
		READY1 = READY;
		READY0 = 0;
	end else begin
		DATA = 79'h0;
		VALID = 0;
		READY1 = 0;
		READY0 = 0;
	end
end

always @(posedge CLK or negedge RESETn)begin
    if (!RESETn)begin
        cmd_en <= 1;
		switch <= 2'b00;
    end if (cmd_en)begin
        if (VALID0 && !VALID1)begin
            cmd_en <= 0;
			switch <= 2'b10;
        end else if (!VALID0 && VALID1)begin
            cmd_en <= 0;
			switch <= 2'b11;
        end else if (VALID0 && VALID1)begin
            cmd_en <= 0;
			if (switch[0])
				switch <= 2'b10;
			else
				switch <= 2'b11;
		end else begin
			switch <= 2'b00;
		end
    end else begin
        if (VALID && READY && DATA[0])begin
            cmd_en <= 1;
			switch <= 2'b00;
        end
    end
end


endmodule
