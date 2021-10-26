//active high parallel load
//synchronous active high reset
//increment on enable
//rate of change set by Speed

//Speed[1]  Speed[0]
//  0           0       Once every clock period
//  0           1       Once a second
//  1           0       Once every two seconds
//  1           1       Once every four seconds

module part2(ClockIn, Reset, Speed, CounterValue);
    input ClockIn;
    input Reset;
    input [1:0]Speed;
    output [3:0]CounterValue;

    wire enable;
    wire [10:0]counter;

    counter c0(.clock(ClockIn), .enable(enable), .clear_b(Reset), .q(CounterValue));
    rateCounter c1(.clock(ClockIn), .speed(Speed), .counter(counter));

    //updates to new count after finishing current count
    assign enable = (counter == 11'b00000000000)?1:0;
endmodule

module rateCounter(clock, speed, counter);
    input clock;
    input [1:0]speed;
    output reg [10:0]counter;

    initial begin
        counter = 11'b00000000000;
    end

    always @(posedge clock)
    begin
        if(counter == 11'b00000000000 & speed == 2'b00)
            counter <= 11'b00000000000;
        else if(counter == 11'b00000000000 & speed == 2'b01)
            counter <= 11'b00111110100 - 1;
        else if(counter == 11'b00000000000 & speed == 2'b10)
            counter <= 11'b01111101000 - 1;
        else if(counter == 11'b00000000000 & speed == 2'b11)
            counter <= 11'b11111010000 - 1;
        else
            counter <= counter - 1;
    end
endmodule

module counter(clock, enable, clear_b, q);
    //4-bit counter
    output reg [3:0]q;
    input clock;
    input enable;
    input clear_b;

    always @(posedge clock)
    begin
        if(clear_b == 1'b1)
            q <= 4'b0000;
        else if(q == 4'b1111 & enable == 1'b1)
            q <= 4'b0000;
        else if(enable == 1'b1)
            q <= q + 1;
    end
endmodule