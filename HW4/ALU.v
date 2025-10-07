module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input	[32-1:0] aluSrc1;
input	[32-1:0] aluSrc2;
input	 [4-1:0] ALU_operation_i;

output	[32-1:0] result;
output			 zero;
output			 overflow;

//Internal Signals
wire		 zero;
wire		 overflow;
reg	[32-1:0] result;

//Main function
/*your code here*/
assign zero = ~(|result);

always@(*)begin
	case(ALU_operation_i)
		4'b0000: result = aluSrc1 | aluSrc2;
		4'b0001: result = aluSrc1 & aluSrc2;
		4'b0010: result = $signed(aluSrc1) + $signed(aluSrc2);
		4'b0110: result = $signed(aluSrc1) - $signed(aluSrc2);
		4'b0111: result = ($signed(aluSrc1) < $signed(aluSrc2)) ? 32'b1 : 32'b0;
        4'b1100: result = ~(aluSrc1 | aluSrc2);
		default: result = 0;
	endcase
end

endmodule