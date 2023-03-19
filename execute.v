
module execute(zero,ALU_result,read_data1,read_data2,ALU_control_lines,immediate,ALUsrc);

input [31:0]read_data1,read_data2;
input [3:0]ALU_control_lines;
input [31:0]immediate;
input ALUsrc;

output reg [31:0]ALU_result;
output reg zero;

reg [31:0]second_source;


	always@(immediate or read_data2 or ALUsrc)
	begin
		
		if(!ALUsrc)
			
			second_source=read_data2;
		
		else 
			
			second_source=immediate;
		
	end
	
	always@(ALU_control_lines,read_data2,read_data1,second_source)
	begin
	
		case(ALU_control_lines)
			
			4'b0000:ALU_result=read_data1&second_source;
			4'b0001:ALU_result=read_data1|second_source;
			4'b0010:ALU_result=read_data1+second_source;
			4'b0110:ALU_result=read_data1-second_source;
			default:ALU_result=32'd0;
		endcase 
		
	end


endmodule