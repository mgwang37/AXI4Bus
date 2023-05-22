module SyncMem #(
	parameter WIDTH = 32,                    
	parameter DEPTH = 4
)(
	input               CLK,
	input               WEN,
	input               REN,
	input  [DEPTH-1:0]  WADDR,
	input  [DEPTH-1:0]  RADDR,
	input  [WIDTH-1:0]  DIN,
	output [WIDTH-1:0]  DOUT  
);

reg [WIDTH-1:0] BRAM [(1<<DEPTH)-1:0];
reg [WIDTH-1:0] out_reg;

always @(posedge CLK)begin
    if (WEN)begin
		BRAM[WADDR] <= DIN;
	end

    if (REN)begin
		out_reg <= BRAM[RADDR];
	end
end

assign DOUT = out_reg;

endmodule
