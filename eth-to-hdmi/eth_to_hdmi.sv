`timescale 1ns/10ps
module hdmi_ethernet_top (
    input  logic        clk_p,
    input  logic        clk_n,
    input  logic        rst_n,
    input  logic [31:0] eth_data_in,
    input  logic        eth_valid,
    output logic        tmds_clk_p,
    output logic        tmds_clk_n,
    output logic [2:0]  tmds_data_p,
    output logic [2:0]  tmds_data_n
);

    logic clk;
    logic [23:0] pixel_data;
    logic pixel_valid;
    logic [23:0] processed_pixel_data;
    logic processed_pixel_valid;

    // Clocking (Differential to Single-ended)
    IBUFDS ibufds_inst (
        .I  (clk_p),
        .IB (clk_n),
        .O  (clk)
    );

    // Ethernet Receiver
    eth_rx eth_rx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .eth_data_in(eth_data_in),
        .eth_valid(eth_valid),
        .pixel_data(pixel_data),
        .pixel_valid(pixel_valid)
    );

    // Video Processing Unit
    video_proc video_proc_inst (
        .clk(clk),
        .rst_n(rst_n),
        .pixel_data_in(pixel_data),
        .pixel_valid_in(pixel_valid),
        .pixel_data_out(processed_pixel_data),
        .pixel_valid_out(processed_pixel_valid)
    );

    // HDMI Transmitter
    hdmi_tx hdmi_tx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .pixel_data(processed_pixel_data),
        .pixel_valid(processed_pixel_valid),
        .tmds_clk_p(tmds_clk_p),
        .tmds_clk_n(tmds_clk_n),
        .tmds_data_p(tmds_data_p),
        .tmds_data_n(tmds_data_n)
    );

endmodule