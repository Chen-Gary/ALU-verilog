`timescale 1ns/1ps

module alu_test;

    reg [31:0] instruction;
    reg [31:0] regA, regB;

    wire [31:0] result;
    wire [2:0] flags;

    alu testalu ( instruction, regA, regB, result, flags );

    initial begin
        $display("instruction :   op   :  funct :  result(d) : result(h) : zero flag : negative flag : overflow flag :   regA (d) :   regB (d) : regA (h) : regB (h)");
		//$monitor("   %h : %b : %b : %d :  %h :         %b :             %b :             %b : %d : %d : %h : %h", instruction, testalu.op, testalu.funct, (result), result, flags[2], flags[1], flags[0], (testalu.regA), (testalu.regB), testalu.regA, testalu.regB);

        #10;
        // test begin
        // add 4 + 5
        instruction <= 32'b00000000000000010100000000100000;
        regA <= 32'd4;
        regB <= 32'd5;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add 4 + 5", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // add -4 + (-4)
        instruction <= 32'b00000000000000000100000000100000;
        regA <= -32'd4;
        regB <= 32'd6;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add -4 + (-4)", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // add -10 + 10
        instruction <= 32'b00000000000000010100000000100000;
        regA <= -32'd10;
        regB <= 32'd10;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add -10 + 10", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // add 2147483640 + 2147483641 overflow
        instruction <= 32'b00000000000000010100000000100000;
        regA <= 32'd2147483640;
        regB <= 32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add 2147483640 + 2147483641 overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // add -2147483640 + (-2147483641) overflow
        instruction <= 32'b00000000000000010100000000100000;
        regA <= -32'd2147483640;
        regB <= -32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add -2147483640 + (-2147483641) overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // addi 19 + (-100)
        instruction <= 32'b001000_00001_00000_1111111110011100;
        regB <= 32'd19;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addi 19 + (-100)", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // addi -2147483640 + (-100) overflow
        instruction <= 32'b001000_00001_00000_1111111110011100;
        regB <= -32'd2147483640;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addi -2147483640 + (-100) overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // addi 2147483640 + 100 overflow
        instruction <= 32'b001000_00000_00000_0000000001100100;
        regA <= 32'd2147483640;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addi 2147483640 + 100 overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // addu 2147483640 + 2147483641 = 4294967281
        instruction <= 32'b00000000000000010100000000100001;
        regA <= 32'd2147483640;
        regB <= 32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addu 2147483640 + 2147483641 = 4294967281", instruction, testalu.op, testalu.funct, (result), result, flags[2], flags[1], flags[0], (testalu.regA), (testalu.regB), testalu.regA, testalu.regB);

        // addiu 200 + 100
        instruction <= 32'b001001_00000_00000_0000000001100100;
        regA <= 32'd200;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addiu 200 + 100", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // sub 99 - 25 = 74
        instruction <= 32'b000000_00000_00001_0000000001_100010;
        regA <= 32'd99;
        regB <= 32'd25;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sub 99 - 25 = 74", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sub -39 - (-65) = 26
        instruction <= 32'b000000_00001_00000_0000000001_100010;
        regA <= -32'd65;
        regB <= -32'd39;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sub -39 - (-65) = 26", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sub -2147483640 - 2147483641 overflow
        instruction <= 32'b000000_00000_00001_0000000001_100010;
        regA <= -32'd2147483640;
        regB <=  32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sub -2147483640 - 2147483641 overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sub 2147483640 - (-2147483641) overflow
        instruction <= 32'b000000_00000_00001_0000000001_100010;
        regA <=  32'd2147483640;
        regB <= -32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sub 2147483640 - (-2147483641) overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // subu 50 - 120 = -70
        instruction <= 32'b000000_00000_00001_0000000001_100011;
        regA <= 32'd50;
        regB <= 32'd120;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ subu 50 - 120 = -70", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        //$display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h", instruction, testalu.op, testalu.funct, $signed(result), result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);
        #10;
        $finish;

    end

endmodule
