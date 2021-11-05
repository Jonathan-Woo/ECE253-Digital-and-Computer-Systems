/*
Cycles:
1. Load divident and divisor                ->if go = 1, go to 2
                                            ->else stay in 1
2. Wait for Go low signal                   ->if go = 0, go to 3
                                            ->else stay in 2
3. Shift dividend                           ->go to 4
4. regA = regA - divisor                    ->if MSB regA = 1, go to 5a
                                            ->else, go to 5b
5a. regA + divisor, LSB dividend = 0        ->if count = number of bits, go to 6
                                            ->else, return to cycle 3
5b. LSB dividend = 1                        ->if count = number of bits, go to 6
                                            ->else, return to cycle 3

6. Finish                                   ->if go = 1, go to 1
                                            ->else stay and do nothing

7 cycles so 3 bits to identify states
*/

module part3(Clock, Resetn, Go, Divisor, Dividend, Quotient, Remainder);
    input Clock, Resetn, Go;
    input [3:0]Dividend;
    input [3:0]Divisor;
    output [3:0]Quotient;
    output [3:0]Remainder;

    wire count = 3'd0;
    wire negTrue;

    wire ld, shift, sub, restore, no_restore;

    control c0(
        .clk(Clock), 
        .resetn(Resetn), 
        .go(Go), 
        .negTrue(negTrue), 
        .count(count), 

        .ld(ld), 
        .shift(shift), 
        .sub(sub), 
        .restore(restore), 
        .no_restore(no_restore)
        );
    
    data d0(
        .clk(Clock),
        .resetn(Resetn),
        .dividend(Dividend),
        .divisor(Divisor),
        .ld(ld),
        .shift(shift),
        .sub(sub),
        .restore(restore),
        .no_restore(no_restore),

        .reg_q(Quotient),
        .reg_a(Remainder),
        .negTrue(negTrue),
        .counter(count)
        );

endmodule

module control(
    input clk, 
    input resetn, 
    input go, 
    input negTrue,
    input count,

    output reg ld, shift, sub, restore, no_restore
    );

    reg [2:0] curstate, nextstate;

    localparam  S_LOAD = 3'd0,
                S_LOAD_WAIT = 3'd1,
                S_SHIFT = 3'd2,
                S_SUB = 3'd3,
                S_NEGSUB = 3'd4,
                S_POSSUB = 3'd5,
                S_FINISH = 3'd6;

    always @(*)
    begin case (curstate)
            S_LOAD: nextstate = go?S_LOAD:S_LOAD_WAIT;
            S_LOAD_WAIT: nextstate = go?S_LOAD_WAIT:S_SHIFT;
            S_SHIFT: nextstate = S_SUB;
            S_SUB: nextstate = negTrue?S_NEGSUB:S_POSSUB;
            S_NEGSUB: nextstate = (count == 3'd4)?S_FINISH:S_SHIFT;
            S_POSSUB: nextstate = (count == 3'd4)?S_FINISH:S_SHIFT;
            S_FINISH: nextstate = go?S_LOAD:S_FINISH;
        default: nextstate = S_LOAD;
        endcase
    end

    always @(*)
    begin
        ld = 1'b0;
        shift = 1'b0;
        sub = 1'b0;
        restore = 1'b0;
        no_restore = 1'b0;
        case (curstate)
            S_LOAD:begin
                ld = 1'b1;
            end
            S_SHIFT:begin
                shift = 1'b1; 
            end
            S_SUB:begin
                sub = 1'b1;
            end
            S_NEGSUB:begin
                restore = 1'b1;
            end
            S_POSSUB:begin
                no_restore = 1'b1;
            end
        endcase
    end

    //advance states
    always@(posedge clk)
    begin
        if(!resetn)
            curstate <= S_LOAD;
        else
            curstate <= nextstate;
    end
endmodule

module data(input clk, 
            input resetn, 
            input [3:0]dividend, 
            input [3:0]divisor, 
            input ld, shift, sub, restore, no_restore,

            output reg [3:0]reg_q,
            output reg [3:0]reg_a,
            output reg negTrue,
            output reg counter
            );
    //2 registers
    //reg_q is loaded by dividend and shifted left
    //regA loaded with null and gets shifted into

    always @(posedge clk)
    begin
        if(!resetn)begin
            reg_a <= 3'b0;
            reg_q <= 3'b0;
        end
        else if(ld)begin
            reg_q <= dividend;
            reg_a <= 4'b0;
        end
        else if(shift)begin
            reg_a <= {reg_a[2:0], reg_q[3]};
            reg_q <= {reg_q[2:0], 0};
        end
        else if(sub)begin
            reg_a <= reg_a - divisor;
            negTrue <= reg_a[3];
        end
        else if(restore)begin
            reg_a <= reg_a + divisor;
            reg_q[0] <= 1'b0;
            counter <= counter + 1;
        end
        else if(no_restore)begin
            reg_q[0] <= 1'b1;
            counter <= counter + 1;
        end
    end
endmodule