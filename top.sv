/*
 * Module `top.sv`
 *
 * This is the top for the testbench for the `uart_reciever8.sv`.
 *
 * 
 */


`include "uart_reciever8tb.sv"
`include "uart_reciever8.sv"


module top;
    logic 	rst;
    logic 	clk;
    logic 	rx;
    logic [7:0] result;
    
    // CLOCK DIVIDER
//    localparam int BAUD_RATE_DIVISOR = 3333; // This is for a baud rate of 9601 (aka 9600)
    
//    logic clk;

//    int clk_count = 0;

    // Converts hardware clk into uart clk with proper baud rate
//    always_ff @(posedge hardware_clk) begin
//        clk_count <= clk_count + 1;
//        clk     <= 1'b0;
//        if (clk_count == BAUD_RATE_DIVISOR) begin
//            clk <= 1'b1;
//            clk_count <= 0; 
//        end
//    end
	    
    uart_reciever8tb TB (.*);
    uart_reciever8 dut (.*);


    initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0,top);
	$monitor($time, "Reciever State = %0d, rx = %b, result = %b", 
		dut.current_state, rx, result);
	rst = 1;
	clk = 0;
	#5 clk = 1; rst <= 0;
	repeat (200) #5 clk = ~clk;
	$finish;
    end
endmodule: top
