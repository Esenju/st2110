// Peter Mbua
// ST2110 SDI-to-IP converter
// Module: sdi_packetizer
//       Encapsulates video and audio into RTP packets

module sdi_packetizer #(
  parameter VIDEO_WIDTH = 10
  ,parameter AUDIO_WIDTH = 16
)
  (
  input logic clk, rst_n
  ,input logic [VIDEO_WIDTH-1:0] video_data
  ,input logic [AUDIO_WIDTH-1:0] audio_data
  ,input logic                   v_sync, a_valid
  ,output logic [31:0]           rtp_data
  ,output logic                  rtp_valid
  );

  always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rtp_valid <= 0;
        end else begin
          // RTP Header + Video payload (Simple Format) 
          rtp_data <= {6'b100000,     // RTP Header Fields 
                       video_data,
                       audio_data};
          rtp_valid <= v_sync;      // Send on new frame 
        end 
  end 
endmodule 
