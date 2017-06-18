//Willard Wider
//6-15-17
//ELEC 3200
//Lab 4

module lab4(signalout, clk);
  output signalout;
  reg signalout;
  input clk;
  reg [31:0] mycounter1, mycounter2, myonesecond, countlow, counthigh;
  reg [3:0] progress, lastnote;
  
  initial begin
    //init everything
    mycounter1=0;
    mycounter2=0;
    signalout=0;
    myonesecond = 50000000;
    progress = 4'b0001;
  end
  
  always@(posedge clk) begin
    case(progress)
      default: begin
      //do nothing
      end
      4'b0000: begin
        mycounter1 = mycounter1 + 1'b1;//incriment the first counter
        mycounter2 = mycounter2 + 1'b1;//incriment the second counter
        if (mycounter1 < countlow) begin
          signalout = 0;//send out the 0 part of the duty cycle
        end
        if ((mycounter1 >= countlow) && (mycounter1 < counthigh)) begin
          signalout = 1;//send out the 1 part of the dury cycle
        end
        if (mycounter1 >= counthigh) begin
          signalout = 0;//set it back to low
          mycounter1 = 0;//reset the counter
          if (mycounter2 >= myonesecond) begin//if it has been doing this signal for one second
            progress = lastnote;//increment the case statement control below for the new tone
            mycounter2 = 0;
          end
        end
      end
      4'b0001: begin //C5, 523.25 Hz roughly
        countlow = 47778;//set the low part of the duty cycle
        counthigh = 95557;//set the high part of the duty cycle
        progress = 0;//reset the progress
        lastnote = 4'b0010;//set the next note
      end
      4'b0010: begin //D5, 587.23 Hz roughly
        countlow = 42573;
        counthigh = 85146;
        progress = 0;
        lastnote = 4'b0011;
      end
      4'b0011: begin //E5, 659.26 Hz roughly
        countlow = 37921;
        counthigh = 75843;
        progress = 0;
        lastnote = 4'b0100;
      end
      4'b0100: begin //F5, 698.46 Hz roughly
        countlow = 35793;
        counthigh = 71586;
        progress = 0;
        lastnote = 4'b0101;
      end
      4'b0101: begin //G5, 783.99 Hz roughly
        countlow = 31888;
        counthigh = 63776;
        progress = 0;
        lastnote = 4'b0110;
      end
      4'b0110: begin //A5, 880 Hz roughly
        countlow = 28409;
        counthigh = 56818;
        progress = 0;
        lastnote = 4'b0111;
      end
      4'b0111: begin //B5, 9.87.77 Hz roughly
        countlow = 25310;
        counthigh = 50619;
        progress = 0;
        lastnote = 4'b1000;
      end
      4'b1000: begin //C6, 1046.5 Hz roughly
        countlow = 23889;
        counthigh = 47778;
        progress = 0;
        lastnote = 4'b1001;
      end
      4'b1001: begin //D6, 1174.7 Hz roughly
        countlow = 21282;
        counthigh = 42564;
        progress = 0;
        lastnote = 4'b1010;
      end
      4'b1010: begin //E6, 1318.5 Hz roughly
        countlow = 18961;
        counthigh = 37922;
        progress = 0;
        lastnote = 4'b1011;
      end
      4'b1011: begin //F6, 1396.9 Hz roughly
        countlow = 17897;
        counthigh = 35794;
        progress = 0;
        lastnote = 4'b1100;
      end
      4'b1100: begin //G6, 1568 Hz roughly
        countlow = 15944;
        counthigh = 31888;
        progress = 0;
        lastnote = 4'b0001;
      end
    endcase
  end
endmodule