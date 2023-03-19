
module fetch(instruction,reset,clock);

input reset,clock;
output [31:0]instruction;

reg [31:0] pc;//program counter as a register 
reg [31:0] instruction_mem [0:7];

	initial
	begin
		
		$display("Loading memory ");
		$readmemh("instructions.txt",instruction_mem);
	end 

	always@(posedge clock or posedge reset)
	begin
		
		if(reset)
			
			pc<=32'd0;
		
		else
			
			pc<=pc+32'd1;
	end
	
   assign instruction=instruction_mem[pc];

endmodule 