
module counter2b(
	input  wire clk,			// input 48 Hz clock
	input  wire rstn,			// reset
	output wire [1:0]cnt		// output count
);

reg [1:0] cnt_r;

assign cnt = cnt_r[1:0];

always @(posedge clk)
begin
	if (!rstn)
		cnt_r <= 0;
	else
		cnt_r <= cnt_r + 2'b01;
end

endmodule	// counter2b

