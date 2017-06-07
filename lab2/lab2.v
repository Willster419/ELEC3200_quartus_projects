//Willard Wider
//5-25-17
//ELEC3200
//lab2
//top module
module lab2(a,b,c,x,y,z,u,v,w,s);
  input a,b,c;//the input switches
  output x,y,z,u,v,w,s;//the outputs to the 7 segment display
  //each assign statement is setting each 7 segment display output
  //directly in relation to the inputs
  assign x=~b | ~c;
  assign y=(b&~c) | a;
  assign z=c | a;
  assign u=~a & ~b;
  assign v=~a & ~b & ~c;
  assign w=~b | c;
  assign s=(~b & c) | a;
endmodule
