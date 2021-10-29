module LUT (letter,encoded);
    input [3:0]letter;
    output reg [11:0]encoded;
    always @(*) begin
        case(letter)
        3'b000: encoded <= 12'b101110000000;
        3'b001: encoded <= 12'b111010101000;
        3'b010: encoded <= 12'b111010111010;
        3'b011: encoded <= 12'b111010100000;
        3'b100: encoded <= 12'b100000000000;
        3'b101: encoded <= 12'b101011101000;
        3'b110: encoded <= 12'b111011101000;
        3'b111: encoded <= 12'b101010100000;
        default: encoded <= 12'b000000000000;

    endcase
    end    
endmodule

module divider(ClockIn, pulse);
    input ClockIn;
    reg counter;
    output pulse;

    assign pulse = (counter == 10'b0000000000) ? 1:0;
    always @(posedge ClockIn)
    begin
        if (counter == 10'b0000000000)
            counter <= 10'b1011101110 - 1; 
        else
            counter = counter - 1;
    end

endmodule

// module dff (
//     clock, D, Q
// );
//     input clock, D;
//     reg Q;
//     always @(posedge clock) begin
//         Q <= D;
//     end
    
// endmodule

module shift_reg12 (D, shift_D);
    input [11:0]D;
    output [11:0]shift_D;
    assign shift_D = {D[0],D[11],D[10],D[9],D[8],D[7],D[6],D[5],D[4],D[3],D[2],D[1]};
    
endmodule

module part3 (ClockIn, Resetn, Start, Letter, DotDashOut);
    input ClockIn, Resetn, Start;
    input [2:0]Letter;
    output reg DotDashOut;
    
    wire pulse;
    wire [11:0]cur_letter_encoded;
    reg [11:0]cur_output_encoded;
    wire [11:0]cur_output_shifted;

    shift_reg12 s0(cur_output_encoded, cur_output_shifted);

    divider d1(.ClockIn(ClockIn),.pulse(pulse));
    LUT lut1(.letter(Letter), .encoded(cur_letter_encoded));

    always @(posedge ClockIn, negedge Resetn) begin
        if (Resetn == 1'b0)
            DotDashOut <= 1'b0;
        else if (Start == 1'b1)
            cur_output_encoded <= cur_letter_encoded;
        else
            DotDashOut <= cur_output_encoded[11];
            cur_output_encoded <= cur_output_shifted; 
    end


    
endmodule