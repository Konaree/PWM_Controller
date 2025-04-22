`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 18:20:54
// Design Name: 
// Module Name: top_module
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


module top_module(
  input  CLK100MHZ,
  input  PS2_CLK,
  input  PS2_DATA,
  input  BTNU,
  
  output LED16_R,
  output LED16_G,
  output LED16_B
    );

  wire [15:0] keycode;
  wire [ 3:0] cnt;
  wire [ 8:0] color_intencity;
  wire [ 2:0] change_color;

  PS2Reciever reciever (
  .kclk_i(PS2_CLK),
  .kdata_i(PS2_DATA),

  .keycode_o(keycode),
  .cnt_o(cnt)
  );

  PS2led led (
  .kclk_i(PS2_CLK),
  .keycode_i(keycode),
  .cnt_i(cnt),

  .color_intencity_o(color_intencity),
  .change_color_o(change_color)
  );

  rgb_application rpb_app (
  .clk_i(CLK100MHZ),
  .rst_i(BTNU),
  .color_intencity(color_intencity),
  .change_color(change_color),

  .red_LED(LED16_R),
  .green_LED(LED16_G),
  .blue_LED(LED16_B),
  .red_ja(JA)
  );

endmodule
