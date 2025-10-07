module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire 	RegWrite, RegDst, ALUSrc, ALU_zero, ALU_overflow;
wire 	[1:0] FURslt;
wire 	[2:0] ALUOp;
wire 	[3:0] ALU_operation;
wire 	[4:0] WriteReg;
wire 	[31:0] pc_in, pc_out, instr, WriteData, Data1, Data2, signed_extend, unsigned_extend, Data2_R, ALU_result, shifter_result;

//modules
Program_Counter PC(
        .clk_i(clk_i),      
        .rst_n(rst_n),     
        .pc_in_i(pc_in) ,   
        .pc_out_o(pc_out) 
        );
	
Adder Adder1(
        .src1_i(pc_out),     
        .src2_i(32'd4),
        .sum_o(pc_in)    
        );

Instr_Memory IM(
        .pc_addr_i(pc_out),  
        .instr_o(instr)    
        );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(RegDst),
        .data_o(WriteReg)
        );

Reg_File RF(
        .clk_i(clk_i),      
        .rst_n(rst_n) ,     
        .RSaddr_i(instr[25:21]),  
        .RTaddr_i(instr[20:16]),  
        .RDaddr_i(WriteReg),   
        .RDdata_i(WriteData), 
        .RegWrite_i(RegWrite),
        .RSdata_o(Data1),  
        .RTdata_o(Data2)   
        );

Decoder Decoder(
        .instr_op_i(instr[31:26]), 
        .RegWrite_o(RegWrite), 
        .ALUOp_o(ALUOp),   
        .ALUSrc_o(ALUSrc),   
        .RegDst_o(RegDst)   
        );

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALU_operation_o(ALU_operation),
        .FURslt_o(FURslt)
        );

Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(signed_extend)
        );

Zero_Filled ZF(
        .data_i(instr[15:0]),
        .data_o(unsigned_extend)
        );

Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(Data2),
        .data1_i(signed_extend),
        .select_i(ALUSrc),
        .data_o(Data2_R)
        );

ALU ALU(
        .aluSrc1(Data1),
        .aluSrc2(Data2_R),
        .ALU_operation_i(ALU_operation),
        .result(ALU_result),
        .zero(ALU_zero),
        .overflow(ALU_overflow) 
        );

Shifter shifter( 
        .result(shifter_result), 
        .leftRight(ALU_operation[0]),
        .shamt(instr[10:6]),
        .sftSrc(Data2_R) 
        );
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ALU_result),
        .data1_i(shifter_result),
        .data2_i(unsigned_extend),
        .select_i(FURslt),
        .data_o(WriteData)
        );			

endmodule


