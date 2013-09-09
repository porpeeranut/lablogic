module ALU1Bit(y,outz,a,b,c0,c1,carryIn);
	input a,b,c0,c1,carryIn;
	output y,outz;

	wire carry;
	wire notA;
	wire zero = 1'b0;
	wire andN;
	wire xnorc1c0;
	FullAdder FullAdder1(S,carry,a,b,carryIn);
	and andN(andN,a,b);
	not notA(notA,a);

	xnor xnor1(xnorc1c0,a,b);

	MUX4to1 MUX1(y,S,andN,notA,zero,c0,c1);
	MUX4to1 MUX2(outz,carry,zero,zero,xnorc1c0,c0,c1);
endmodule
