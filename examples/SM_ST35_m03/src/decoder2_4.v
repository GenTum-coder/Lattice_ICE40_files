
module decoder2_4(
	input  wire  [1:0]CNT,		// input register 2 bits
	output wire  B2,			// синий     B2 : blue
	output wire  B1,			// розовый   B1 : pink
	output wire  A2,			// желтый    A2 : yellow
	output wire  A1				// оранжевый A1 : orange
);

reg b2_r;
reg b1_r;
reg a2_r;
reg a1_r;

assign B2 = b2_r;
assign B1 = b1_r;
assign A2 = a2_r;
assign A1 = a1_r;

always @(CNT)
begin

	b2_r <= CNT==2 || CNT==3;
	b1_r <= CNT==0 || CNT==3;
	a2_r <= CNT==0 || CNT==1;
	a1_r <= CNT==1 || CNT==2;

end

endmodule	// decoder2_4

