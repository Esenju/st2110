// Peter Mbua
// ST2110 SDI-to-IP converter
// Module: sdi_packetizer
//       Encapsulates video and audio into RTP packets

module video_proc(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [23:0] pixel_data_in,
    input  logic        pixel_valid_in,
    output logic [23:0] pixel_data_out,
    output logic        pixel_valid_out
);


    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pixel_data_out  <= 24'b0;
            pixel_valid_out <= 1'b0;
        end else begin
            pixel_data_out  <= pixel_data_in;  // Pass-through for now
            pixel_valid_out <= pixel_valid_in;
        end
    end

endmodule

