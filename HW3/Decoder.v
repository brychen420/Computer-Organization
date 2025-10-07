module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o );
// Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o, MemtoReg_o

//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
 
//Internal Signals
reg        [3-1:0] ALUOp_o;
reg		   ALUSrc_o;
reg		   RegWrite_o;
reg		   RegDst_o;

//Main function
/*your code here*/
always@(*) begin
	case(instr_op_i)
		6'b000000:			// R-Type
		begin
			ALUOp_o = 3'b010;
			RegDst_o = 1'b1;
			ALUSrc_o = 1'b0;
			RegWrite_o = 1'b1;
		end

		6'b001000:			// addi
		begin
			ALUOp_o = 3'b000;
			RegDst_o = 1'b0;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
		end
	endcase
end


endmodule
   