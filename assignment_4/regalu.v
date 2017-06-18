`timescale 1ns / 1ps

module regalu(Aselect, Bselect, Dselect, clk, abus, bbus, dbus, S, Cin);
    
    input [31:0] Aselect;
    input [31:0] Bselect;
    input [31:0] Dselect;
    input clk;
    output [31:0] abus;
    output [31:0] bbus;
    output [31:0] dbus;
    input [2:0] S;
    input Cin;
        
    wire [31:0] abusW;
    wire [31:0] bbusW;
    wire [31:0] dbusW;
    
    regfile reggie(
    .Aselect(Aselect),
    .Bselect(Bselect),
    .Dselect(Dselect),
    .dbus(dbusW),
    .bbus(bbusW),
    .abus(abusW),
    .clk(clk)
    );
    alupipe alup(
    .S(S),
    .Cin(Cin),
    .clk(clk),
    .abus(abusW),
    .bbus(bbusW),
    .dbus(dbusW)
    );

endmodule
