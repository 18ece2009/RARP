`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2019 04:24:43 PM
// Design Name: 
// Module Name: arp_transm
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


module rarp_tra(hdw_length,pro_length,operation,hdr_type,proto_type,send_hdr_addr,send_ip_addr,target_hdr_addr,target_ip_addr,transmitted_op,clk,op_ack,input_hold);
input [15:0] hdr_type;        //hardware type
input [15:0] proto_type;      //protocol type
input [47:0] send_hdr_addr;   //sender mac address
input [31:0] send_ip_addr;    //sender ip address
input [47:0] target_hdr_addr; //target mac address
input [31:0] target_ip_addr;  //target ip address
input [7:0] hdw_length;
input [15:8] pro_length;
input [31:0] operation;
input clk;                    //clock

output reg [31:0] transmitted_op; //transmitted output 

output reg op_ack=1;  //output is transmitted

output reg input_hold=0;

 reg [31:0] R0;
 reg [31:0] R1;
 reg [31:0] R2;
 reg [31:0] R3;
 reg [31:0] R4;
 reg [31:0] R5;
 reg [31:0] R6;
 
 parameter s0=3'b000;
 parameter s1=3'b001;
 parameter s2=3'b010;
 parameter s3=3'b011;
 parameter s4=3'b100;
 parameter s5=3'b101;
 parameter s6=3'b110;
 
reg [2:0]state;
reg [2:0]next_state=s0;




always@(posedge clk & op_ack)
begin
   /*storing the input into temporary registers before transferring to the output*/
  R0 <= {hdr_type,proto_type};
  R1 <={hdw_length,pro_length,operation};
  R2 <= send_hdr_addr[47:16];
  R3 <= {send_hdr_addr[15:0],send_ip_addr[31:16]};
  R4 <= {send_ip_addr[15:0],target_hdr_addr[47:32]};
  R5 <= target_hdr_addr[31:0];
  R6 <= target_ip_addr;
  op_ack<=0;
  
 end
    
    


   
always@(posedge clk)
begin
state<=next_state;
end   

always@(state)
begin
case(state)
s0 : begin 
     next_state<=s1;
     transmitted_op<=R0;
     input_hold<=1;
     end
s1 : begin
     next_state<=s2;
     transmitted_op<=R1;
     end     
s2 : begin
     next_state<=s3;
     transmitted_op<=R2;
     end
s3 : begin 
     next_state<=s4;
     transmitted_op<=R3;
     end
s4 : begin 
     next_state<=s5;
     transmitted_op<=R4;
     end
s5 : begin 
     next_state<=s6;
     transmitted_op<=R5;
     end
 s6 : begin 
          next_state<=s0;
          transmitted_op<=R6;
          op_ack<=1;
          input_hold<=0;
          end   
default : next_state<=s0;

endcase




end



    
endmodule

