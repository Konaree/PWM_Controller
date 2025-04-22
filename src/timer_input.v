`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Islamov Amir
// 
// Create Date: 07.03.2025 17:17:42
// Design Name: 
// Module Name: timer_input
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


module timer_input #(
    parameter BITS = 4
) (
  input clk_i,
  input rst_i,
  input enable,
  input [BITS - 1:0] FINAL_VALUE,

  output done_o
);

  reg [BITS - 1:0] timer_ff, timer_next;

  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      timer_ff <= 'b0;
    else if (enable)
      timer_ff <= timer_next;
    else
      timer_ff <= timer_ff;
  end

  assign done_o = (timer_ff == FINAL_VALUE);

  always @* begin
    timer_next = (done_o) ? 'b0 : timer_ff + 1'b1;
  end

endmodule