module ALU_last( set, overflow, result, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 
  
	output wire result;
	output wire carryOut;
	output wire set;
	output wire overflow;

	input wire a;
	input wire b;
	input wire invertA;
	input wire invertB;
	input wire[1:0] operation;
	input wire carryIn;
	input wire less;
  
    /*your code here*/ 
	assign A = invertA ^ a;
	assign B = invertB ^ b;

	wire sum;
	Full_adder f(sum, carryOut, carryIn, A, B);
	
	assign result = operation[1] ? (operation[0] ? less : sum) : (operation[0] ? A & B : A | B);
    assign set = sum;
    assign overflow = operation[1] ? carryIn ^ carryOut : 1'b0;
endmodule	
