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

