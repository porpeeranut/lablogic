module SRLatchStimulus;
  reg R,S;
  wire Q,QN;

  SRLatch SRLatch(Q,QN,R,S);

  initial
    begin
      $dumpfile("SRLatchTimeDiagram.vcd");
      $dumpvars(0,SRLatchStimulus);
      R = 1'b0;
      S = 1'b0;
    end

  initial  // R
    begin
      #15 R = 1'b1;
      #5 R = 1'b0;
      #10 R = 1'b1;
      #10 R = 1'b0;
    end

  initial  // S
    begin
      #5 S = 1'b1;
      #5 S = 1'b0;
      #15 S = 1'b1;
      #5 S = 1'b0;
      #5 S = 1'b1;
      #5 S = 1'b0;
      #5 S = 1'b0;
    end

  initial
    $monitor($time," output R = %d S = %d Q = %d QN = %d",R,S,Q,QN);

endmodule
