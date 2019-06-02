`timescale 1ns / 1ps

module FSM(
    input clk,
    input enable,
    input reset,
    output [7:0] c1,
    output [7:0] c2,
    output [7:0] c3,
    output [7:0] c4
    );
 /*calling 4 counters*/	 
 reg en1, en2, en3, en4;
 
	counter counter1  (
    .clk(clk), 
    .reset(reset), 
    .enable(en1), 
    .cout(c1)
    );
	 
	 counter counter2  (
    .clk(clk), 
    .reset(reset), 
    .enable(en2), 
    .cout(c2)
    );
	 
	counter counter3 (
    .clk(clk), 
    .reset(reset), 
    .enable(en3), 
    .cout(c3)
    );
	 
	 counter counter4  (
    .clk(clk), 
    .reset(reset), 
    .enable(en4), 
    .cout(c4)
    );
  /*----------*/
  
  /* auxilary counter*/
  
  reg [3:0] aux_cout;
  reg rst_auxcounter, en_auxcounter;
  parameter max_count1 = 1,
            max_count2 = 2,
            max_count3 = 3,
            max_count4 = 4;
  
  always@(posedge clk)
	 begin
		if(reset)
			aux_cout <= 0;
		else if(rst_auxcounter)
			aux_cout <= 0;
		else if(en_auxcounter)
			aux_cout <= aux_cout + 1;
		else
			aux_cout <= aux_cout;
	 end

assign counter1_comp = (aux_cout == max_count1);
assign counter2_comp = (aux_cout == max_count2);
assign counter3_comp = (aux_cout == max_count3);
assign counter4_comp = (aux_cout == max_count4);
  
  /*--------*/
  
  /* states of FSM*/
  
  parameter init = 0,
            A = 1,   //C1
				B = 2,   //C2
				C = 3,   //C3
				D = 4;   //C4
				
  /*--------*/
  
  reg [3:0] CS, NS;
  
  always@(posedge clk)
	 begin
		if(reset)
			CS <= init;
		else if(~enable)
			CS <= init;
		else
			CS <= NS;
	end

 always@(posedge clk)
   begin
	 /* default values*/
	  en1 = 0;
	  en2 = 0;
	  en3 = 0;
	  en4 = 0;
	  rst_auxcounter = 0;
	  en_auxcounter = 0;
	 /*----*/
	 
	/* next state logic*/
	
	case(CS)
	  init:
	    begin
		  rst_auxcounter = 1;
		  NS = A;
		 end
		 
	  A:
	    begin
		  en_auxcounter = 1;
		  en1 = 1;
		  if(counter1_comp)
		    begin
		    rst_auxcounter = 1;
			 en1 = 0;
			 NS = B;
			 end
		  else
		    NS = A;
		 end
		 
	  B:
	    begin
		  en_auxcounter = 1;
		  en2 = 1;
		  if(counter2_comp)
		    begin
			 rst_auxcounter = 1;
			 en2 = 0;
			 NS = C;
			 end
		  else
		    NS = B;
		 end
		 
		C:
	    begin
		  en_auxcounter = 1;
		  en3 = 1;
		  if(counter3_comp)
		    begin
			 rst_auxcounter = 1;
			 en3 = 0;
			 NS = D;
			 end
		  else
		    NS = C;
		 end
		 
		D:
	    begin
		  en_auxcounter = 1;
		  en4 = 1;
		  if(counter4_comp)
		    begin
			 rst_auxcounter = 1;
			 en4 = 0;
			 NS = A;
			 end
		  else
		    NS = D;
		 end
		 
		
		default: NS = init;
	   endcase
			 
  end  
	  
	  
endmodule
