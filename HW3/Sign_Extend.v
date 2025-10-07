module Sign_Extend( data_i, data_o );

//I/O ports
input	[16-1:0] data_i;
output	[32-1:0] data_o;

//Internal Signals
wire	[32-1:0] data_o;

//Sign extended
/*your code here*/
always@(*)
begin
    data_o[32-1:0] = { {16{data_i[15]}}, data_i[15:0] };
end   

endmodule      
