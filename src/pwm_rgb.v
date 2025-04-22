`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2025 20:44:21
// Design Name: 
// Module Name: pwm_rgb
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


module pwm_rgb #(
  parameter R = 8
) (
  input clk_i,
  input rst_i,
  input [R:0] r_duty, g_duty, b_duty,

  output red_LED, green_LED, blue_LED
);

  localparam TIMER_BITS  = 8;
  localparam FINAL_VALUE = 195; // reduces PWM frequency

  pwm_controller #(.R(R), .TIMER_BITS(TIMER_BITS)) pwm_red (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .duty_i(r_duty),
    .FINAL_VALUE(FINAL_VALUE),
    .pwm_o(red_LED)
  );

  pwm_controller #(.R(R), .TIMER_BITS(TIMER_BITS)) pwm_green (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .duty_i(g_duty),
    .FINAL_VALUE(FINAL_VALUE),
    .pwm_o(green_LED)
  );

  pwm_controller #(.R(R), .TIMER_BITS(TIMER_BITS)) pwm_blue (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .duty_i(b_duty),
    .FINAL_VALUE(FINAL_VALUE),
    .pwm_o(blue_LED)
  );

endmodule
