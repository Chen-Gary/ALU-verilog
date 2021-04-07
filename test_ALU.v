`timescale 1ns/1ps

module alu_test;

    reg [31:0] instruction;
    reg [31:0] regA, regB;

    wire [31:0] result;
    wire [2:0] flags;

    alu testalu ( instruction, regA, regB, result, flags );

    initial begin
        $display("instruction :   op   :  funct :  result(d) : result(h) : zero flag : negative flag : overflow flag :   regA (d) :   regB (d) : regA (h) : regB (h)");
		//$monitor("   %h : %b : %b : %d :  %h :         %b :             %b :             %b : %d : %d : %h : %h", instruction, testalu.op, testalu.funct, (result), result, flags[0], flags[1], flags[2], (testalu.regA), (testalu.regB), testalu.regA, testalu.regB);

        #10;
        // test begin
        // add 4 + 5
        instruction <= 32'b00000000000000010100000000100000;
        regA <= 32'd4;
        regB <= 32'd5;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add 4 + 5", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // add -4 + (-4)
        instruction <= 32'b00000000000000000100000000100000;
        regA <= -32'd4;
        regB <= 32'd6;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add -4 + (-4)", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // add -10 + 10
        instruction <= 32'b00000000000000010100000000100000;
        regA <= -32'd10;
        regB <= 32'd10;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add -10 + 10", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // add 2147483640 + 2147483641 overflow
        instruction <= 32'b00000000000000010100000000100000;
        regA <= 32'd2147483640;
        regB <= 32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add 2147483640 + 2147483641 overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // add -2147483640 + (-2147483641) overflow
        instruction <= 32'b00000000000000010100000000100000;
        regA <= -32'd2147483640;
        regB <= -32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ add -2147483640 + (-2147483641) overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // addi 19 + (-100)
        instruction <= 32'b001000_00001_00000_1111111110011100;
        regA <= 32'd0;
        regB <= 32'd19;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addi 19 + (-100)", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // addi -2147483640 + (-100) overflow
        instruction <= 32'b001000_00001_00000_1111111110011100;
        regA <= 32'd0;
        regB <= -32'd2147483640;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addi -2147483640 + (-100) overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // addi 2147483640 + 100 overflow
        instruction <= 32'b001000_00000_00000_0000000001100100;
        regA <= 32'd2147483640;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addi 2147483640 + 100 overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // addu 2147483640 + 2147483641 = 4294967281
        instruction <= 32'b00000000000000010100000000100001;
        regA <= 32'd2147483640;
        regB <= 32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addu 2147483640 + 2147483641 = 4294967281", instruction, testalu.op, testalu.funct, (result), result, flags[0], flags[1], flags[2], (testalu.regA), (testalu.regB), testalu.regA, testalu.regB);

        // addiu 200 + 100
        instruction <= 32'b001001_00000_00000_0000000001100100;
        regA <= 32'd200;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ addiu 200 + 100", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // sub 99 - 25 = 74
        instruction <= 32'b000000_00000_00001_0000000001_100010;
        regA <= 32'd99;
        regB <= 32'd25;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sub 99 - 25 = 74", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sub -39 - (-65) = 26
        instruction <= 32'b000000_00001_00000_0000000001_100010;
        regA <= -32'd65;
        regB <= -32'd39;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sub -39 - (-65) = 26", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sub -2147483640 - 2147483641 overflow
        instruction <= 32'b000000_00000_00001_0000000001_100010;
        regA <= -32'd2147483640;
        regB <=  32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sub -2147483640 - 2147483641 overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sub 2147483640 - (-2147483641) overflow
        instruction <= 32'b000000_00000_00001_0000000001_100010;
        regA <=  32'd2147483640;
        regB <= -32'd2147483641;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sub 2147483640 - (-2147483641) overflow", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // subu 50 - 120 = -70
        instruction <= 32'b000000_00000_00001_0000000001_100011;
        regA <= 32'd50;
        regB <= 32'd120;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ subu 50 - 120 = -70", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // and fff0ffff & abcd1234
        instruction <= 32'b000000_00000_00001_0000000001_100100;
        regA <= 32'hfff0ffff;
        regB <= 32'habcd1234;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ and fff0ffff & abcd1234", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // andi fffffff0 & 000000ab
        instruction <= 32'b001100_00001_00001_0000000010101011;
        regA <= 32'habcd1234;
        regB <= 32'hfffffff0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ andi fffffff0 & 000000ab", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // nor ~(fff0ffff | abcd1234) = 00020000
        instruction <= 32'b000000_00000_00001_0000000001_100111;
        regA <= 32'hfff0ffff;
        regB <= 32'habcd1234;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ nor ~(fff0ffff | abcd1234) = 00020000", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // or fff0ffff | abcd1234 = fffdffff
        instruction <= 32'b000000_00000_00001_0000000001_100101;
        regA <= 32'hfff0ffff;
        regB <= 32'habcd1234;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ or fff0ffff | abcd1234 = fffdffff", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // ori fffffff0 | 000000ab = fffffffb
        instruction <= 32'b001101_00001_00001_0000000010101011;
        regA <= 32'habcd1234;
        regB <= 32'hfffffff0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ ori fffffff0 | 000000ab = fffffffb", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // xor ffffffff ^ ffffffff = 00000000
        instruction <= 32'b000000_00000_00001_0000000001_100110;
        regA <= 32'hffffffff;
        regB <= 32'hffffffff;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ xor ffffffff ^ ffffffff = 00000000", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // xori ffffffff ^ 0000ffff = ffff0000
        instruction <= 32'b001110_00001_00001_1111111111111111;
        regA <= 32'habcd1234;
        regB <= 32'hffffffff;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ xori ffffffff ^ 0000ffff = ffff0000", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // beq (equal)
        instruction <= 32'b000100_00000_00001_0000000000_000000;
        regA <= 32'd520;
        regB <= 32'd520;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ beq (equal)", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // beq (not equal)
        instruction <= 32'b000100_00000_00001_0000000000_000000;
        regA <= 32'd520;
        regB <= 32'd521;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ beq (not equal)", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // bne (equal)
        instruction <= 32'b000101_00001_00001_0000000000_000000;
        regA <= 32'd1314;
        regB <= 32'd1314;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ bne (equal)", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // bne (not equal)
        instruction <= 32'b000101_00001_00000_0000000000_000000;
        regA <= 32'd1314;
        regB <= 32'd1314520;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ bne (not equal)", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // slt 520 < 1314? y
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= 32'd520;
        regB <= 32'd1314;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt 520 < 1314? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt 1314 < 520? n
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= 32'd1314;
        regB <= 32'd520;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt 1314 < 520? n", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt -1314 < 520? y
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= -32'd1314;
        regB <= 32'd520;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt -1314 < 520? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt 520 < -1314? n
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= 32'd520;
        regB <= -32'd1314;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt 520 < -1314? n", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt -520 < 1314? y
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= -32'd520;
        regB <= 32'd1314;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt -520 < 1314? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt 1314 < -520? n
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= 32'd1314;
        regB <= -32'd520;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt 1314 < -520? n", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt -1314 < -520? y
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= -32'd1314;
        regB <= -32'd520;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt -1314 < -520? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt -520 < -1314? n
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= -32'd520;
        regB <= -32'd1314;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt -520 < -1314? n", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt -520 < -520 n
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= -32'd520;
        regB <= -32'd520;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt -520 < -520 n", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt ffffffff(h) < 00000000(h)? (-1 < 0?) y
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= 32'hffffffff;
        regB <= 32'h00000000;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt ffffffff(h) < 00000000(h)? (-1 < 0?) y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slt ffffffff(h) < 80000000(h)? (-1 < -2147483648?) n
        instruction <= 32'b000000_00000_00001_0000000000_101010;
        regA <= 32'hffffffff;
        regB <= 32'h80000000;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slt ffffffff(h) < 80000000(h)? (-1 < -2147483648?) n", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slti 5 < 8? y
        instruction <= 32'b001010_00000_11111_0000000000001000;
        regA <= 32'd5;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slti 5 < 8? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slti -5 < (-1)? y
        instruction <= 32'b001010_00000_11111_1111111111111111;
        regA <= -32'd5;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slti -5 < (-1)? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // slti 5 < (-1)? n
        instruction <= 32'b001010_00000_11111_1111111111111111;
        regA <= 32'd5;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ slti 5 < (-1)? n", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sltiu 5 < 8? y
        instruction <= 32'b001011_00000_11111_0000000000001000;
        regA <= 32'd5;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sltiu 5 < 8? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sltiu 19 < 8? n
        instruction <= 32'b001011_00000_11111_0000000000001000;
        regA <= 32'd19;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sltiu 19 < 8? n", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sltiu 5 < (111...11)_2? y
        instruction <= 32'b001011_00000_11111_1111111111111111;
        regA <= 32'd5;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sltiu 5 < (111...11)_2? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sltu 00000001(h) < ffffffff(h)? y
        instruction <= 32'b000000_00000_00001_0000000000_101011;
        regA <= 32'h00000001;
        regB <= 32'hffffffff;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sltu 00000001(h) < ffffffff(h)? y", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // lw
        instruction <= 32'b100011_00000_00001_0000000000000001;
        regA <= 32'd2;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ lw", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sw
        instruction <= 32'b101011_00001_00000_0000000000000001;
        regA <= 32'd0;
        regB <= 32'd4;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sw", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        $display("");
        // sll abcd1234(h) << 8
        instruction <= 32'b000000_11111_00000_11111_01000_000000;
        regA <= 32'habcd1234;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sll abcd1234(h) << 8", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sll abcd1234(h) << 16
        instruction <= 32'b000000_11111_00000_11111_10000_000000;
        regA <= 32'habcd1234;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sll abcd1234(h) << 16", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sllv abcd1234(h) << 8
        instruction <= 32'b000000_00001_00000_11111_00000_000100;
        regA <= 32'habcd1234;
        regB <= 32'd8;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sllv abcd1234(h) << 8", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sllv abcd1234(h) << 24
        instruction <= 32'b000000_00001_00000_11111_00000_000100;
        regA <= 32'habcd1234;
        regB <= 32'd24;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sllv abcd1234(h) << 24", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // srl 1bcd1234(h) >> 4
        instruction <= 32'b000000_11111_00000_11111_00100_000010;
        regA <= 32'h1bcd1234;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ srl 1bcd1234(h) >> 4", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // srl abcd1234(h) >> 8
        instruction <= 32'b000000_11111_00000_11111_01000_000010;
        regA <= 32'habcd1234;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ srl abcd1234(h) >> 8", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // srlv fbcd1234(h) >> 24
        instruction <= 32'b000000_00001_00000_11111_00000_000110;
        regA <= 32'hfbcd1234;
        regB <= 32'd24;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ srlv fbcd1234(h) >> 24", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sra 1bcd1234(h) >> 8
        instruction <= 32'b000000_11111_00000_11111_01000_000011;
        regA <= 32'h1bcd1234;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sra 1bcd1234(h) >> 8", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // sra abcd1234(h) >> 8
        instruction <= 32'b000000_11111_00000_11111_01000_000011;
        regA <= 32'habcd1234;
        regB <= 32'd0;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ sra abcd1234(h) >> 8", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // srav 2bcd1234(h) >> 16
        instruction <= 32'b000000_00001_00000_11111_00000_000111;
        regA <= 32'h2bcd1234;
        regB <= 32'd16;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ srav 2bcd1234(h) >> 16", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // srav 8bcd1234(h) >> 16
        instruction <= 32'b000000_00001_00000_11111_00000_000111;
        regA <= 32'h8bcd1234;
        regB <= 32'd16;
        #10;
        $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ srav 8bcd1234(h) >> 16", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);



        /* 
         * You may add more tests here...
         * The added tests should follow the following format...
         * You may refer to the above tests for examples...
        */

        // instruction <= ... ;
        // regA <= ... ;
        // regB <= ... ;
        // #10;
        // $display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h ------ <test description...>", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);

        // Recompile and run the code, you will see the test result in the last row of the table.



        $display("");
        $display("Testing finished.");
        $display("");
        //$display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);
        #10;
        $finish;

    end

endmodule
