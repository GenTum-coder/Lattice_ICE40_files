// Top module
// sm_st35_m03_test.v

module sm_st35_m03_test(CLK, B2, B1, A2, A1);
output wire  B2;				// синий     B2 : blue
output wire  B1;				// розовый   B1 : pink
output wire  A2;				// желтый    A2 : yellow
output wire  A1;				// оранжевый A1 : orange
input  wire  CLK;

reg  rstn = 0;
reg  [1:0]cnt_r;
wire [1:0]cnt;

//-- Initialization
always @(posedge CLK)
	rstn <= 1;

//instantiate shift reg, overriding width to 32 bits
counter2b cnt2b_inst0(
	.clk (CLK),
	.cnt (cnt),
	.rstn (rstn)
);

decoder2_4 cdec2_4_inst0(
	.CNT (cnt),
	.B2 (B2),
	.B1 (B1),
	.A2 (A2),
	.A1 (A1)
);

endmodule

