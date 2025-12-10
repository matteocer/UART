/*
 * Testbench `uart_reciever8tb`
 *
 * This sends a message to uart_reciever to see if it is working.
 * 
 */

`timescale 1ns/1ps

program uart_reciever8tb (
	input  logic       rst,
	input  logic       clk,
	output logic       rx,
	input  logic [7:0] result
    );
    
    // Arbitrary message used to check if working with start bit (0) at end
    bit [7:0] message = 8'hFA;  
    bit [8:0] signal = {message, 1'b0};
    initial begin	
	rx = 1'b1;
	@(posedge clk);
	for (byte i = 0; i < 9; i += 1) begin
	    @(posedge clk);
	    rx = signal[i];
	end
	rx = 1'b1;
	repeat (100) @(posedge clk);
    end	
endprogram: uart_reciever8tb
