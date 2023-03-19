
module memory(data_out,write_data,clock,ALU_result,MemRead,MemWrite,MemtoReg);

input [31:0] ALU_result;
input [31:0] write_data;
input MemRead,MemWrite,MemtoReg,clock;

output reg [31:0]data_out;

reg [31:0]read_data;

integer i;

//data memory

reg [31:0] data_memory[0:15];

	initial
	begin
		
		$display("Loading memory ");
		$readmemh("data_memory.txt",data_memory);
	end 

	
	always@(MemtoReg,read_data,ALU_result)
	begin
		
		if(MemtoReg)
			
			data_out=read_data;
		
		else 
			
			data_out=ALU_result;
	end
	
	
	always@(posedge clock or posedge MemRead)
	begin	
	
		if(MemRead)
			
			read_data<=data_memory[ALU_result[3:0]];
		
		else if(MemWrite)
			
			data_memory[ALU_result[3:0]]<=write_data;
	end
	

endmodule