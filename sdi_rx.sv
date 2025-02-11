// Peter Mbua
// ST2110 SDI-to-IP converter
// Module: sdi_rx
//       Captures SDI serial data, extracts video/audio, and outputs parallel data

module sdi_rx #( 
  parameter VIDEO_WIDTH = 10
  ,parameter AUDIO_WIDTH = 16
)
  (input logic clk, rst_n
   ,input logic sdi_in                        // SDI serial input
   ,output logic [VIDEO_WIDTH-1:0] video_data 
   ,output logic [AUDIO_WIDTH-1:0] audio_data
   ,output logic v_sync                      // Video sync signal
   ,output logic a_valid                      // Audio valid signal
  );

  always_ff @(posedge clk or negedge rst_n) begin 
    if(!rst_n) begin 
      video_data <= '0;
      audio_data <= '0;
    end else begin 
      video_data <= {sdi_in, video_data[9:1]};  // Shift in new pixel data
      audio_data <= {sdi_in, audio_data[15:1]}; // Shift in new audio sample
    end 
  end 
endmodule 
      
