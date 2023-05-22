/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 05/13/2023 09:00:52 AM
** Design Name:
** Module Name: WForwardFilter
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

module WForwardFilter#(
	parameter ADDR_MASK = 36'h000000000,
	parameter ADDR_BANK = 36'h000000000
)(
	input            CLK,
	input            RESETn,

	input     [76:0] DATAi,
	input            VALIDi,
	output           READYi,

	output    [76:0] DATAo,
	output           VALIDo,
	input            READYo
);

reg    en;
reg    cmd_en;
wire   addr_ok;

assign VALIDo  = en & VALIDi;
assign READYi  = en & READYo;
assign DATAo   = DATAi;
assign addr_ok = (DATAi[68:33] & ADDR_MASK == ADDR_BANK) ? 1'b1 : 1'b0;

always @(posedge CLK or negedge RESETn)begin
    if (!RESETn)begin
		en <= 1'b0;
		cmd_en <= 1'b1;
	end else if(cmd_en)begin
        if (VALIDi && READYi)begin
			en <= addr_ok;
			cmd_en <= 1'b0;
		end
	end else begin
		if (VALIDi && READYi && DATAi[0])begin
			en <= 1'b0;
			cmd_en <= 1'b1;
		end
	end
end

endmodule
