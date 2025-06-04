`timescale 1ns / 1ps

module ir_alu_tb();

ir_alu dut();

integer i=0;

// giving all the gpr values to 2
initial begin
    for(i=0;i<32;i=i+1) begin
        dut.GPR[i] = 2;
    end
end

// operation type = immediate(1) + add
initial begin
    $display("---------------------------------");
    dut.IR = 0;
    dut.`oper_type = 2;
    dut.`rdst = 0;
    dut.`mode = 1;
    dut.`rsrc1 = 2;
    dut.`isrc = 4;
    #10;
    $display("operation is ADD -> Rsrc1=%0d, Rsrc2=%0d, Rdst=%0d",dut.GPR[2],dut.`isrc,dut.GPR[0]);
end

// operation type = immediate(0) + mov
initial begin
    $display("----------------------------------------");
    dut.IR = 0;
    dut.`oper_type = 1;
    dut.`rdst = 4;
    dut.`mode = 0;
    dut.`rsrc1 = 7;
    #10;
    $display("operation is MOV -> Rdst=%0d, Rsrc1=%0d",dut.GPR[4],dut.GPR[7]);
end

// operation type = immediate(1) + mov
initial begin
    $display("----------------------------------------");
    dut.IR = 0;
    dut.`oper_type = 1;
    dut.`rdst = 4;
    dut.`mode = 1;
    dut.`isrc = 55;
    #10;
    $display("operation is MOV -> Rdst=%0d, immediate_source=%0d",dut.GPR[4],dut.`isrc);
end

endmodule
