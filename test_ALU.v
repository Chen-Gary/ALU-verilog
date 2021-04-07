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


        //$display("   %h : %b : %b :%d :  %h :         %b :             %b :             %b :%d :%d : %h : %h", instruction, testalu.op, testalu.funct, $signed(result), result, flags[0], flags[1], flags[2], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);
        #10;
        $finish;

    end

endmodule
