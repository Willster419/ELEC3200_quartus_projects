//Willard Wider
//6-15-17
//ELEC 3200
//Lab 5

module lab4_fake(clk, button, ledCounter);
  input [3:0] button;
  input clk;
  output [9:0] ledCounter;
  reg [9:0] ledCounter;
  reg [3:0] old;
  reg [3:0] new;
  reg [31:0] counter;
  reg [31:0] counterLimit;
  reg ledPressed;
  
  initial begin//init everything to 0 except the clock counter limit
  old = 0;
  new = 0;
  counter = 0;
  ledCounter = 0;
  counterLimit = 125000;//change to value for the 10ms thing, now 5, now 2.5
  ledPressed = 0;
  end
  
  always @(posedge clk) begin
    counter = counter +1;//always incriment the counter
    if (counter >= counterLimit) begin//once the counter reaches the limit init from above
      counter = 0;//reset the counter
      old = new;//save old value from new
      new = button;//save new value from output
      if((old == new) && !ledPressed) begin//if the old and new are logically the same
        case(~button)
          default: begin
            //ledCounter = 0;
            ledPressed = 0;//this key combo doesn't count
          end
          4'b0001 : begin
            ledCounter = ledCounter + 1;
            ledPressed = 1;//set the flag so it won't run this code again
            //so it won't incriment the led's again while the button is STILL down
          end
          4'b0010 : begin
            ledCounter = ledCounter + 2;
            ledPressed = 1;
          end
          4'b0100 : begin
            ledCounter = ledCounter + 4;
            ledPressed = 1;
          end
          4'b1000 : begin
            ledCounter = ledCounter + 8;
            ledPressed = 1;
          end
        endcase
      end
      if(button == 4'b1111)begin//all buttons have been released
          ledPressed = 0;
      end
    end
  end
  
endmodule
