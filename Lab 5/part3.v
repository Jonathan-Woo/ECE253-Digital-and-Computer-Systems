/*
Morse code encoder including:
1. LUT to store codes
2. Shift register
3. Rate divider

All synchronized by the same clock
*/

module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
    input ClockIn, Resetn, Start;   //Active low asynchronous reset
    input [2:0]Letter;
    output reg DotDashOut;

    wire [11:0]newSeq;
    wire [11:0]seq;
    wire [7:0]counter;

    //instantiate modules
    LUT m0(.clock(ClockIn), .in(Letter), .out(newSeq));
    shiftRegister m1(.clock(ClockIn), .curSeq(seq), .newSeq(newSeq), .start(Start), .resetn(Resetn), .counter(counter), .sequence(seq));
    rateDivider m2(.clock(ClockIn), .counter(counter));

    always @(posedge ClockIn)
    begin
        if(counter == 8'b00000000)    //update output when counter reaches 0
            DotDashOut <= seq[0];   //since we are using a register, update to the least significant bit
    end
endmodule

module shiftRegister(clock, newSeq, curSeq, start, resetn, counter, sequence);
    /*
    Shift register to store current sequence
    Loaded for start active high. Retain previous pattern until start = 1
    Shifted after 0.5 sec
    */
    input clock, start, resetn;
    input [7:0]counter;
    input [11:0]newSeq;
    input [11:0]curSeq;

    wire [11:0]advSeq = {curSeq[0], curSeq[11:1]};
    output reg [11:0]sequence;

    always @(posedge start, posedge clock, negedge resetn)
    begin
        if(start)   //update register
            sequence <= newSeq;
        else if(!resetn)
            sequence <= 11'b00000000000;
        else if(counter == 8'b00000000)   //advance register
            sequence <= advSeq;
    end
endmodule

module LUT(clock, in, out);
    /*
    sends the required bitstream/binary representation of letters
    out corresponds to the associated in which represents a letter from A - H
    */
    input clock;
    input [2:0]in;
    output reg [11:0]out;

    always @(posedge clock)
    begin
        case(in[2:0])
            3'b000: out <= 12'b000000011101;
            3'b001: out <= 12'b000101010111;
            3'b010: out <= 12'b010111010111;
            3'b011: out <= 12'b000001010111;
            3'b100: out <= 12'b000000000001;
            3'b101: out <= 12'b000101110101;
            3'b110: out <= 12'b000101110111;
            3'b111: out <= 12'b000001010101;
            default: out <= 12'b000000000000;
        endcase
    end
endmodule

module rateDivider(clock, counter);
    /*
    Rate divider for 500 hz clock
    0.5 second pulses for dots -> 250 clock cycles
    1.5 second pulses for dashes -> 750 clock cycles
    therefore use 3 0.5 sec pulses for dashes

    Don't have to be concerned with input value though because it is managed
    by upper level module. Just need to count 0.5 seconds constantly
    */
    input clock;
    output reg [7:0]counter;

    initial begin
        counter = 12'b000000000000;
    end

    always @(posedge clock)
    begin
        if(counter == 8'b00000000)
            counter <= 8'b11111010 - 1;
        else
            counter <= counter - 1;
    end
endmodule