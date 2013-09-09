module stimulus;
	reg c0,c1,a,b,carryIn;
	wire y, z;

	ALU1Bit ALU1Bit1(y,z,a,b,c0,c1,carryIn);
	
	initial
		begin
			c0 = 1'b0;	
			c1 = 1'b0;
			a = 1'b0;
			b = 1'b0;
			carryIn = 1'b0; 
		end
		
	always
		#40	c0 = ~c0;		
	always
		#20	c1 = ~c1;	
	always
		#10	a = ~a;
	always
		#5	b = ~b;

	initial
		begin
			#75 $finish;
		end
	initial
		$monitor($time, "| ssss0=%d c1=%d  a=%d b=%d  y=%d z=%d",c0,c1,a,b,y,z);

endmodule
