module FA(ai, bi, c_in, s, c_out);
    input ai, bi, c_in;
    output s, c_out;
    assign s = ai^bi^c_in;
    assign c_out = (ai&bi)|(ai&c_in)|(c_in&bi);

endmodule

module part2(a, b, c_in, s, c_out);
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

module part3(A,B, Function, ALUout);
    input [2:0] Function;
    input [3:0] A;
    input [3:0] B;
    output reg [7:0] ALUout;

    //adding a and b using part 2(0)
    wire [4:0] AplusB;
    wire [3:0] s;
    wire [3:0] c;
    part2 p2(A, B, 0, s, c);
    assign AplusB = {c[3],s};

    //using + operator from verilog(1)
    wire [4:0] ver_plus;
    assign ver_plus = A+B;
    wire [3:0] ext_ver_plus;
    assign ext_ver_plus[0] = ver_plus[3];
    assign ext_ver_plus[1] = ver_plus[3];
    assign ext_ver_plus[2] = ver_plus[3];
    assign ext_ver_plus[3] = ver_plus[3];
    wire [8:0]ver_plus_extended;
    assign ver_plus_extended = {ext_ver_plus, ver_plus};

    always @(*)
    begin
       case(Function)
        3'b000:assign ALUout = AplusB;
        3'b001:assign ALUout = ver_plus_extended;
        3'b010:assign ALUout ={B[3],B[3],B[3],B[3],B};
        3'b011:assign ALUout = {7'b0000000,|{A,B}};
        3'b100:assign ALUout = {7'b0000000,&{A,B}};
        3'b101:assign ALUout = {A,B};
        default:assign ALUout = 0;
       endcase
    end
            

endmodule   
