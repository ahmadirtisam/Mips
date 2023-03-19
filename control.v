
module control(RegDst,Branch,MemRead,MemtoReg,ALUOP1,ALUOP0,MemWrite,ALUSrc,RegWrite,opcode);

input [5:0]opcode;
output RegDst,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Branch,ALUOP1,ALUOP0;

reg[8:0] control_lines;

	always@(opcode)
	begin
		
		case(opcode)
			
			6'd0:control_lines=9'b010001001;//R-type
			6'd35:control_lines=9'b000011110;//lw
			6'd43:control_lines=9'b000100x1x;//sw
			6'd4:control_lines=9'b101000x0x;//beq
			default:control_lines=9'b000000000;
		endcase
		
	end
	
	assign {{RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOP1,ALUOP0}}=
	{{control_lines[0]},{control_lines[1]},{control_lines[2]},{control_lines[3]},
	{control_lines[4]},{control_lines[5]},{control_lines[6]},{control_lines[7]},
	{control_lines[8]}};

endmodule