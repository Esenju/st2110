module sdi_to_ip (
    input  logic clk,
    input  logic rst_n,
    input  logic sdi_in,
    output logic [31:0] eth_out,
    output logic        eth_valid
);
    logic [9:0]  video_data;
    logic [15:0] audio_data;
    logic [31:0] rtp_data;
    logic        rtp_valid, v_sync, a_valid;

    // SDI Receiver
    sdi_rx rx (
        .clk(clk), .rst_n(rst_n), .sdi_in(sdi_in),
        .video_data(video_data), .audio_data(audio_data),
        .v_sync(v_sync), .a_valid(a_valid)
    );

    // Packetizer
    sdi_packetizer pkt (
        .clk(clk), .rst_n(rst_n), .video_data(video_data), .audio_data(audio_data),
        .v_sync(v_sync), .a_valid(a_valid),
        .rtp_data(rtp_data), .rtp_valid(rtp_valid)
    );

    // Ethernet Transmitter
    ethernet_tx eth_tx (
        .clk(clk), .rst_n(rst_n), .rtp_data(rtp_data), .rtp_valid(rtp_valid),
        .eth_tx_data(eth_out), .eth_tx_valid(eth_valid)
    );

endmodule
