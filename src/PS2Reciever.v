`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2025 18:05:07
// Design Name: 
// Module Name: PS2Reciever
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


module PS2Reciever(
  input kclk_i,
  input kdata_i,

  output [15:0] keycode_o,
  output [ 3:0] cnt_o
);

  reg [ 7:0] data_cur;  // 8-bit bus for current keyboard scan-code
  reg [ 7:0] data_prev;
  reg [ 3:0] cnt;       // counter for receiving data
  reg        flag;
  reg [15:0] keycode;

  always @(negedge kclk_i) begin
    case (cnt)
    0:; // start bit
    1: data_cur[0] <= kdata_i;
    2: data_cur[1] <= kdata_i;
    3: data_cur[2] <= kdata_i;
    4: data_cur[3] <= kdata_i;
    5: data_cur[4] <= kdata_i;
    6: data_cur[5] <= kdata_i;
    7: data_cur[6] <= kdata_i;
    8: data_cur[7] <= kdata_i;
    9: flag <= 1'b1;
    10:flag <= 1'b0;
    endcase

    cnt <= (cnt < 4'd10) ? cnt + 1 : 4'd0;

    if (flag) begin
      keycode[15:8] <= data_prev;
      keycode[ 7:0] <= data_cur;
      data_prev     <= data_cur;
    end

    // if (flag) begin
    //   if (data_prev != data_cur) begin
    //   keycode[15:8] <= data_prev;
    //   keycode[ 7:0] <= data_cur;
    //   data_prev     <= data_cur;
    //   end
    // end
  end

  // questionable realisation of 'if(flag)'
  // always @(posedge flag) begin
  //   if (data_prev != data_cur) begin
  //     keycode[15:8] <= data_prev;
  //     keycode[ 7:0] <= data_cur;
  //     data_prev     <= data_cur;
  //     end
  //   end
  // end

  assign keycode_o = keycode;

endmodule
