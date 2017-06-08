//Willard Wider
//to get 440hz signal from a 50MHZ signal- 50/440/2
module lab4(signalout, clk);
  output signalout;
  reg signalout;
  input clk;
  reg [31:0] mycounter1, mycounter2, myonesecond, countlow, counthigh;
  reg [3:0] progress, lastnote;
  
  initial begin
    mycounter1=0;
    mycounter2=0;
    signalout=0;
    myonesecond = 50000000;
    progress = 4'b0001;
  end
  
  always@(posedge clk) begin
    case(progress)
      default: begin
      end
      4'b0000: begin
        mycounter1 = mycounter1 + 1'b1;
        mycounter2 = mycounter2 + 1'b1;
        if (mycounter1 < countlow) begin
          signalout = 0;
        end
        if ((mycounter1 >= countlow) && (mycounter1 < counthigh)) begin
          signalout = 1;
        end
        if (mycounter1 >= counthigh) begin
          signalout = 0;
          mycounter1 = 0;
          if (mycounter2 >= myonesecond) begin
            progress = lastnote;
            mycounter2 = 0;
          end
        end
      end
      4'b0001: begin //C5, 523.25 Hz roughly
        countlow = 47778;
        counthigh = 95557;
        progress = 0;
        lastnote = 4'b0010;
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