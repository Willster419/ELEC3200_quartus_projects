module lab7(VGA_CLK,VGA_BLANK_N,VGA_VS,VGA_HS,VGA_SYNC_N, clk, VGA_R, VGA_B, VGA_G);
  output VGA_CLK;
  output VGA_BLANK_N;
  output VGA_VS;
  output VGA_HS;
  output VGA_SYNC_N;
  output [7:0] VGA_R, VGA_B, VGA_G;
  input clk;
  
  //required regies
  //50Mhz clock = 50,000,000Hz clock
  
  reg [31:0] refreshCounter;//for counting when need to move stuff
  reg [31:0] counterLimit;
  reg [6:0] movementAmmount;//can be from 0 to 100
  reg upDown;
  reg [6:0] higherLimit;
  reg lowerLimit;
  reg [5:0] amt;
  reg [9:0] center;
  reg amtBitSet;
  reg [7:0] vga_x_counter;
  
  //	For VGA Controller
  reg [9:0]	mRed;
  reg [9:0]	mGreen;
  reg [9:0]	mBlue;
  wire [10:0]	VGA_X;
  wire [10:0]	VGA_Y;
  wire VGA_Read;	//	VGA data request
  wire m1VGA_Read;	//	Read odd field
  wire m2VGA_Read;	//	Read even field
  
  //	VGA Controller
  wire [9:0] vga_r10;
  wire [9:0] vga_g10;
  wire [9:0] vga_b10;
  assign VGA_R = vga_r10[9:2];
  assign VGA_G = vga_g10[9:2];
  assign VGA_B = vga_b10[9:2];
  reg clkDiv;
  
  initial begin
  clkDiv = 0;
  mRed = 0;
  mGreen = 0;
  mBlue = 0;
  //counterLimit = 250000;//5ms
  //counterLimit = 20000;
  counterLimit = 1250000;//12.5ms
  //counterLimit = 2500000;//50ms
  //counterLimit = 25000000;//500ms
  refreshCounter = 0;
  upDown = 1;//up
  movementAmmount = 0;//original places first
  lowerLimit = 0;
  higherLimit = 100;
  center = 374;//the horizonal center of the triangle
  amt = 0;
  amtBitSet = 0;//false
  vga_x_counter = 0;
  end

  VGA_Ctrl      u9  (//	Host Side
                .iRed(mRed),
                .iGreen(mGreen),
                .iBlue(mBlue),
                .oCurrent_X(VGA_X),
                .oCurrent_Y(VGA_Y),
                .oRequest(VGA_Read),
                //	VGA Side
                .oVGA_R(vga_r10),
                .oVGA_G(vga_g10),
                .oVGA_B(vga_b10),
                .oVGA_HS(VGA_HS),
                .oVGA_VS(VGA_VS),
                .oVGA_SYNC(VGA_SYNC_N),
                .oVGA_BLANK(VGA_BLANK_N),
                .oVGA_CLOCK(VGA_CLK),
                //	Control Signal
                .iCLK(clkDiv),
                .iRST_N(1));
  always @(posedge clk) begin
    clkDiv = ~clkDiv;
    refreshCounter = refreshCounter + 1;
    if (refreshCounter > counterLimit) begin
    refreshCounter = 0;
      //incriment the amount to move
      movementAmmount = upDown? movementAmmount + 1: movementAmmount - 1;
      case (movementAmmount)
        lowerLimit: begin
          upDown = 1;//move up
        end
        higherLimit: begin
          upDown = 0;//move down
        end
      endcase
    end
    //set everything to yellow first
    //low intenslity blue
    //mBlue = 10'b0011111111;
    //yellow
    mBlue = 10'b0011111111;
    mRed = 10'b1111111111;
    mGreen = 10'b1111111111;
    //purple, in case you want it
    //mBlue = 10'b1111111111;
    //mRed = 10'b1111111111;
    //mGreen = 10'b0000000000;
    //draw the first square. make it blue
    if ((99 < VGA_X && VGA_X < 301) && (99+movementAmmount < VGA_Y && VGA_Y < 301+movementAmmount)) begin
      mBlue = 10'b1111111111;
      mRed = 10'b0011111111;
      mGreen = 10'b0011111111;
    end
    //draw the second square. make it red
    if ((149 < VGA_X && VGA_X < 251) && (149+movementAmmount < VGA_Y && VGA_Y < 251+movementAmmount)) begin
      mBlue = 10'b0011111111;
      mRed = 10'b1111111111;
      mGreen = 10'b0011111111;
    end
    //draw the third square for the arrow. make it green
    if ((349 < VGA_X && VGA_X < 401) && (149+movementAmmount < VGA_Y && VGA_Y < 301+movementAmmount)) begin
      mBlue = 10'b0011111111;
      mRed = 10'b0011111111;
      mGreen = 10'b1111111111;
    end
    //draw the triangle
    if(99+movementAmmount < VGA_Y && VGA_Y < 151+movementAmmount) begin
      if(center-amt < VGA_X && VGA_X < center+amt) begin
        if(!amtBitSet) begin
          amt = amt + 1;
          amtBitSet = 1;
        end
        mBlue = 10'b0011111111;
        mRed = 10'b0011111111;
        mGreen = 10'b1111111111;
        //amt = amt +1;
      end
      else begin
        if(amtBitSet) begin
          amtBitSet = 0;
        end
      end
    end
    if(VGA_X == 0 && VGA_Y == 0) begin//new image
      amt = 1;
    end
  end
endmodule
