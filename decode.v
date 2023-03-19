module decode(read_data1,read_data2,immediate,instrcution,clock,reset,write_data,regDst,regWr);

//external signals
 
input [31:0]instrcution;
input [31:0]write_data;
input clock,reset;
input regDst,regWr;
output reg[31:0] read_data1,read_data2;
output reg [31:0]immediate;

//Internal signals

reg [4:0]read_register1;
reg [4:0]read_register2;
reg [4:0]write_register;

//Register file containing 32 resgiters

reg [31:0] register_file[0:31];

//variable used in for loop

integer i;
	

	//Block to assign the values on changing instrcution
	
	always@(instrcution or regDst)
	begin
		
		if(regDst)
			
			write_register=instrcution[15:11];//rd will be the write register
			
		else	
			
			write_register=instrcution[20:16];//rt will be the write register 
			
	read_register1=instrcution[25:21];
	read_register2=instrcution[20:16];
	immediate={{16'd0},{instrcution[15:0]}};	
		
	end
	
	//Block to read the registers from register file
	
	always@(read_register1 or read_register2)
	begin
			
	read_data1=register_file[read_register1];
	read_data2=register_file[read_register2];
		
	end
	
	//Block for reset and write 
	
	always@(posedge clock or posedge reset)
	begin
		
		//reset the register file 
		
		if(reset)
			
			for(i=0;i<32;i=i+1'b1)
			begin
				register_file[i]<=32'd0;
			end
			
		//write into the register file 
		
		else if(regWr)
			
			register_file[write_register]<=write_data;
			
		//maintain the orignal data 
		
		else 
			
			for(i=0;i<32;i=i+1'b1)
			begin 
			register_file[i]<=register_file[i];
			end	
	end
	
	

endmodule