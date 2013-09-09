module stimulus;
	reg c0,c1;
	reg [3:0]a,b;
	wire [3:0]y, z;

	fourALU1Bit fALU(y,z,a,b,c0,c1);
	
	initial
		begin
			c0 = 1'b0;
			c1 = 1'b0;
			a[0] = 1'b1;
			a[1] = 1'b0;
			a[2] = 1'b1;
			a[3] = 1'b1;
			b[0] = 1'b0;
			b[1] = 1'b1;
			b[2] = 1'b1;
			b[3] = 1'b1;
		end
		
	always
		#10 c0 = ~c0;

	always
		#5 c1 = ~c1;

	initial
		begin
			#15 $finish;
		end
	initial
		$monitor ($time, " c1=%d c0=%d a=1101 b=1110 | y=%b z=%b", c1, c0, y, z);

endmodule
