`timescale 1ns / 1ns // `timescale time_unit/time_precision


module v7404 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
pin10, pin12);
	input pin1, pin3, pin5, pin13, pin11, pin9;
	output pin2, pin4, pin6, pin12, pin10, pin8;

	assign pin2 = ! pin1;
	assign pin4 = ! pin3;
	assign pin6 = ! pin5;
	assign pin12 = ! pin13;
	assign pin10 = ! pin11;
	assign pin8 = ! pin9;

endmodule

module v7408 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
pin10, pin12);
	input pin1, pin2, pin4, pin5, pin13, pin12, pin10, pin9;
	output pin3, pin6, pin11, pin8;
	assign pin3 = (pin1 & pin2);
	assign pin6 = (pin4 & pin5);
	assign pin11 = (pin13 & pin12);
	assign pin8 = (pin10 & pin9);
	
endmodule

module v7432 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8,
pin10, pin12);
	input pin1, pin2, pin4, pin5, pin13, pin12, pin10, pin9;
	output pin3, pin6, pin11, pin8;
	assign pin3 = (pin1 | pin2);
	assign pin6 = (pin4 | pin5);
	assign pin11 = (pin13 | pin12);
	assign pin8 = (pin10 | pin9);

endmodule


module mux2to1(x, y, s, m);
	input x,y,s;
	output m;
	wire w0, w1, w2;
	v7404 M_NOT(.pin1(s),.pin2(w0));
	v7408 M_AND(.pin1(x),.pin2(w0),.pin3(w1),.pin4(s),.pin5(y),.pin6(w2));
	v7432 M_OR(.pin1(w1), .pin2(w2),.pin3(m));
endmodule