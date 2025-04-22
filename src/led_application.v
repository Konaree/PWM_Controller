`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2025 19:53:13
// Design Name: 
// Module Name: rgb_application
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


module rgb_application #(
  parameter R = 8
) (
  input        clk_i,
  input        rst_i,
//  input        change_color,
  input  [R:0] color_intencity,
//  input  [1:0] color_select,
  input [2:0] change_color,

  output red_LED, green_LED, blue_LED,
  output red_ja  // JA output for logic analyzer
);

  reg [R:0] r_ff, r_next, g_ff, g_next, b_ff, b_next;

  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      r_ff <= 'b0;
    else if (change_color[0])
      r_ff <= r_next;
    else
      r_ff <= r_ff;
  end

  always @(posedge clk_i or negedge rst_i) begin
    if (rst_i) 
      g_ff <= 'b0;
    else if (change_color[1])
      g_ff <= g_next;
    else
      g_ff <= g_ff;
  end

  always @(posedge clk_i or negedge rst_i) begin
    if(rst_i)
      b_ff <= 'b0;
    else if(change_color[2])
      b_ff <= b_next;
    else
      b_ff <= b_ff;
  end

  always @* begin
    r_next = r_ff;
    g_next = g_ff;
    b_next = b_ff;
    case(change_color)
      3'b001:  r_next = color_intencity;
      3'b010:  g_next = color_intencity;
      3'b100:  b_next = color_intencity;
      default: begin
        r_next = r_ff;
        g_next = g_ff;
        b_next = b_ff;
      end
    endcase
  end

  pwm_rgb #(.R(R)) LED(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .r_duty(r_ff),
    .g_duty(g_ff),
    .b_duty(b_ff),

    .red_LED(red_LED),
    .green_LED(green_LED),
    .blue_LED(blue_LED)
  );

  assign red_ja = red_LED;

endmodule
