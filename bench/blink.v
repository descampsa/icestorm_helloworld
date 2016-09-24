module blink_tb;

	reg clk = 0;
	wire [4:0] led;

	blink #(.CBITS(8)) BLINK(.clk(clk), .led(led));

	// generate clock
	always
		#1 clk <= !clk;

	initial
	begin
		$dumpfile("blink.vcd");
		$dumpvars(0, blink_tb);
		
		//run for two complete cycles
		#1024 $finish;
	end

endmodule
