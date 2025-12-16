module top(
    input wire clk,
    input wire rst

);

    wire [31:0] pc;
    wire [31:0] next_pc;
    wire [31:0] instr;

    assign next_pc = pc + 32'd4;
    
    PC pc_inst(
        .clk(clk),
        .rst(rst),
        .next_addr(next_pc),
        .current_addr(pc)
    );

    InstrMem imem (
        .addr(pc),
        .instr(instr)
    );

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [31:0] immediate;

    decode decode_inst (
        .instr(instr),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(),        // unused only for addi
        .funct3(),
        .funct7(),
        .immediate(immediate)
    );


    wire [31:0] rs1_data;
    wire reg_write;

    assign reg_write = (opcode == 7'b0010011); // addi only

    RegisterFile register(
        .clk(clk),
        .rst(rst),
        .enable(reg_write),
        .rs1_addr(rs1),
        .rd1_data(rs1_data),
        .rs2_addr(5'b0),
        .rd2_data(),
        .rd_addr(rd),
        .wd(alu_result)
    );
    
    wire [31:0] alu_result;

    alu alu_inst (
        .a(rs1_data),
        .b(immediate),
        .alu_result(alu_result)
    );

endmodule
