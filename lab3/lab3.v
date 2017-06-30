//Willard Wider
//2017-06-01
//ELEC3200
//First and last name 7 segment display scroll

module lab3(clk, speed_switch, key0, key1, led0, led1, led2, led3);
  input clk;
  input speed_switch;//input control for the speed of the display refresh
  input key0;//input controls for the display (or not) of first and last name
  input key1;
  output [6:0] led0;//the 4 7 segment displays, 0=far right, 1=1 left, etc
  output [6:0] led1;
  output [6:0] led2;
  output [6:0] led3;
  wire [1:0] combineInput;
  reg [6:0] led0 = 7'b1111111;//they are also reges. init them to noting
  reg [6:0] led1 = 7'b1111111;
  reg [6:0] led2 = 7'b1111111;
  reg [6:0] led3 = 7'b1111111;
  reg [3:0] ledControl = 0;//the control register for determining what to display for the 4 leds
  reg [31:0] timer;
  reg [31:0] timerPreset_fast;//preset for fast display speed
  reg [31:0] timerPreset_slow;//preset for slow display speed
  reg [31:0] timerLimit;//the reg to be updated with which speed we are using
  reg [6:0] letters_w = 7'b1010101;//all the letters of my name
  reg [6:0] letters_i = 7'b1001111;
  reg [6:0] letters_l = 7'b1000111;
  reg [6:0] letters_a = 7'b0001000;
  reg [6:0] letters_r = 7'b0101111;
  reg [6:0] letters_d = 7'b0100001;
  reg [6:0] letters_e = 7'b0000110;
  reg [6:0] letters_space = 7'b1111111;
  reg [6:0] letters_unknown = 7'b0000000;
  assign combineInput = {key1,key0};//combine the inputs for the two name control switches

  initial begin//init stuff
    timer = 0;
    timerPreset_fast = 05000000;
    timerPreset_slow = 50000000;
    timerLimit = 0;
  end


  always @(posedge clk) begin
    timerLimit = speed_switch ? timerPreset_fast : timerPreset_slow;//ternary operator to determine which speed to use
    timer = timer + 1;
    if (timer >= timerLimit) begin
      timer = 0;//reset the timer
      ledControl = ledControl + 1;//increase the led's output state
      case (combineInput)
        2'b10 : begin//up down
          //first name
          case (ledControl)
            default : begin//unknown state
              //skip to the end
              ledControl = 4'b1111;
              end
            4'b0000 : begin//----
              led0 = letters_space;
              led1 = letters_space;
              led2 = letters_space;
              led3 = letters_space;
             end
            4'b0001 : begin//---w
              led0 = letters_w;
              led1 = letters_space;
              led2 = letters_space;
              led3 = letters_space;
             end
            4'b0010 : begin//--wi
              led0 = letters_i;
              led1 = letters_w;
              led2 = letters_space;
              led3 = letters_space;
             end
            4'b0011 : begin//-wil
              led0 = letters_l;
              led1 = letters_i;
              led2 = letters_w;
              led3 = letters_space;
             end
            4'b0100 : begin//will
              led0 = letters_l;
              led1 = letters_l;
              led2 = letters_i;
              led3 = letters_w;
             end
            4'b0101 : begin//illa
              led0 = letters_a;
              led1 = letters_l;
              led2 = letters_l;
              led3 = letters_i;
              end
            4'b0110 : begin//llar
              led0 = letters_r;
              led1 = letters_a;
              led2 = letters_l;
              led3 = letters_l;
              end
            4'b0111 : begin//lard
              led0 = letters_d;
              led1 = letters_r;
              led2 = letters_a;
              led3 = letters_l;
              end
            4'b1000 : begin//ard-
              led0 = letters_space;
              led1 = letters_d;
              led2 = letters_r;
              led3 = letters_a;
              end
            4'b1001 : begin//rd--
              led0 = letters_space;
              led1 = letters_space;
              led2 = letters_d;
              led3 = letters_r;
              end
            4'b1010 : begin//d---
              led0 = letters_space;
              led1 = letters_space;
              led2 = letters_space;
              led3 = letters_d;
              //skip to the end
              ledControl = 4'b1111;
              end
          endcase
        end
        2'b01 : begin//down up
          case (ledControl)
            //last name
            default : begin//unknown state
              //skip to the end
              ledControl = 4'b1111;
              end
            4'b0000 : begin//----
              led0 = letters_space;
              led1 = letters_space;
              led2 = letters_space;
              led3 = letters_space;
             end
            4'b0001 : begin//---w
              led0 = letters_w;
              led1 = letters_space;
              led2 = letters_space;
              led3 = letters_space;
             end
            4'b0010 : begin//--wi
              led0 = letters_i;
              led1 = letters_w;
              led2 = letters_space;
              led3 = letters_space;
             end
            4'b0011 : begin//-wid
              led0 = letters_d;
              led1 = letters_i;
              led2 = letters_w;
              led3 = letters_space;
             end
            4'b0100 : begin//wide
              led0 = letters_e;
              led1 = letters_d;
              led2 = letters_i;
              led3 = letters_w;
             end
            4'b0101 : begin//ider
              led0 = letters_r;
              led1 = letters_e;
              led2 = letters_d;
              led3 = letters_i;
              end
            4'b0110 : begin//der-
              led0 = letters_space;
              led1 = letters_r;
              led2 = letters_e;
              led3 = letters_d;
              end
            4'b0111 : begin//er--
              led0 = letters_space;
              led1 = letters_space;
              led2 = letters_r;
              led3 = letters_d;
              end
            4'b1000 : begin//r---
              led0 = letters_space;
              led1 = letters_space;
              led2 = letters_space;
              led3 = letters_d;
              //skip to the end
              ledControl = 4'b1111;
              end
            endcase
        end
        default : begin
          //catch case
          led0 = letters_space;
          led1 = letters_space;
          led2 = letters_space;
          led3 = letters_space;
          //skip to the end
          ledControl = 4'b1111;
        end
      endcase
    end
  end
endmodule

/*
module clkdivider(clkin, clkout);
input clkin;
output clkout;
reg clkout;
reg [31:0] timer;
initial begin
    timer = 0;
    clkout = 0;
end


always @(posedge clkin) begin
    timer = timer + 1;
    if (timer >= 25000000) begin
        timer = 0;
clkout = ~clkout;
    end
end
endmodule
*/
