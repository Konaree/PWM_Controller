`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Islamov Amir
// 
// Create Date: 07.03.2025 23:33:58
// Design Name: 
// Module Name: pwm_controller
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


module pwm_controller #(
  parameter R = 8,
  parameter TIMER_BITS = 15
  ) (
  input clk_i,
  input rst_i,
  input [R:0] duty_i,
  input [TIMER_BITS - 1:0] FINAL_VALUE,

  output pwm_o
    );

  wire done;

  reg [R - 1:0] cnt_ff, cnt_next;
  reg           d_ff, d_next;

  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      cnt_ff <= 'b0;
    else
      if (done)
        cnt_ff <= cnt_next;
      else
        cnt_ff <= cnt_ff;
  end

  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      d_ff <= 'b0;
    else if (done)
      d_ff <= d_next;
    else
      d_ff <= d_ff;
  end

  always @* begin
    cnt_next = cnt_ff + 1'b1;
    d_next   = (cnt_ff < duty_i);
  end

  assign pwm_o = d_ff;

  timer_input #(.BITS(TIMER_BITS)) timer (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .enable(1'b1),
    .FINAL_VALUE(FINAL_VALUE),
    .done_o(done)
  );

endmodule
