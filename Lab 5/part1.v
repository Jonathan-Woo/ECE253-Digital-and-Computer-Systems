module tff(Clock, T, Reset, Q);
    input Clock, T, Reset;
    output reg Q;
    always @(posedge Clock, negedge Reset)
        begin 
            if (Reset == 1'b0)
                Q <= 1'b0;
            else if(T == 1'b1)
                Q <= !Q;
        end

endmodule


module part1(Clock, Enable, Clear_b, CounterValue);
    input Clock, Enable, Clear_b;
    wire W1, W1e, W2, W2e, W3, W3e, W4, W4e, W5, W5e, W6, W6e, W7, W7e, W8;
    output [7:0]CounterValue;
    assign W1e = Enable & W1;
    assign W2e = W1e & W2;
    assign W3e = W2e & W3; 
    assign W4e = W3e & W4;
    assign W5e = W4e & W5;
    assign W6e = W5e & W6;
    assign W7e = W6e & W7;

    tff t1(.Clock(Clock), .T(Enable), .Reset(Clear_b), .Q(W1));
    tff t2(.Clock(Clock), .T(W1e), .Reset(Clear_b), .Q(W2));
    tff t3(.Clock(Clock), .T(W2e), .Reset(Clear_b), .Q(W3));
    tff t4(.Clock(Clock), .T(W3e), .Reset(Clear_b), .Q(W4));
    tff t5(.Clock(Clock), .T(W4e), .Reset(Clear_b), .Q(W5));
    tff t6(.Clock(Clock), .T(W5e), .Reset(Clear_b), .Q(W6));
    tff t7(.Clock(Clock), .T(W6e), .Reset(Clear_b), .Q(W7));
    tff t8(.Clock(Clock), .T(W7e), .Reset(Clear_b), .Q(W8));

    assign CounterValue = {W8, W7, W6, W5, W4, W3, W2, W1};

endmodule