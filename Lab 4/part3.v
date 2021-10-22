module flipflop(Clock, D, Reset_b, Q);
    input Clock, D, Reset_b;
    output reg Q;
    always @(posedge Clock)
    begin 
        if (Reset_b == 1'b1 )   
            Q <= 0; 
        else 
            Q <= D; 
    end
endmodule

module mux2to1(x,y,s,m);
    input x,y,s;
    output m;
    wire w0, w1, w2;

    assign w0 = ~s;
    assign w1 = w0 & x;
    assign w2 = s & y;
    assign m = w2 | w1;
endmodule

//Rotator module with 2 muxs and a D flip flop
module rotator(left, right, RotateRight, D, ParallelLoadn, clock, reset, Q);
    wire w1, w2;
    input left, right, RotateRight, D, ParallelLoadn, clock, reset;
    output Q;
    mux2to1 m1(.x(right), .y(left), .s(RotateRight), .m(w1));
    mux2to1 m2(.x(D), .y(w1), .s(ParallelLoadn), .m(w2));
    flipflop f1(.Clock(clock), .D(w2), .Reset_b(reset), .Q(Q));
endmodule

module part3 (clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
    //ParallelLoadn: Chooses load value or shift value
    //RotateRight: Chooses left or right outputs for shifting right or left respectively
    input clock, reset, ParallelLoadn, RotateRight, ASRight;
    input [7:0]Data_IN;
    output [7:0]Q;

    wire left_input;
    assign left_input =(ASRight & RotateRight & ParallelLoadn) ? Q[7]: Q[0];

    rotator r0(.left(Q[1]), .right(Q[7]), .ParallelLoadn(ParallelLoadn), .RotateRight(RotateRight), .clock(clock), .Q(Q[0]), .reset(reset), .D(Data_IN[0]));
    rotator r1(.left(Q[2]), .right(Q[0]), .ParallelLoadn(ParallelLoadn), .RotateRight(RotateRight), .clock(clock), .Q(Q[1]), .reset(reset), .D(Data_IN[1]));
    rotator r2(.left(Q[3]), .right(Q[1]), .ParallelLoadn(ParallelLoadn), .RotateRight(RotateRight), .clock(clock), .Q(Q[2]), .reset(reset), .D(Data_IN[2]));
    rotator r3(.left(Q[4]), .right(Q[2]), .ParallelLoadn(ParallelLoadn), .RotateRight(RotateRight), .clock(clock), .Q(Q[3]), .reset(reset), .D(Data_IN[3]));
    rotator r4(.left(Q[5]), .right(Q[3]), .ParallelLoadn(ParallelLoadn), .RotateRight(RotateRight), .clock(clock), .Q(Q[4]), .reset(reset), .D(Data_IN[4]));
    rotator r5(.left(Q[6]), .right(Q[4]), .ParallelLoadn(ParallelLoadn), .RotateRight(RotateRight), .clock(clock), .Q(Q[5]), .reset(reset), .D(Data_IN[5]));
    rotator r6(.left(Q[7]), .right(Q[5]), .ParallelLoadn(ParallelLoadn), .RotateRight(RotateRight), .clock(clock), .Q(Q[6]), .reset(reset), .D(Data_IN[6]));
    rotator r7(.left(left_input), .right(Q[6]), .ParallelLoadn(ParallelLoadn), .RotateRight(RotateRight), .clock(clock), .Q(Q[7]), .reset(reset), .D(Data_IN[7]));

  
endmodule