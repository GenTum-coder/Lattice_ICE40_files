//-------------------------------------------------------------------
//-- Test modules: sm_st35_m03_test_tb.v
//-- Testbench
//-- Modules: sm_st35_m03_test.v counter2b.v decoder2_4.v
//-------------------------------------------------------------------
//-- 2022.12.17. Written by TGA
//-------------------------------------------------------------------

`default_nettype none
`timescale 100 ns / 10 ns
`define DUMPSTR(x) `"x.vcd`"


module sm_st35_m03_test_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10;

//-- Clock signal. It is not used in this simulation
reg   clk = 0;

always #0.5 clk = ~clk;

wire  [1:0]p_leds;

wire B2;
wire B1;
wire A2;
wire A1;

//устанавливаем экземпляр тестируемого модуля
sm_st35_m03_test dut(clk, B2, B1, A2, A1);

initial begin

  //-- File where to store the simulation
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, sm_st35_m03_test_tb);

  #(DURATION) 
  $display("END of the simulation");
  $finish;
end

endmodule
