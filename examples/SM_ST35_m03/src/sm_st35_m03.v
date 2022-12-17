// ST35 stepper motor (12 V, 200 Ohm)
//
// https://premotec.home.xs4all.nl/pdf/stepper/ST35%20UNI.pdf
// 1 - A2 B1
// 2 - A2 A1
// 3 - B2 A1
// 4 - B2 A1
//
// ULN2803
// U2 = 5 V

module sm_st35_mo3(CLK, BUT1, LED1, LED2, B2, B1, A2, A1);
input  wire  CLK;
input  wire  BUT1;			// input signal from button 1
output reg   LED1;			// output signal to LED1
output reg   LED2;			// output signal to LED2
output wire  B2;			// синий     B2 : blue
output wire  B1;			// розовый   B1 : pink
output wire  A2;			// желтый    A2 : yellow
output wire  A1;			// оранжевый A1 : orange

reg  BUT1_r;					//register to keep button 1 state
reg  [11:0]presc1;				// 12 bit prescaler
reg   [8:0]presc2;				//  9 bit prescaler
//reg  [1:0]cnt = 0;
reg   [13:0]rst_cnt = 0;		// 14 bit counter for button debounce
reg   mode = 0;					//mode set to 0 initially
wire  clk1;						//signal ...
wire  clk2;						//signal ...
wire  reset;					//used for button debounce
//
reg  rstn = 0;
reg  [1:0]cnt_r;
wire [1:0]cnt;
wire [1:0]cnt_t;

assign clk1  = presc1[11];						//100 000 000 Hz / 4096 = 24414 Hz
assign clk2  = presc2[8];						//24414 Hz / 512 = 47.68 Hz
assign reset = rst_cnt[13];						//reset signal is connected to bit14 of rst_cnt 
assign cnt_t = mode ? ~cnt : cnt;		//multiplexer controlled by mode which connects ~cnt or cnt to cnt_t

always @ (posedge CLK)							//on each positive edge of 100Mhz clock increment prescaler
begin
	presc1 <= presc1 + 12'b1;
end

always @ (posedge clk1)							//on each positive edge of 24414 Hz clock increment clk_div
begin
	presc2 <= presc2 + 9'b1;

	BUT1_r  <= BUT1;							//capture button 1 state to BUT1_r

	if(reset == 1'b0) begin						//if bit14 of rst_cnt is not set yet
		rst_cnt <= rst_cnt + 14'b1;				//increment the counter rst_cnt
	end

	if(BUT1_r == 1'b0 && reset == 1'b1) begin	//if bit14 of rst_cnt is set and both buttons are pressed
		mode <= mode ^ 1'b1;					//toggle the mode
		rst_cnt <= 14'b0;						//clear debounce rst_cnt
	end

end

//-- Initialization
always @(posedge clk2)
begin
	rstn <= 1;
	LED1 <= mode;
end

//instantiate shift reg, overriding width to 32 bits
counter2b cnt2b_inst0(
	.clk (clk2),
	.cnt (cnt),
	.rstn (rstn)
);

decoder2_4 cdec2_4_inst0(
	.CNT (cnt_t),
	.B2 (B2),
	.B1 (B1),
	.A2 (A2),
	.A1 (A1)
);

endmodule

