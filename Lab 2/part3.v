module hex_decoder(c, display);
    input [3:0] c;
    output [6:0] display;

    wire c0, c1, c2, c3;
    assign c0 = c[0];
    assign c1 = c[1];
    assign c2 = c[2];
    assign c3 = c[3];

    wire s0, s1, s2, s3, s4, s5, s6;
        
    assign s6 =      ((!c3)&(!c2)&(c1)&(!c0))| 
                     ((!c3)&(!c2)&(c1)&(c0))| 
                     ((!c3)&(c2)&(!c1)&(!c0))| 
                     ((!c3)&(c2)&(!c1)&(c0))| 
                     ((!c3)&(c2)&(c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(c0))|
                     ((c3)&(!c2)&(c1)&(!c0))|
                     ((c3)&(!c2)&(c1)&(c0))| 
                     ((c3)&(c2)&(!c1)&(c0))| 
                     ((c3)&(c2)&(c1)&(!c0))|
                     ((c3)&(c2)&(c1)&(c0));
    
    assign s5 = ((!c3)&(!c2)&(!c1)&(!c0))| 
                     ((!c3)&(c2)&(!c1)&(!c0))| 
                     ((!c3)&(c2)&(!c1)&(c0))| 
                     ((!c3)&(c2)&(c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(c0))|
                     ((c3)&(!c2)&(c1)&(!c0))|
                     ((c3)&(!c2)&(c1)&(c0))| 
                     ((c3)&(c2)&(!c1)&(!c0))|
                     ((c3)&(c2)&(c1)&(!c0))|
                     ((c3)&(c2)&(c1)&(c0));

    assign s4 = ((!c3)&(!c2)&(!c1)&(!c0))| 
                     ((!c3)&(!c2)&(c1)&(!c0))| 
                     ((!c3)&(c2)&(c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(!c0))|
                     ((c3)&(!c2)&(c1)&(!c0))|
                     ((c3)&(!c2)&(c1)&(c0))| 
                     ((c3)&(c2)&(!c1)&(!c0))|
                     ((c3)&(c2)&(!c1)&(c0))|
                     ((c3)&(c2)&(c1)&(!c0))|
                     ((c3)&(c2)&(c1)&(c0));

    assign s3 = ((!c3)&(!c2)&(!c1)&(!c0))| 
                     ((!c3)&(!c2)&(c1)&(!c0))| 
                     ((!c3)&(!c2)&(c1)&(c0))|  
                     ((!c3)&(c2)&(!c1)&(c0))| 
                     ((!c3)&(c2)&(c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(!c0))|
                     ((c3)&(!c2)&(c1)&(c0))| 
                     ((c3)&(c2)&(!c1)&(!c0))|
                     ((c3)&(c2)&(c1)&(!c0))| 
                     ((c3)&(c2)&(!c1)&(c0));

    assign s2 = ((!c3)&(!c2)&(!c1)&(!c0))| 
                     ((!c3)&(!c2)&(!c1)&(c0))| 
                     ((!c3)&(!c2)&(c1)&(c0))| 
                     ((!c3)&(c2)&(!c1)&(!c0))| 
                     ((!c3)&(c2)&(!c1)&(c0))| 
                     ((!c3)&(c2)&(c1)&(!c0))|
                     ((!c3)&(c2)&(c1)&(c0))|
                     ((c3)&(!c2)&(!c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(c0))|
                     ((c3)&(!c2)&(c1)&(!c0))|
                     ((c3)&(!c2)&(c1)&(c0)) |
                     ((c3)&(c2)&(!c1)&(c0)); 


    assign s1 = ((!c3)&(!c2)&(!c1)&(!c0))| 
                     ((!c3)&(!c2)&(!c1)&(c0))| 
                     ((!c3)&(!c2)&(c1)&(!c0))| 
                     ((!c3)&(!c2)&(c1)&(c0))| 
                     ((!c3)&(c2)&(!c1)&(!c0))| 
                     ((!c3)&(c2)&(c1)&(c0))|
                     ((c3)&(!c2)&(!c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(c0))|
                     ((c3)&(!c2)&(c1)&(!c0))|
                     ((c3)&(c2)&(!c1)&(c0));


    assign s0 = ((!c3)&(!c2)&(!c1)&(!c0))| 
                     ((!c3)&(!c2)&(c1)&(!c0))| 
                     ((!c3)&(!c2)&(c1)&(c0))| 
                     ((!c3)&(c2)&(!c1)&(c0))| 
                     ((!c3)&(c2)&(c1)&(!c0))|
                     ((!c3)&(c2)&(c1)&(c0))|
                     ((c3)&(!c2)&(!c1)&(!c0))|
                     ((c3)&(!c2)&(!c1)&(c0))|
                     ((c3)&(!c2)&(c1)&(!c0))|
                     ((c3)&(c2)&(!c1)&(!c0))|
                     ((c3)&(c2)&(c1)&(!c0))|
                     ((c3)&(c2)&(c1)&(c0));

    assign display[0] = !s0;
    assign display[1] = !s1;
    assign display[2] = !s2;
    assign display[3] = !s3;
    assign display[4] = !s4;
    assign display[5] = !s5;
    assign display[6] = !s6;

endmodule