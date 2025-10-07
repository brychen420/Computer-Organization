module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o, MemtoReg_o);
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output	[2-1:0]	RegDst_o, MemtoReg_o;
output			Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o;
 
//Internal Signals
reg	[3-1:0] ALUOp_o;
reg			ALUSrc_o;
reg			RegWrite_o;
reg	[2-1:0]	RegDst_o, MemtoReg_o;
reg			Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o;

//Main function
/*your code here*/

always@(*)
begin
	case(instr_op_i)
		6'b000000:			// R-Type
		begin
			ALUOp_o = 3'b010;
			RegDst_o = 2'b01;
			ALUSrc_o = 1'b0;
			RegWrite_o = 1'b1;
			Branch_o = 1'b0;
			BranchType_o = 1'b0;
			Jump_o = 1'b1;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
		end

		6'b100010:			// Jump
		begin
			ALUOp_o = 3'b111;
			RegDst_o = 2'b00;
			ALUSrc_o = 1'b0;
			RegWrite_o = 1'b0;
			Branch_o = 1'b0;
			BranchType_o = 1'b0;
			Jump_o = 1'b0;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
		end

		6'b001000:			// addi
		begin
			ALUOp_o = 3'b011;
			RegDst_o = 2'b00;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			Branch_o = 1'b0;
			BranchType_o = 1'b0;
			Jump_o = 1'b1;
	   		MemRead_o = 1'b0;
	   		MemWrite_o = 1'b0;
	        MemtoReg_o = 2'b00;
		end

		6'b111011:			// beq
		begin
			ALUOp_o = 3'b001;
			RegDst_o = 2'b00;
			ALUSrc_o = 1'b0;
			RegWrite_o = 1'b0;
			Branch_o = 1'b1;
			BranchType_o = 1'b0;
			Jump_o = 1'b1;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
		end

		6'b100101:			// bne
		begin
			ALUOp_o = 3'b110;
			RegDst_o = 2'b00;
			ALUSrc_o = 1'b0;
			RegWrite_o = 1'b0;
			Branch_o = 1'b1;
			BranchType_o = 1'b1;
			Jump_o = 1'b1;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
		end

		6'b100001:			// lw
		begin
			ALUOp_o = 3'b000;
			RegDst_o = 2'b00;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			Branch_o = 1'b0;
			BranchType_o = 1'b0;
			Jump_o = 1'b1;
			MemRead_o = 1'b1;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b01;
		end

		6'b100011:			// sw
		begin
			ALUOp_o = 3'b000;
			RegDst_o = 2'b00;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b0;
			Branch_o = 1'b0;
			BranchType_o = 1'b0;
			Jump_o = 1'b1;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b1;
			MemtoReg_o = 2'b00;
		end

	endcase
end

endmodule
   