`timescale 1ns/1ps

module alu_test;

    reg [31:0] instruction;
    reg [31:0] regA, regB;

    wire [31:0] result;
    wire [2:0] flags;

    alu testalu ( instruction, regA, regB, result, flags );

    initial begin
        $display("instruction :   op   :  funct :   result   : zero flag : negative flag : overflow flag :   regA (d) :   regB (d) : regA (h) : regB (h)");
		$monitor("   %h : %b : %b : %d :         %b :             %b :             %b : %d : %d : %h : %h", instruction, testalu.op, testalu.funct, result, flags[2], flags[1], flags[0], (testalu.regA), (testalu.regB), testalu.regA, testalu.regB);

        #10;
        instruction <= 32'b00000000000000010100000000100000;
        regA <= -32'd10;
        regB <= 32'd10;

        #10;
        //$display("   %h : %b : %b : %d :         %b :             %b :             %b :%d :%d : %h : %h", instruction, testalu.op, testalu.funct, result, flags[2], flags[1], flags[0], $signed(testalu.regA), $signed(testalu.regB), testalu.regA, testalu.regB);
        $finish;

    end

endmodule
