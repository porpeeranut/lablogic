module HalfAdder(value, carry, a, b);
	input a, b;
	output value, carry;
	
	and and1(carry, a, b);
	xor xor1(value, a, b);
endmodule

module mux(y, i0, i1, i2, i3, c0, c1);
	input i0, i1, i2, i3, c0, c1;
	output y;
	
	wire nc0, nc1, pre0, pre1, pre2, pre3;
	
	not not1(nc0, c0);
	not not2(nc1, c1);
	
	and and1(pre0, nc0, nc1, i0);
	and and2(pre1, c0, nc1, i1);
	and and3(pre2, nc0, c1, i2);
	and and4(pre3, c0, c1, i3);
	
	or or1(y, pre0, pre1, pre2, pre3);
endmodule

module oneBitALU(y, z, a, b, c0, c1);
	output y, z;
	input a, b, c0, c1;
	
	wire r00, r01, r10, r20, r31;
	
	HalfAdder FA(r00, r01, a, b);
	and and1(r10, a, b);
	not not1(r20, a);
	xnor xnor1(r31, a, b);
	
	mux mux1(y, r00, r10, r20, 1'b0, c0, c1);
	mux mux2(z, r01, 1'b0, 1'b0, r31, c0, c1);
endmodule

module stimulus;
	reg a, b, c0, c1;
	wire y, z;
	
	oneBitALU oba(y, z, a, b, c0, c1);
	
	initial
		begin
			c0 = 1'b0;
			c1 = 1'b0;
			a = 1'b0;
			b = 1'b0;
		end
	
	always
		#40 c0 = ~c0;
	
	always
		#20 c1 = ~c1;
		
	always
		#10 a = ~a;
	
	always
		#5 b = ~b;
			
		
	initial
		#75 $finish;
		
	initial
		$monitor ($time, " c1=%d c0=%d a=%d b=%d | y=%d z=%d", c1, c0, a, b, y, z);
		
endmodule
