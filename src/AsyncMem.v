module AsyncMem #(
	parameter WIDTH = 32,                    
	parameter DEPTH = 4
)(
	input               CLKW,
	input               WEN,
	input  [DEPTH-1:0]  WADDR,
	input  [WIDTH-1:0]  DIN,

	input               CLKR,
	input               REN,
	input  [DEPTH-1:0]  RADDR,
	output [WIDTH-1:0]  DOUT  
);

reg [WIDTH-1:0] BRAM [(1<<DEPTH)-1:0];
reg [WIDTH-1:0] out_reg;

always @(posedge CLKW)begin
    if (WEN)begin
		BRAM[WADDR] <= DIN;
	end
end

always @(posedge CLKR)begin
    if (REN)begin
		out_reg <= BRAM[RADDR];
	end
end

assign DOUT = out_reg;

endmodule
