module FullAdder(S,carry,a,b,carryIn);
	input a,b,carryIn;
	output carry,S;
	wire xorAB;
	wire andAB,andXorABCin;
	xor xor1(xorAB,a,b);
	xor xor2(S,carryIn,xorAB);
	and and1(andAB,a,b);
	and and2(andXorABCin,xorAB,carryIn);
	or or1(carry,andXorABCin,andAB);
endmodule
