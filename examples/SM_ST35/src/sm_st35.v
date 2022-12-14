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

module st_motor(
	input  wire CLK,			// input 100Mhz clock
	input  wire BUT1,			// input signal from button 1
	output reg  LED1,			// output signal to LED1
	output reg  LED2,			// output signal to LED2
	output reg  B2,				// синий     B2 : blue
	output reg  B1,				// розовый   B1 : pink
	output reg  A2,				// желтый    A2 : yellow
	output reg  A1				// оранжевый A1 : orange
);

reg   BUT1_r;					//register to keep button 1 state
reg   [11:0]presc;				// 12 bit prescaler
reg   [1:0]cnt = 0;
reg   [1:0]cnt_t;
reg   [13:0]rst_cnt = 0;		// 14 bit counter for button debounce
reg   mode = 0;					//mode set to 0 initially
reg   [8:0]clk_div;				// 9 bit counter
wire  clk1;						//signal ...
wire  clk2;						//signal ...
wire  reset;					//used for button debounce

assign clk1  = presc[11];						//100 000 000 Hz / 4096 = 24414 Hz
assign reset = rst_cnt[13];						//reset signal is connected to bit14 of rst_cnt 
assign clk2  = clk_div[8];						//24414 Hz / 512 = 47.68 Hz

always @ (posedge CLK)							//on each positive edge of 100Mhz clock increment prescaler
begin
	presc <= presc + 12'b1;
end

always @ (posedge clk1)							//on each positive edge of 24414 Hz clock increment clk_div
begin
	clk_div <= clk_div + 9'b1;

	BUT1_r  <= BUT1;							//capture button 1 state to BUT1_r

	if(reset == 1'b0) begin						//if bit14 of rst_cnt is not set yet
		rst_cnt <= rst_cnt + 14'b1;				//increment the counter rst_cnt
	end

	if(BUT1_r == 1'b0 && reset == 1'b1) begin	//if bit14 of rst_cnt is set and both buttons are pressed
		mode <= mode ^ 1'b1;					//toggle the mode
		rst_cnt <= 14'b0;						//clear debounce rst_cnt
	end

end

always @(posedge clk2)
begin
	if (mode == 0'b0)
		cnt <= cnt+2'b01;
	else
		cnt <= cnt-2'b01;
end

always @(posedge clk2)
begin
	LED1 <= mode;

	// 1 оборот за 00:00 ( 00 s), при clk2 = 23.84 Гц, U2 = 5 V
	// 1 оборот за 02:54 (174 s), при clk2 = 11.92 Гц, U2 = 5 V
	// 1 оборот за 00:21 ( 21 s), при clk2 = 95.37 Гц, U2 = 5 V
	B2 <= cnt==2 || cnt==3;
	B1 <= cnt==0 || cnt==3;
	A2 <= cnt==0 || cnt==1;
	A1 <= cnt==1 || cnt==2;

end

endmodule

