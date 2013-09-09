module HalfAdder(value, carry, a, b);
	input a, b;
	output value, carry;
	
	and and1(carry, a, b);
	xor xor1(value, a, b);
endmodule
