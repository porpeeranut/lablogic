module SRLatch(
  Q,   // Q output
  QN,  // Qn output
  R,    // R input
  S
  );

  input R,S;
  output Q,QN;
  
  nor nor1(Q,R,QN);
  nor nor1(QN,S,Q);

endmodule
