// Peter Mbua
// ST2110 SDI-to-IP converter
// Module: ethernet_tx
//       Encapsulates RTP packets into Ethernet frames

module ethernet_tx #(
  parameter RTP_WIDTH = 32
)
  (
    input logic                   clk, rst_n
    ,input logic [RTP_WIDTH-1:0]  rtp_data
    ,input logic                  rtp_valid 
    ,output logic [RTP_WIDTH-1:0] eth_tx_data    // Ethernet Output 
    ,output logic                 eth_tx_valid   // Ethernet TX valid 
  );

  always_ff @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin 
      eth_tx_valid <= 0;
    end else begin 
      if(rtp_valid) begin
        eth_tx_data <= {16'h0800, rtp_data}; // Ethenet Header + RTP Payload 
        eth_tx_valid <= 1; 
      end 
    end 
   end
endmodule 
        
  
