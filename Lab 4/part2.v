module FA(ai, bi, c_in, s, c_out);
    input ai, bi, c_in;
    output s, c_out;
    assign s = ai^bi^c_in;
    assign c_out = (ai&bi)|(ai&c_in)|(c_in&bi);

endmodule

module Adder(a, b, c_in, s, c_out);
    input [3:0] a;
    input [3:0] b;
    input c_in;
    output [3:0] s;
    output [3:0] c_out;
    wire c0, c1, c2, c3;

    FA f0(a[0], b[0], c_in, s[0], c0);
    FA f1(a[1], b[1], c0, s[1], c1);
    FA f2(a[2], b[2], c1, s[2], c2);
    FA f3(a[3], b[3], c2, s[3], c3);
    assign c_out[0] = c0;
    assign c_out[1] = c1;
    assign c_out[2] = c2;
    assign c_out[3] = c3;
endmodule

module flipflop(Clock, D, Reset_b, Q, B);
    input Clock, Reset_b;
    input [7:0]D;
    output reg [7:0]Q;
    output [3:0]B;

    always @(posedge Clock)
    begin 
        if(Reset_b == 1'b0) 
            Q <= 8'b00000000; 
        else 
            Q <= D; 
    end

    assign B = Q[3:0];
endmodule

module ALU(A, B, sol, Function, Data);
    input [3:0]A;
    input [3:0]B;
    input [2:0]Function;
    input [3:0]Data;
    output reg [7:0]sol;

    wire [3:0]c_out;
    wire [3:0]s_out;
    Adder a0(Data, B, 1'b0, s_out, c_out);

    always @(*)
        begin
            case(Function[2:0])
                3'b000: sol = {3'b000, c_out[3], s_out};
                3'b001: sol = A+B;
                3'b010: sol = {B[3],B[3],B[3],B[3],B};
                3'b011: sol = {7'b0000000,|{A,B}};
                3'b100: sol = {7'b0000000,&{A,B}};
                3'b101: sol = B<<A;
                3'b110: sol = A*B;
                3'b111: sol = sol;
                default: sol = 8'b00000000;
            endcase
        end
endmodule

module part2(Clock, Reset_b, Data, Function, ALUout);
    input Clock, Reset_b;
    input [3:0]Data;
    input [2:0] Function;
    output [7:0]ALUout;

    //Initiate wires
    wire [3:0]B;
    wire [3:0]A;
    assign A = Data;
    assign B = ALUout[3:0];
    wire [7:0]sol;

    //Instantiate modules 
    ALU alu0(.A(A), .B(B), .sol(sol), .Function(Function), .Data(Data));
    flipflop f0(.Clock(Clock), .D(sol), .Reset_b(Reset_b), .Q(ALUout), .B(B));
endmodule