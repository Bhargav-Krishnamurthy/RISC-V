module RegisterFile (
    input  wire rst, 
    input  wire clk,
    input  wire we,          // Write Enable
    input  wire  [4:0] rs1_addr,    // Read Port 1 Address (0-31)
    output wire [31:0] rd1_data,    // Read Port 1 Data
    input  wire  [4:0] rs2_addr,    // Read Port 2 Address (0-31)
    output wire [31:0] rd2_data,     // Read Port 2 Data
    input  wire  [4:0] rd_addr,     // Write Port Address (0-31)
    input  wire [31:0] wd,          // Write Data
);

    // 32 registers, each 32 bits wide.
    reg [31:0] registers [0:31]; 

    // make output 32'b0

    assign rd1_data = (rs1_addr == 5'd0) ? 32'b0 : registers[rs1_addr];
    assign rd2_data = (rs2_addr == 5'd0) ? 32'b0 : registers[rs2_addr];


    always @(posedge clk) begin
        if (rst) begin
            // resetting all the register values to 0.
            // index = 0 is read-only and by default set to 32'b0
            for (int i = 1; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end 
        else if (we && (rd_addr != 5'b00000)) begin 
            registers[rd_addr] <= wd;
        end
    end

endmodule
