//Willard Wider
//6-23-17
//ELEC 3200
//Lab 6
module lab6(clk,row,col,sevenSeg1,sevenSeg2,sevenSeg3,sevenSeg4);
  input [3:0] row;
  input clk;
  output [3:0] col;
  output [6:0] sevenSeg1;
  output [6:0] sevenSeg2;
  output [6:0] sevenSeg3;
  output [6:0] sevenSeg4;
  //output [15:0] wholeInput;
  reg [3:0] col;
  reg [15:0] wholeInput;
  reg [31:0] counter;
  reg [31:0] counterLimit;
  reg [4:0] state;
  reg [2:0] addingState;
  reg buttonPressed;
  reg numberProcessed;
  reg [3:0] debounce1;
  reg [3:0] debounce2;
  reg [7:0] numAdd1;
  reg [7:0] numAdd2;
  reg [7:0] total;
  reg [4:0] tempAdd;
  //reg [6:0] sevenSeg1;
  reg [7:0] sevenSeg1Num;
  //reg [6:0] sevenSeg2;
  reg [7:0] sevenSeg2Num;
  //reg [6:0] sevenSeg3;
  reg [7:0] sevenSeg3Num;
  //reg [6:0] sevenSeg4;
  reg [7:0] sevenSeg4Num;
  reg [6:0] letters_0;
  reg [6:0] letters_1;
  reg [6:0] letters_2;
  reg [6:0] letters_3;
  reg [6:0] letters_4;
  reg [6:0] letters_5;
  reg [6:0] letters_6;
  reg [6:0] letters_7;
  reg [6:0] letters_8;
  reg [6:0] letters_9;
  reg [6:0] letters_A;
  reg [6:0] letters_B;
  reg [6:0] letters_C;
  reg [6:0] letters_D;
  reg [6:0] letters_E;
  reg [6:0] letters_F;
  //module sevenSegConvert(hexIn, sevenSegOut);
  //link 
  sevenSegConvert sevenSeg1Convert(.hexIn(sevenSeg1Num), .sevenSegOut(sevenSeg1));
  sevenSegConvert sevenSeg2Convert(.hexIn(sevenSeg2Num), .sevenSegOut(sevenSeg2));
  sevenSegConvert sevenSeg3Convert(.hexIn(sevenSeg3Num), .sevenSegOut(sevenSeg3));
  sevenSegConvert sevenSeg4Convert(.hexIn(sevenSeg4Num), .sevenSegOut(sevenSeg4));
  initial begin
    wholeInput = 16'b0;
    counterLimit = 250000;//change to value for the 10ms thing, now 5, now 2.5, now 5 again
    letters_0=7'b1000000;
    letters_1=7'b1111001;
    letters_2=7'b0100100;
    letters_3=7'b0110000;
    letters_4=7'b0011001;
    letters_5=7'b0010010;
    letters_6=7'b0000010;
    letters_7=7'b1111000;
    letters_8=7'b0000000;
    letters_9=7'b0011000;
    letters_A=7'b0001000;
    letters_B=7'b0000011;
    letters_C=7'b1000110;
    letters_D=7'b0100001;
    letters_E=7'b0000110;
    letters_F=7'b0001110;
    state = 0;//set for default
    buttonPressed = 0;
    debounce1=4'b0000;
    debounce2=4'b0000;
    numAdd1 = 0;
    numAdd2 = 0;
    total = 0;
    addingState = 0;
    numberProcessed = 0;
    sevenSeg1Num = 7'hE;
    sevenSeg2Num = 7'hE;
    sevenSeg3Num = 7'hE;
    sevenSeg4Num = 7'hE;
  end
  always @(posedge clk) begin
    counter = counter +1;//always incriment the counter
    if (counter >= counterLimit) begin//once the counter reaches the limit init from above
      counter = 0;
      case (state)
        0: begin//write voltage for col1
          col = 4'b0111;
          state = 1;
        end
        1: begin//read row for 3-0
          debounce1 = ~row;//store the first debounce value
          state = 2;
        end
        2: begin//write voltage for col1
          col = 4'b0111;
          state = 3;
        end
        3: begin//read row for 3-0
          if(debounce1 == ~row) begin
            wholeInput[3:0] = ~row;
          end
          state = 4;
        end
        4: begin//write voltage for col2
          col = 4'b1011;
          state = 5;
        end
        5: begin//read row for 7-4
          debounce1 = ~row;
          state = 6;
        end
        6: begin//write voltage for col2
          col = 4'b1011;
          state = 7;
        end
        7: begin//read row for 7-4
          if(debounce1 == ~row) begin
          wholeInput[7:4] = ~row;
          end
          state = 8;
        end
        8: begin//write voltage for col3
          col = 4'b1101;
          state = 9;
        end
        9: begin//read row 11-8
          debounce1 = ~row;
          state = 10;
        end
        10: begin//write voltage for col3
          col = 4'b1101;
          state = 11;
        end
        11: begin//read row 11-8
          if(debounce1 == ~row) begin
          wholeInput[11:8] = ~row;
          end
          state = 12;
        end
        12: begin//write voltage for col4
          col = 4'b1110;
          state = 13;
        end
        13: begin//read row 15-12
          debounce1 = ~row;
          state = 14;
        end
        14: begin//write voltage for col4
          col = 4'b1110;
          state = 15;
        end
        15: begin//read row 15-12
          if(debounce1 == ~row) begin
          wholeInput[15:12] = ~row;
          end
          state = 16;
        end
        16: begin//determine hex number to display
            case ({wholeInput,buttonPressed})
              17'b00000000000000001: begin//nothing is pressed
                //sevenSeg1=letters_A;//prove it gets this far. just for now.
                //sevenSeg1=7'b1111111;
                buttonPressed = 0;
              end
              17'b10000000000000000: begin//D
                //sevenSeg1 = letters_D;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'hD;
              end
              17'b01000000000000000: begin//C
                //sevenSeg1 = letters_C;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'hC;
              end
              17'b00100000000000000: begin//B
                //sevenSeg1 = letters_B;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'hB;
              end
              17'b00010000000000000: begin//A
                //sevenSeg1 = letters_A;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'hA;
              end
              17'b00001000000000000: begin//#
                //sevenSeg1 = letters_E;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'hE;
              end
              17'b00000100000000000: begin//9
                //sevenSeg1 = letters_9;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h9;
              end
              17'b00000010000000000: begin//6
                //sevenSeg1 = letters_6;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h6;
              end
              17'b00000001000000000: begin//3
                //sevenSeg1 = letters_3;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h3;
              end
              17'b00000000100000000: begin//0
                //sevenSeg1 = letters_0;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h0;
              end
              17'b00000000010000000: begin//8
                //sevenSeg1 = letters_8;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h8;
              end
              17'b00000000001000000: begin//5
                //sevenSeg1 = letters_5;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h5;
              end
              17'b00000000000100000: begin//2
                //sevenSeg1 = letters_2;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h2;
              end
              17'b00000000000010000: begin//*
                //sevenSeg1 = letters_F;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'hF;
              end
              17'b00000000000001000: begin//7
                //sevenSeg1 = letters_7;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h7;
              end
              17'b00000000000000100: begin//4
                //sevenSeg1 = letters_4;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h4;
              end
              17'b00000000000000010: begin//1
                //sevenSeg1 = letters_1;
                buttonPressed = 1;
                addingState = addingState + 1;
                tempAdd = 4'h1;
              end
            endcase
          case ({addingState,buttonPressed, numberProcessed})
            5'b00110: begin//storing the first value and displaying it
              //numAdd1 = sevenSeg1;
              //need to get sevenSeg1 to have numAdd1
              sevenSeg1Num = tempAdd;
              sevenSeg2Num = 7'hE;
              sevenSeg3Num = 7'hE;
              sevenSeg4Num = 7'hE;
              numberProcessed = 1;
            end
            5'b01010: begin//verify that the second button pressed is the plus
              if(wholeInput != 16'b0000000000001000) begin
                addingState = addingState - 3'b001;
              end
              numberProcessed = 1;
            end
            5'b01110: begin//shift value 1 to the second display
                    //save value 2 to the second display
              sevenSeg2Num = tempAdd;
              numberProcessed = 1;
            end
            5'b10010: begin
              if(wholeInput != 16'b0000100000000000) begin//#
                addingState = addingState- 3'b001;
              end
              else begin
                //shift value 1 to fourth display
                //shift value 2 to third display
                //display to the first and second displays
                sevenSeg4Num = sevenSeg2Num;
                sevenSeg3Num = sevenSeg1Num;
                total = sevenSeg1Num + sevenSeg2Num;
                //sevenSeg2Num = total / 7'hA;
                sevenSeg2Num = (total > 7'h9)? total/7'hA:7'hE;
                //sevenSeg2Num = 7'hE;
                sevenSeg1Num = total % 7'hA;
              end
              numberProcessed = 1;
            end
            5'b10110: begin//cleared state
              if(wholeInput != 16'b0000100000000000) begin
                addingState = addingState- 3'b001;
              end
              else begin
                sevenSeg1Num = 7'hE;
                sevenSeg2Num = 7'hE;
                sevenSeg3Num = 7'hE;
                sevenSeg4Num = 7'hE;
              end
              addingState = 0;
              numberProcessed = 1;
            end
            5'b11010: begin//cleared state
              if(wholeInput != 16'b0000100000000000) begin
                addingState = addingState- 3'b001;
              end
              else begin
                sevenSeg1Num = 7'hE;
                sevenSeg2Num = 7'hE;
                sevenSeg3Num = 7'hE;
                sevenSeg4Num = 7'hE;
              end
              addingState = 0;
              numberProcessed = 1;
            end
          endcase
          if (!buttonPressed && numberProcessed)begin
            numberProcessed = 0;
          end
          state = 0;//go back to start
          wholeInput = 16'b0;//reset the leter
        end
      endcase
    end
  end
endmodule

module sevenSegConvert(hexIn, sevenSegOut);
  input [7:0] hexIn;
  output [6:0] sevenSegOut;
  reg [6:0] sevenSegOut;
  always @(hexIn) begin
    case(hexIn)
      7'h0 : begin
        sevenSegOut = 7'b1000000;//0
      end
      7'h1 : begin
        sevenSegOut = 7'b1111001;//1
      end
      7'h2 : begin
        sevenSegOut = 7'b0100100;//2
      end
      7'h3 : begin
        sevenSegOut = 7'b0110000;//3
      end
      7'h4 : begin
        sevenSegOut = 7'b0011001;//4
      end
      7'h5 : begin
        sevenSegOut = 7'b0010010;//5
      end
      7'h6 : begin
        sevenSegOut = 7'b0000010;//6
      end
      7'h7 : begin
        sevenSegOut = 7'b1111000;//7
      end
      7'h8 : begin
        sevenSegOut = 7'b0000000;//8
      end
      7'h9 : begin
        sevenSegOut = 7'b0011000;//9
      end
      7'hA : begin
        sevenSegOut = 7'b0001000;//A
      end
      7'hB : begin
        sevenSegOut = 7'b0000011;//B
      end
      7'hC : begin
        sevenSegOut = 7'b1000110;//C
      end
      7'hD : begin
        sevenSegOut = 7'b0100001;//D
      end
      7'hE : begin
        sevenSegOut = 7'b1111111;//E (off)
      end
      7'hF : begin
        sevenSegOut = 7'b1111111;//F (off)
      end
    endcase
  end
endmodule
