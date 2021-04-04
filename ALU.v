// In this project, the size of register array is 2.
// i.e., the register address can only be 00000 or 00001
// 00000 ===> regA
// 00001 ===> regB


// flags[2] = zero flag                 : beq, bne
// flags[1] = negative flag             : slt, slti, sltiu, sltu
// flags[0] = overflow flag             : add, addi, sub


module alu ( instruction, regA, regB, result, flags );

    input [31:0] instruction, regA, regB;

    output reg [31:0] result;
    output reg [2:0] flags;


    reg [5:0] op, funct;
    reg [31:0] rs_reg, rt_reg;           // `rd` not used
    reg [4:0] rs_addr, rt_addr;          // `rd` not used


    always @( instruction ) begin

        // initialize
        result = { 32{1'b0} };
        flags = { 3{1'b0} };

        // parsing the instruction
        op = instruction [31:26];
        rs_addr = instruction [25:21];
        rt_addr = instruction [20:16];
        // rd_addr = ...; shamt = ...;
        funct = instruction [5:0];        // although for I-type instruction there is no `funct`


        // fetch value from register array
        // set rs_reg
        if (rs_addr == 5'b00000) rs_reg = regA;
        else if (rs_addr == 5'b00001) rs_reg = regB;
        else begin
            $display("Invalid rs_addr: %b", rs_addr); 
            $finish;
        end

        // set rt_reg
        if (rt_addr == 5'b00000) rt_reg = regA;
        else if (rt_addr == 5'b00001) rt_reg = regB;
        else begin
            $display("Invalid rt_addr: %b", rt_addr); 
            $finish;
        end


        // identify and execute the instruction
        // 1.1 add
        if (op==6'b000000 && funct==6'b100000) begin
            //$display("1.1 add");
        end
        // 1.2 addi
        else if (op==6'b001000) begin
            
        end
        // 1.3 addu
        else if (op==6'b000000 && funct==6'b100001) begin
            
        end
        // 1.4 addiu
        else if (op==6'b001001) begin
            
        end
        // 2.1 sub
        else if (op==6'b000000 && funct==6'b100010) begin
            
        end
        // 2.2 subu
        else if (op==6'b000000 && funct==6'b100011) begin
            
        end
        // 4.1 and
        else if (op==6'b000000 && funct==6'b100100) begin
            
        end
        // 4.2 andi
        else if (op==6'b001100) begin
            
        end
        // 4.3 nor
        else if (op==6'b000000 && funct==6'b100111) begin
            
        end
        // 4.5 or
        else if (op==6'b000000 && funct==6'b100101) begin
            
        end
        // 4.6 ori
        else if (op==6'b001101) begin
            
        end
        // 4.7 xor
        else if (op==6'b000000 && funct==6'b100110) begin
            
        end
        // 4.8 xori
        else if (op==6'b001110) begin
            
        end
        // 5.1 beq
        else if (op==6'b000100) begin
            
        end
        // 5.2 bne
        else if (op==6'b000101) begin
            
        end
        // 5.3 slt
        else if (op==6'b000000 && funct==6'b101010) begin
            
        end
        // 5.4 slti
        else if (op==6'b001010) begin
            
        end
        // 5.5 sltiu
        else if (op==6'b001011) begin
            
        end
        // 5.6 sltu
        else if (op==6'b000000 && funct==6'b101011) begin
            
        end
        // 6.1 lw
        else if (op==6'b100011) begin
            
        end
        // 6.2 sw
        else if (op==6'b101011) begin
            
        end
        // 7.1 sll
        else if (op==6'b000000 && funct==6'b000000) begin
            
        end
        // 7.2 sllv
        else if (op==6'b000000 && funct==6'b000100) begin
            
        end
        // 7.3 srl
        else if (op==6'b000000 && funct==6'b000010) begin
            
        end
        // 7.4 srlv
        else if (op==6'b000000 && funct==6'b000110) begin
            
        end
        // 7.5 sra
        else if (op==6'b000000 && funct==6'b000011) begin
            
        end
        // 7.6 srav
        else if (op==6'b000000 && funct==6'b000111) begin
            
        end
        // Unrecognized instruction
        else begin
            $display("Unrecognized instruction: %b", instruction); 
            $finish;
        end
    end

endmodule
