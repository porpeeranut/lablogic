module FullAdder(value, carry, a, b, c);
	input a, b, c;
	output value, carry;
	
	wire pre0, pre1, pre2;
	
	xor xor1(pre0, a, b);
	xor xor2(value, pre0, c);
	and and1(pre1, a, b);
	and and2(pre2, pre0, c);
	or or1(carry, pre1, pre2);
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

module oneBitALU(y, z, a, b, c, c0, c1);
	output y, z;
	input a, b, c, c0, c1;
	
	wire r00, r01, r10, r20, r31;
	
	FullAdder FA(r00, r01, a, b, c);
	and and1(r10, a, b);
	not not1(r20, a);
	xnor xnor1(r31, a, b);
	
	mux mux1(y, r00, r10, r20, 1'b0, c0, c1);
	mux mux2(z, r01, 1'b0, 1'b0, r31, c0, c1);
endmodule

module fourBitALU(y, z, a, b, c0, c1);
	output [0:3]y, z;
	input c0, c1;
	input [0:3]a, b;
	oneBitALU oba0(y[0], z[0], a[0], b[0], 1'b0, c0, c1);
	oneBitALU oba1(y[1], z[1], a[1], b[1], z[0], c0, c1);
	oneBitALU oba2(y[2], z[2], a[2], b[2], z[1], c0, c1);
	oneBitALU oba3(y[3], z[3], a[3], b[3], z[2], c0, c1);
endmodule

module stimulus;
	reg [0:3]a, b;
	reg c0, c1;
	wire [0:3]y, z;
	
	fourBitALU fba(y, z, a, b, c0, c1);
	
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
		#15 $finish;
		
	initial
		$monitor ($time, " c1=%d c0=%d a=1011 b=0111 | y=%b z=%b", c1, c0, y, z);
		
endmodule
