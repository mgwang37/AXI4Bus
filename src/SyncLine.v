/* Company:
** Engineer:  mgwang37  mgwang37@126.com
**
** Create Date: 08/12/2020 09:00:52 AM
** Design Name:
** Module Name: SyncLine 
** Project Name: AXI4Bus
** Description:
**
** Dependencies:
**
** Revision:
** Revision 0.01 - File Created
** Additional Comments:
*/

module SyncLine #(
	parameter STAGES = 2,
	parameter WIDTH  = 1
)(
	input              CLK,
	input  [WIDTH-1:0] IN,
	output [WIDTH-1:0] OUT
);

genvar i;
generate
	for (i=0; i < WIDTH; i=i+1)begin: data
		(* ASYNC_REG="TRUE" *) reg [STAGES-1:0] sreg;
		always @(posedge CLK)begin
			sreg <= {sreg[STAGES-2:0], IN[i]};
		end
		assign OUT[i] = sreg[STAGES-1];
	end
endgenerate

endmodule
