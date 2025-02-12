`timescale 1ns/10ps 

module tb_hdmi_ethernet;

    // Testbench Signals
    logic clk_p, clk_n;
    logic rst_n;
    logic [31:0] eth_data_in;
    logic eth_valid;
    logic tmds_clk_p, tmds_clk_n;
    logic [2:0] tmds_data_p, tmds_data_n;

    // Generate Differential Clock (100MHz)
    logic clk;
    always #5 clk = ~clk;  // 10ns period = 100MHz

    assign clk_p = clk;
    assign clk_n = ~clk;

    // Instantiate DUT
    hdmi_ethernet_top uut (
        .clk_p(clk_p),
        .clk_n(clk_n),
        .rst_n(rst_n),
        .eth_data_in(eth_data_in),
        .eth_valid(eth_valid),
        .tmds_clk_p(tmds_clk_p),
        .tmds_clk_n(tmds_clk_n),
        .tmds_data_p(tmds_data_p),
        .tmds_data_n(tmds_data_n)
    );

    // Test Sequence
    initial begin
        // Initialize Signals
        clk = 0;
        rst_n = 0;
        eth_data_in = 32'd0;
        eth_valid = 0;
        
        // Reset Sequence
        #50;
        rst_n = 1;
        #20;

        // Send Sample Ethernet Video Data (Simulating Pixel Data)
        repeat (5) begin
            eth_data_in = {8'hFF, 8'h00, 8'h00, 8'h00};  // Red Pixel (R=255, G=0, B=0)
            eth_valid = 1;
            #10;
            eth_valid = 0;
            #10;
        end

        repeat (5) begin
            eth_data_in = {8'h00, 8'hFF, 8'h00, 8'h00};  // Green Pixel
            eth_valid = 1;
            #10;
            eth_valid = 0;
            #10;
        end

        repeat (5) begin
            eth_data_in = {8'h00, 8'h00, 8'hFF, 8'h00};  // Blue Pixel
            eth_valid = 1;
            #10;
            eth_valid = 0;
            #10;
        end

        // End Simulation
        #100;
        $finish;
    end

    // Monitor HDMI TMDS Outputs
    initial begin
        $monitor("Time: %t | TMDS_CLK: %b | TMDS_DATA: %b %b %b", 
                  $time, tmds_clk_p, tmds_data_p[2], tmds_data_p[1], tmds_data_p[0]);
    end

    // Dump Waveform for Analysis
    initial begin
        $dumpfile("hdmi_ethernet_tb.vcd");
        $dumpvars(0, tb_hdmi_ethernet);
    end

endmodule
