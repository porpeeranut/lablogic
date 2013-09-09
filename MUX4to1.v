module MUX4to1(y,S,andN,notA,zero,c0,c1);
	input S,notA,zero,andN,c0,c1;
	output y;
	wire notC0,notC1;
	wire w1,w2,w3,w4;
	
	not notc0(notC0,c0);
	not notc1(notC1,c1);

	and and1(w1,S,notC0,notC1);
	and and2(w2,andN,c0,notC1);
	and and3(w3,notA,notC0,c1);
	and and4(w4,zero,c0,c1);
	
	or or1(y,w1,w2,w3,w4);
endmodule
