module lab3_fake(clk, leds);
input clk;
output [7:0] leds;
reg [7:0] leds;
reg [31:0] timer;
initial begin
    timer = 0;
end
always @(posedge clk) begin
    timer = timer + 1;
    if (timer >= 50000000) begin
        timer = 0;
        leds = leds + 1;
    end
end
endmodule


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