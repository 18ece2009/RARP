`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2019 02:22:48 PM
// Design Name: 
// Module Name: multiplexer_4_to_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiplexer_4_to_1(out,i0,i1,i2,i3,s1,s0);
    output out;
    input i0,i1,i2,i3;
    input s1,s0;
    wire s1n,s0n;
    wire Y0,Y1,Y2,Y3;
    not(s1n,s1);
    not(s0n,s0);
    and(Y0,i0,s1n,s0n);
    and(Y1,i1,s1n,s0);
    and(Y2,i2,s1,s0n);
    and(Y3,i3,s1,s0);
    or(out,Y0,Y1,Y2,Y3);
endmodule
