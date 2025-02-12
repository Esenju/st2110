// Peter Mbua
// ST2110 SDI-to-IP converter
// Module: sdi_rx
//       Captures SDI serial data, extracts video/audio, and outputs parallel data

module hdmi_tx (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [23:0] pixel_data,
    input  logic        pixel_valid,
    output logic        tmds_clk_p,
    output logic        tmds_clk_n,
    output logic [2:0]  tmds_data_p,
    output logic [2:0]  tmds_data_n
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tmds_data_p <= 3'b000;
            tmds_data_n <= 3'b000;
        end else if (pixel_valid) begin
            tmds_data_p <= pixel_data[2:0];  // Simplified encoding
            tmds_data_n <= ~pixel_data[2:0];
        end
    end

    assign tmds_clk_p = clk;
    assign tmds_clk_n = ~clk;

endmodule

      
