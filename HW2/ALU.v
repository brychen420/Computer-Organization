module ALU( result, zero, overflow, aluSrc1, aluSrc2, invertA, invertB, operation );
   
	output wire[31:0] result;
	output wire zero;
	output wire overflow;

	input wire[31:0] aluSrc1;
	input wire[31:0] aluSrc2;
	input wire invertA;
	input wire invertB;
	input wire[1:0] operation;
	
	/*your code here*/
	wire [32:1] carryOut;
	genvar i;
	generate
		for (i = 1; i < 31; i = i + 1) begin
			ALU_1bit alu(result[i], carryOut[i+1], aluSrc1[i], aluSrc2[i], invertA, invertB, operation, carryOut[i], 1'b0);
		end
	endgenerate
	wire set;
	ALU_last last (set, overflow, result[31], carryOut[32], aluSrc1[31], aluSrc2[31], invertA, invertB, operation, carryOut[31], 1'b0);
	ALU_1bit first (result[0], carryOut[1], aluSrc1[0], aluSrc2[0], invertA, invertB, operation, invertB, set);
	assign zero = result ?  1'b0 : 1'b1;
endmodule