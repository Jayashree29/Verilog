`timescale 1ns / 1ps

module multi_mode_shifter(
    input clk,
    input reset,
    input enable,
    input right_left,
    input rotate,
    input [7:0]p_data,
    input p_load,
	input s_in,
    output [7:0] p_out,
    output s_out
    );

    reg [7:0] temp;
    
    always@(posedge clk)
    begin
         
        if(reset)
          temp <= 0;
          
        else if(p_load)
          temp <= p_data;
          
        else if(enable)
          if(rotate)
            if(right_left)
               temp <= {temp[0],temp[7:1]}; //right_rotate
             else
               temp <= {temp[6:0],temp[7]}; //left_rotate
          else
            if(right_left)  //right_shift
               begin
               temp[6:0] <= temp[7:1]; 
                temp[7] <= s_in;
                end
             else           //left_shift
               begin
               temp[7:1] <= temp[6:0];
                temp[0] <= s_in;
                end
        else
          temp <= temp;	   
               
    end  

    /*
    always@(*)      //update_s_out
    begin
    
    if(~rotate)
      if(right_left)
        s_out = temp[0];
      else
        s_out = temp[7];
    else 
      s_out = s_out;
      
    end
    */
    
    assign s_out = (~rotate & right_left) ? temp[0] : temp[7]; // s = a?b:c  if a is true, s=b if  not s = c
    assign p_out = temp;

endmodule
