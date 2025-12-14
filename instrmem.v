module InstrMem (
    input  wire [31:0] addr,   // PC (address)
    output wire [31:0] instr    // fetched instruction
);

    reg [31:0] mem [0:255];
    assign instr = mem[addr[31:2]];

    initial begin
        $readmemh("program.hex", mem);
    end

endmodule
