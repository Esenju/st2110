// Peter Mbua
// ST2110 SDI-to-IP converter
// Module: ethernet_tx
//       Encapsulates RTP packets into Ethernet frames

module eth_rx (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [31:0] eth_data_in,  // Data from Ethernet
    input  logic        eth_valid,
    output logic [23:0] pixel_data,   // RGB Video Data
    output logic        pixel_valid
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pixel_data  <= 24'b0;
            pixel_valid <= 1'b0;
        end else if (eth_valid) begin
            pixel_data  <= eth_data_in[23:0];  // Extract RGB data
            pixel_valid <= 1'b1;
        end else begin
            pixel_valid <= 1'b0;
        end
    end

endmodule
 
        
  
