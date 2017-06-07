//Willard Wider
//05-18-17
//Lab1
//simple design circuit
module lab1(In1,In2,In3,In4,Out1,Out2);
  //inputs, outputs and wires
  input In1,In2,In3,In4;
  output Out1,Out2;
  wire t,u,v;
  //the logic for the circuit. wires are "outputs", more like checkpoints within the circuit,
  //which eventually get sent to the module's outputs
  assign v = ~(In3&In4);
  assign t = ~v;
  assign u = In1 ^ In2;
  assign Out1 = ~(t|u);
  assign Out2 = t&u;
endmodule

`timescale 1ns/10ps     // THIS DEFINES A UNIT TIME FOR THE TEST BENCH AND ITS PRECISION //

// Testbenchfile
// This testbench file is written by Dr. Julius Marpaung
// Not to be published outside WIT.EDU domain without a written permission/consent from Dr. J Marpaung
// All Rights Reserved

module example1testbench();//the declration of the DUT
//Registers in the testbench are the inputs for the device under test DUT
reg In1,In2,In3,In4;       // DECLARING I/O PORTS AND ALSO INTERNAL WIRES //

//Wires in testbench are the outputs from the DUT
wire Out1,Out2;

//register arrays (busses) will store all possible inputs and outputs for the ciruit. The number of array
//entries is equal to the possible number of combinations from the inputs. Example, this DUT has 4 inputs
//which means that the test registers need to have 2^4 (16) entries, inxedes 0-15
reg test[0:15], inputIn1[0:15], inputIn2[0:15], inputIn3[0:15], inputIn4[0:15], oOut1[0:15], oOut2[0:15];

//test control variables
integer ntests, error, testnumber, myloop;

lab1 dut(.In1(In1), .In2(In2), .In3(In3), .In4(In4), .Out1(Out1), .Out2(Out2));  // DECLARES THE MODULE BEING TESTED ALONG WITH ITS I/O PORTS //

initial begin     //LOADING THE TEST REGISTERS WITH INPUTS AND EXPECTED VALUES//

test[0] = 0;   inputIn1[0] = 0;  inputIn2[0] = 0;  inputIn3[0] = 0;  inputIn4[0] = 0;  oOut1[0] = 1;  oOut2[0] = 0;
test[1] = 1;   inputIn1[1] = 0;  inputIn2[1] = 0;  inputIn3[1] = 0;  inputIn4[1] = 1;  oOut1[1] = 1;  oOut2[1] = 0;
test[2] = 2;   inputIn1[2] = 0;  inputIn2[2] = 0;  inputIn3[2] = 1;  inputIn4[2] = 0;  oOut1[2] = 1;  oOut2[2] = 0;
test[3] = 3;   inputIn1[3] = 0;  inputIn2[3] = 0;  inputIn3[3] = 1;  inputIn4[3] = 1;  oOut1[3] = 0;  oOut2[3] = 0;
test[4] = 4;   inputIn1[4] = 0;  inputIn2[4] = 1;  inputIn3[4] = 0;  inputIn4[4] = 0;  oOut1[4] = 0;  oOut2[4] = 0;
test[5] = 5;   inputIn1[5] = 0;  inputIn2[5] = 1;  inputIn3[5] = 0;  inputIn4[5] = 1;  oOut1[5] = 0;  oOut2[5] = 0;
test[6] = 6;   inputIn1[6] = 0;  inputIn2[6] = 1;  inputIn3[6] = 1;  inputIn4[6] = 0;  oOut1[6] = 0;  oOut2[6] = 0;
test[7] = 7;   inputIn1[7] = 0;  inputIn2[7] = 1;  inputIn3[7] = 1;  inputIn4[7] = 1;  oOut1[7] = 0;  oOut2[7] = 1;
test[8] = 8;   inputIn1[8] = 1;  inputIn2[8] = 0;  inputIn3[8] = 0;  inputIn4[8] = 0;  oOut1[8] = 0;  oOut2[8] = 0;
test[9] = 9;   inputIn1[9] = 1;  inputIn2[9] = 0;  inputIn3[9] = 0;  inputIn4[9] = 1;  oOut1[9] = 0;  oOut2[9] = 0;
test[10] = 10; inputIn1[10] = 1; inputIn2[10] = 0; inputIn3[10] = 1; inputIn4[10] = 0; oOut1[10] = 0; oOut2[10] = 0;
test[11] = 11; inputIn1[11] = 1; inputIn2[11] = 0; inputIn3[11] = 1; inputIn4[11] = 1; oOut1[11] = 0; oOut2[11] = 1;
test[12] = 12; inputIn1[12] = 1; inputIn2[12] = 1; inputIn3[12] = 0; inputIn4[12] = 0; oOut1[12] = 1; oOut2[12] = 0;
test[13] = 13; inputIn1[13] = 1; inputIn2[13] = 1; inputIn3[13] = 0; inputIn4[13] = 1; oOut1[13] = 1; oOut2[13] = 0;
test[14] = 14; inputIn1[14] = 1; inputIn2[14] = 1; inputIn3[14] = 1; inputIn4[14] = 0; oOut1[14] = 1; oOut2[14] = 0;
test[15] = 15; inputIn1[15] = 1; inputIn2[15] = 1; inputIn3[15] = 1; inputIn4[15] = 1; oOut1[15] = 0; oOut2[15] = 0;

//the total number of tests, equal to the test register array count
ntests = 16;
$timeformat(-9,1,"ns",12);
end

initial begin

   error = 0;
   testnumber = 0;
   myloop = 0;

   #25//a delay of 25ns
    $display ("\n \n");
    $display ("Welcome to Testbenchfile \n I am your testbenchfile and I am checking your schematic \n");
    $display ("Current time=%t\n  ", $realtime);

   for (testnumber = 0; testnumber < ntests; testnumber = testnumber + 1) begin

		//after a delay, the test sends specific inputs into the circuit
      #25
       $display ("I am doing test number %d", testnumber);
       $display ("Current time=%t and I am setting In1=%b, In2=%b, In3=%b, In4=%b", $realtime, inputIn1[testnumber], inputIn2[testnumber], inputIn3[testnumber], inputIn4[testnumber]);
       In1 = inputIn1[testnumber]; In2 = inputIn2[testnumber]; In3 = inputIn3[testnumber]; In4 = inputIn4[testnumber];

      #25//delay to allow the above logic to happen and arrive at the outputs...
       $display ("Current time=%t and I am checking your Out1=%b, Out2=%b against my oOut1=%b, oOut2=%b", $realtime, Out1, Out2, oOut1[testnumber], oOut2[testnumber]);
       //tests if the DUT actual outputs equal the expected test outputs
		 if ( Out1 == oOut1[testnumber] && Out2 == oOut2[testnumber])
          begin
             $display ("No error found for this test");
          end
       else
          begin
             error = error + 1;
             $display ("ERROR FOUND!!!");
          end
      $display ("You have %d number of error(s) so far \n", error);

   end
	//inform the student if they have good code or not
   if (error == 0)
          begin
              $display ("GOOD JOB!!! Please submit your Verilog files to Dr. Marpaung. Goodbye \n");
          end
   if (error != 0)
          begin
              $display ("I am sorry but your circuit has issues, please fix it. See you soon \n");
          end
end
endmodule
