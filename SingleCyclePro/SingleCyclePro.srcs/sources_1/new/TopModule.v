`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 05:45:37 PM
// Design Name: 
// Module Name: TopModule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TopModule(
input clk, rst
    );
    
    wire [31:0] pcp1, pcout;
    wire [31:0] inst;
    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [15:0] imm;
    wire [25:0] jump;
    wire [31:0] simm;
    wire MtoRFSel, DMWE, Branch, ALUinSel, RFDSel, RFWE, Jump;
    wire [3:0] ALUSel;
    wire [31:0] pcbranch;
    wire [4:0] rtd;
    wire [31:0] ALUDM;
    wire [31:0] pcmuxout;
    wire [31:0] rfout;
    wire [31:0] ALUin1, ALUin2;
    wire [31:0] ALUOut;
    wire [31:0] DMOut;
    wire zero;
    wire [31:0] Jaddr;
    wire [31:0] pcN;
    
    Register PC (.dataIn(pcN), .clk(clk), .en(1), .rst(rst), .dataOut(pcout));
    
    Adder #(.inw1(32), .inw2(32)) PCBadd(.in1(pcp1), .in2(simm), .dataOut(pcbranch));
    
    Adder #(.inw1(32), .inw2(2)) PCadder (.in1(pcout), .in2(2'b01), .dataOut(pcp1));
    
    assign Jaddr = {pcp1[31:26], jump};
    
    MUX JMux (.in0(pcmuxout), .in1(Jaddr), .select(Jump), .dataOut(pcN));
    
    MUX PCMux (.in0(pcp1), .in1(pcbranch), .select(Branch & zero), .dataOut(pcmuxout));
    
    InstructionMemory IM (.IMA(pcout), .IMRD(inst));
    
    InstructionDecoder ID (.inst(inst), .opcode(opcode), .rs(rs), .rt(rt), .rd(rd), .shamt(shamt), .funct(funct), .imm(imm), .jump(jump));
    
    SignExtend SExt (.Imm(imm), .SImm(simm));
    
    ControlUnit CU (.opcode(opcode), .funct(funct), .MtoRFSel(MtoRFSel), .DMWE(DMWE), .Branch(Branch), .ALUSel(ALUSel), .ALUinSel(ALUinSel), .RFDSel(RFDSel), .RFWE(RFWE), .Jump(Jump));
    
    MUX #(5) RFWAMux (.in0(rt), .in1(rd), .select(RFDSel), .dataOut(rtd));
    
    //.clk(~clk) for pipelined
    RegisterFile RF (.RFRA1(rs), .RFRA2(rt), .RFWA(rtd), .RFWD(ALUDM), .clk(clk), .RFWE(RFWE), .RFRD1(ALUin1), .RFRD2(rfout));
    
    MUX ALUMux (.in0(rfout), .in1(simm), .select(ALUinSel), .dataOut(ALUin2));
    
    ALU Alucode (.ALUIn1(ALUin1), .ALUIn2(ALUin2), .ALUsel(ALUSel), .shamt(shamt), .zeroflag(zero), .outreg(ALUOut));
    
    DataMemory DM (.DMA(ALUOut), .DMWD(rfout), .clk(clk), .DMWE(DMWE), .DMOUT(DMOut));
    
    MUX DMMuxx (.select(MtoRFSel), .in0(ALUOut), .in1(DMOut), .dataOut(ALUDM));
    
endmodule
