module decode (
    input  wire [31:0] instr,

    output wire [6:0]  opcode,
    output wire [4:0]  rd,
    output wire [4:0]  rs1,
    output wire [4:0]  rs2,
    output wire [2:0]  funct3,
    output wire [6:0]  funct7,
    output reg [31:0] immediate
    
);

    assign opcode = instr[6:0];
    assign rd = instr[11:7];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];


    always @(*) begin
        // I-type arithmetic
        if (opcode == 7'b0010011) begin
            // checking for add immediate(addi) type operation
            if(funct3 == 3'b000) begin
                // extending the "immediate" 12 bit number to 32 bit number
                 immediate = {{20{instr[31]}}, instr[31:20]};
            end
            else begin
                immediate = 32'b0;
            end
        end
        
        // avoiding latche issues
        else begin
            immediate = 32'b0;
        end
        
    end
endmodule
