module PC (
    input  wire clk,
    input  wire rst,
    input wire enable,
    input  wire [31:0]  next_addr, // The calculated address for the next cycle
    output reg  [31:0]  current_addr // The current instruction address
);

    // PC register update logic
    always @(posedge clk) begin
        if (rst) begin
            // Reset the PC to the starting address, typically 32'h00000000
            current_addr <= 32'h00000000;
        end
        else if(enable) begin
            // On the clock edge, update the PC to the next address
            current_addr <= next_addr;
        end
    end

endmodule