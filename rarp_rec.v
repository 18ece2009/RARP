`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2019 03:55:05 PM
// Design Name: 
// Module Name: arpn_c
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


module rarp_rec(input_rec,hdw_length,pro_length,operation,hdr_type,proto_type,send_hdr_addr,send_ip_addr,target_hdr_addr,target_ip_addr,clk,rst,input_ack);
input [31:0]input_rec;
output reg [15:0] hdr_type;
output reg [15:0] proto_type;
output reg [47:0] send_hdr_addr;
output reg [31:0] send_ip_addr;
output reg [47:0] target_hdr_addr;
output reg [31:0] target_ip_addr;
output reg[7:0]hdw_length;
output reg [7:0]pro_length;
output reg [15:0]operation;
input clk;
input rst;
output reg input_ack=0;

 reg [31:0] R0=0;
 reg [31:0] R1=0;
 reg [31:0] R2=0;
 reg [31:0] R3=0;
 reg [31:0] R4=0;
 reg [31:0] R5=0;
 reg [31:0] R6=0;
    
 parameter s0=3'b000;
 parameter s1=3'b001;
 parameter s2=3'b010;
 parameter s3=3'b011;
 parameter s4=3'b100;
 parameter s5=3'b101;
 parameter s6=3'b110; 
 
reg [2:0]state;
reg [2:0]next_state=s0;

always@(posedge clk)
begin
state<=next_state;
end  

always@(state)
begin
case(state)
s0 : begin 
     next_state<=s1;
     R0<=input_rec;
     input_ack<=0;
     end
s1 : begin
     next_state<=s2;
     R1<=input_rec;
     end     
s2 : begin
     next_state<=s3;
     R2<=input_rec;
     end
s3 : begin 
     next_state<=s4;
     R3<=input_rec;
     end
s4 : begin 
     next_state<=s5;
     R4<=input_rec;
     end
s5 : begin 
     next_state<=s6;
     R5<=input_rec;
     end
s6 : begin 
     next_state<=s0;
     R6<=input_rec;
     input_ack<=1;
     end
default : next_state<=s0;

endcase

end

always@(posedge clk)
begin
if(rst)
begin
hdr_type<=0;
proto_type<=0;
send_hdr_addr<=0;
send_ip_addr<=0;
target_hdr_addr<=0;
target_ip_addr<=0;
end

else
begin
hdr_type=R0[31:16];
proto_type<=R0[15:0];
hdw_length<=R1[31:24];
pro_length<=R1[23:16];
operation<=R1[15:0];
send_hdr_addr<={R2,R3[31:16]};
send_ip_addr<={R3[15:0],R4[31:16]};
target_hdr_addr<={R4[15:0],R5};
target_ip_addr<=R6;
end


end


endmodule
