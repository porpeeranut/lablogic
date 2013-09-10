module counter(q,clk,reset);
	input clk,reset;
	output [1:0]q;
	wire q0;
	T_FF tff0(q[0],1'b1,clk,reset);
	T_FF tff1(q[1],q[0],clk,reset);
endmodule

module D_FF(q,d,clk,reset);
	input d,clk,reset;
	output q;
	reg q;
	always @ (posedge reset or negedge clk)
	if(reset)
		q <= 1'b0;
	else
		q <= d;
endmodule

module counter(q,t,clk,reset);
	input t,clk,reset;
	output q;
	wire d;
	xor x1(d,q,t);
	D_FF d1(q,d,clk,reset);
endmodule

module stimulus;
	reg clk;
	reg reset;
	wire [1:0]q;
	counter c0(q,clk,reset);
	initial
		clk = 1'b0;
	always
		#5 clk = ~clk;

	initial
		begin
			reset = 1'b1;
			#50 reset = 1'b0;
			#50 reset = 1'b1;
			#5 reset = 1'b0;
			#50 $finish;
		end

	initial
		$monitor($time," output q = %d reset = %d",q,reset);

endmodule
