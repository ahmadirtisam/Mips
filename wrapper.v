
module wrapper(data_out,RegDst,Branch,MemRead,MemtoReg,ALUOP1,ALUOP0,MemWrite,ALUSrc,RegWrite,instruction,opcode,write_data,function_field,ALUOP,ALU_result,clock,reset);

input clock,reset;
output [31:0]data_out;
output [31:0] instruction;
output[31:0]ALU_result;
output [5:0]opcode;
output RegDst,Branch,MemRead,MemtoReg,ALUOP1,ALUOP0,MemWrite,ALUSrc,RegWrite;
output [5:0]function_field;
output [1:0]ALUOP;
output [31:0]write_data;

wire [3:0]ALU_control_lines;
wire [31:0]immediate;
wire[31:0]read_data2;
wire [5:0]function_field;
wire [1:0]ALUOP;
wire [31:0]write_data;
wire [31:0]read_data1;

wire zero;



	assign opcode=instruction[31:26];
	assign function_field=instruction[5:0];
	assign ALUOP={{ALUOP1},{ALUOP0}};

	fetch module1(.clock(clock),
	              .reset(reset),
					  .instruction(instruction)
					  );
					  
	control module2(.opcode(opcode),
						 .RegDst(RegDst),
						 .Branch(Branch),
						 .MemRead(MemRead),
						 .MemtoReg(MemtoReg),
						 .ALUOP1(ALUOP1),
						 .ALUOP0(ALUOP0),
						 .MemWrite(MemWrite),
						 .ALUSrc(ALUSrc),
						 .RegWrite(RegWrite)
						);
	ALUControl module3(.function_field(function_field),
							 .ALUOP(ALUOP),
							 .ALU_control_lines(ALU_control_lines)
							);
	
	decode module4(
						.instrcution(instruction),
						.clock(clock),
						.reset(reset),
						.write_data(data_out),
						.regDst(RegDst),
						.regWr(RegWrite),
						.immediate(immediate),
						.read_data1(read_data1),
						.read_data2(read_data2)
	);
	
	execute module5(
						.read_data1(read_data1),
						.read_data2(read_data2),
						.immediate(immediate),
						.ALUsrc(ALUSrc),
						.ALU_control_lines(ALU_control_lines),
						.ALU_result(ALU_result),
						.zero(zero)
	
	);
	
	memory module6(
					  .write_data(read_data2),
					  .ALU_result(ALU_result),//as an address
					  .clock(clock),
					  .MemRead(MemRead),
					  .MemWrite(MemWrite),
					  .MemtoReg(MemtoReg),
					  .data_out(data_out)
	);
	
	
	
endmodule