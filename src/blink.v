module blink(
	input clk,
	output reg [4:0] led);

	parameter CBITS = 27;
	
	reg [CBITS-1:0] counter;

	//generate initial reset signal
	reg resetn = 0;
	always @(posedge clk)
		resetn <= 1;

	always @ (posedge clk)
	begin
		//update counter
		if(!resetn)
			counter <= 0;
		else
			counter <= counter+1;

		//set output depending of counter msb
		case(counter[CBITS-1:CBITS-2])
			2'b00:
				led[3:0] = 4'b0001;
			2'b01:
				led[3:0] = 4'b0010;
			2'b10:
				led[3:0] = 4'b0100;
			2'b11:
				led[3:0] = 4'b1000;
		endcase
		led[4] = 1'b1;
	end
endmodule
