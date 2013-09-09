module D_FF(q, d, clk, reset);
	output q;
	input d, clk, reset;
	reg q;
	
	always @(posedge reset or negedge clk)
		if (reset)
			q <= 1'b0;
		else
			q <= d;

endmodule

module counter(q, d, clk, reset);
	input [0:1]d;
	input clk, reset;
	output [0:1]q;

	D_FF a(q[0],d[0],clk,reset);
	D_FF b(q[1],d[1],clk,reset);
endmodule

module inputFunction(q, x, clk, reset);
	output [0:1]q;
	input x, clk, reset;
	wire [0:1]d;
	wire xn, pre0, pre1, pre2, pre3, pre4, pre5;
	wire [0:1]qn;
	
	not not1(xn, x);
	not not2(qn[0],q[0]);
	not not3(qn[1],q[1]);
	
	not not4(d[0],q[0]);
	
	and and1(pre0, x, qn[1], qn[0]);
	and and2(pre1, xn, qn[1], q[0]);
	and and3(pre2, x, q[1], q[0]);
	and and4(pre3, xn, q[1], qn[0]);
	or or2(d[1], pre0, pre1, pre2, pre3);
	
	counter c(q, d, clk, reset);
endmodule

module outputFunction(outt, q, x, clk, reset);
	output [0:1]q;
	output outt; 
	input x, clk, reset;
	
	wire qn;
	
	inputFunction ifa(q, x, clk, reset);
	not not1(qn, q[1]);
	and and1(outt,x, qn, q[0]);
endmodule

module stimulus;
	wire [0:1]q;
	wire out;
	reg clk, reset, x;
	
	outputFunction of(out, q, x, clk, reset);
	
	initial
		begin
			reset = 1'b1;	
			clk = 1'b1;
			x = 1'b0;
			
		end
	
	initial
		begin
			#5 begin
				reset =1'b0;
			end
			
			#35 begin
				x = ~x;
			end
		end
		
	
	always
		#5 clk = ~clk;
		
	initial
		#80 $finish;
		
	initial
		$monitor ($time, " reset=%d x=%d q=%b out=%d", reset, x, q, out);
		
endmodule
