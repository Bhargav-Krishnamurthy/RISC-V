module alu (
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] alu_result
);

    assign alu_result = a + b;

endmodule
