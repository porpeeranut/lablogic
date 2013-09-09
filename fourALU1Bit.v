module fourALU1Bit(y,z,a,b,c0,c1);
	input [3:0]a,b;
	input c0,c1;
	output [3:0]y,z;

	
	ALU1Bit alu1(y[0],z[0],a[0],b[0],1'b0,c0,c1);
	ALU1Bit alu2(y[1],z[1],a[1],b[1],z[0],c0,c1);
	ALU1Bit alu3(y[2],z[2],a[2],b[2],z[1],c0,c1);
	ALU1Bit alu4(y[3],z[3],a[3],b[3],z[2],c0,c1);
	
endmodule
