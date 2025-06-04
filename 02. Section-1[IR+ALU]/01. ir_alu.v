`timescale 1ns / 1ps

// Field of IR
`define oper_type IR[31:27]
`define rdst IR[26:22]
`define rsrc1 IR[21:17]
`define mode IR[16]
`define rsrc2 IR[15:11]
`define isrc IR[10:0]

// Arithmetic Operation
`define movsgpr 5'd0
`define mov 5'd1
`define add 5'd2
`define sub 5'd3
`define mul 5'd4

module ir_alu();
reg [31:0] IR;  // creating instruction register 
reg [16:0] GPR [31:0]; // creating a general purpose register
reg [15:0] SGPR; // creating a special purpose general purpose register
reg [31:0] mul_res;

always@(*)
begin
case (`oper_type)
    `movsgpr: begin
        GPR[`rdst] = SGPR;
    end

    `mov: begin
        if(`mode)
            GPR[`rdst] = `isrc;
        else
            GPR[`rdst] = GPR[`rsrc1];
    end

    `add: begin
        if(`mode)
            GPR[`rdst] = `isrc + GPR[`rsrc1];
        else 
            GPR[`rdst] = GPR[`rsrc1] + GPR[`rsrc2];
    end

    `sub: begin
        if(`mode) 
            GPR[`rdst] = GPR[`rsrc1] - `isrc;
        else 
            GPR[`rdst] = GPR[`rsrc1] - GPR[`rsrc2];
    end

    `mul: begin
        if(`mode) 
            mul_res = GPR[`rsrc1] * `isrc;
        else begin
            mul_res = GPR[`rsrc1] * GPR[`rsrc2];
            end

        GPR[`rdst] = mul_res[15:0];
        SGPR = mul_res[31:0];
     end

    endcase
end

endmodule
