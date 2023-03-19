

module ALUControl(ALU_control_lines,function_field,ALUOP);

input [1:0]ALUOP;
input [5:0]function_field;
output reg [3:0]ALU_control_lines;

	
	always@(ALUOP,function_field)
	begin
		
		//Beq and the the control lines are for subtract
		if(ALUOP[0])
			
			ALU_control_lines=4'b0110;
		
		//lw,sw and and the control lines are for addition
		else if(!ALUOP[1])
			
			ALU_control_lines=4'b0010;
		
		else
			//R-type and the decision will be based on function field
			case(function_field)
				
				6'd32:ALU_control_lines=4'b0010;//add
				6'd34:ALU_control_lines=4'b0110;//sub
				6'd36:ALU_control_lines=4'b0000;//and
				6'd37:ALU_control_lines=4'b0001;//or
				default:ALU_control_lines=4'b0001;
				
			endcase		
	end

endmodule