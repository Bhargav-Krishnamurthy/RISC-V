module alu (
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] op
);

    assign op = a + b;

endmodule
