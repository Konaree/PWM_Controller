`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2025 19:48:27
// Design Name: 
// Module Name: PS2led
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


module PS2led #(
  parameter R = 8
)(
  input [15:0] keycode_i,
  input [ 3:0] cnt_i,
  input kclk_i,

  output [R:0] color_intencity_o,
  output [2:0] change_color_o

);                            

  reg [2:0] rgb_reg;
  reg [1:0] color_flag = 'b0;
  reg [R:0] color_intencity_rg = 'b0;
  reg [2:0] change_color_rg = 'b0;

  wire       off_en;
  wire       data_sent;
  wire [7:0] data_prev;
  wire [7:0] data_cur;

  assign data_prev = keycode_i[15:8];
  assign data_cur  = keycode_i[7:0];
  assign data_sent = cnt_i;  // counter to track the end of a transaction

  always @(negedge kclk_i) begin
    if (!data_sent) begin
      case (data_cur)
        8'h2D: begin color_flag <= 2'b01;
        end
        8'h34: begin color_flag <= 2'b10;
        end
        8'h32: begin color_flag <= 2'b11;
        end
      endcase
      case (color_flag)
        2'b01: case(data_cur)
                 8'h45: begin color_intencity_rg <= 9'b0;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h16: begin color_intencity_rg <= 9'd30;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h1E: begin color_intencity_rg <= 9'd60;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h26: begin color_intencity_rg <= 9'd90;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h25: begin color_intencity_rg <= 9'd120;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h2E: begin color_intencity_rg <= 9'd150;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h36: begin color_intencity_rg <= 9'd180;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h3D: begin color_intencity_rg <= 9'd210;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h3E: begin color_intencity_rg <= 9'd230;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
                 8'h46: begin color_intencity_rg <= 9'd256;
                              change_color_rg    <= 3'b001;
                              color_flag      <= 'b0;
                        end
               endcase
        2'b10: case(data_cur)
                 8'h45: begin color_intencity_rg <= 9'b0;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h16: begin color_intencity_rg <= 9'd30;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h1E: begin color_intencity_rg <= 9'd60;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h26: begin color_intencity_rg <= 9'd90;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h25: begin color_intencity_rg <= 9'd120;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h2E: begin color_intencity_rg <= 9'd150;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h36: begin color_intencity_rg <= 9'd180;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h3D: begin color_intencity_rg <= 9'd210;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h3E: begin color_intencity_rg <= 9'd230;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
                 8'h46: begin color_intencity_rg <= 9'd256;
                              change_color_rg    <= 3'b010;
                              color_flag      <= 'b0;
                        end
               endcase
        2'b11: case(data_cur)
                 8'h45: begin color_intencity_rg <= 9'b0;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h16: begin color_intencity_rg <= 9'd30;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h1E: begin color_intencity_rg <= 9'd60;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h26: begin color_intencity_rg <= 9'd90;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h25: begin color_intencity_rg <= 9'd120;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h2E: begin color_intencity_rg <= 9'd150;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h36: begin color_intencity_rg <= 9'd180;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h3D: begin color_intencity_rg <= 9'd210;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h3E: begin color_intencity_rg <= 9'd230;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
                 8'h46: begin color_intencity_rg <= 9'd256;
                              change_color_rg    <= 3'b100;
                              color_flag      <= 'b0;
                        end
               endcase
      endcase
    end
  end

  assign color_intencity_o = color_intencity_rg;
  assign change_color_o    = change_color_rg;

endmodule
