/*
 * Module `uart_reciever8`
 *
 * This is an 8 bit uart receiver module set with a baud rate of 9600.
 * It is made to work with the clk on the Tang Nano 1K (32 MHz).
 * The 8 bit output from the transaction is given.
 */

module uart_reciever8 (
        input logic        rst,
        input logic        clk,
        input logic        rx,
        output logic [7:0] result
    );

    localparam int BITS_TRANSFERED = 8;


    // UART CLOCK DIVIDER 

    //localparam int BAUD_RATE_DIVISOR = 3333; // This is for a baud rate of 9601 (aka 9600)
    //
  //  logic uart_clk;
//
  //  int uart_clk_count = 0;
//
 //   // Converts hardware clk into uart clk with proper baud rate
 //   always_ff @(posedge hardware_clk) begin
//        uart_clk_count <= uart_clk_count + 1;
//        uart_clk     <= 1'b0;
//        if (uart_clk_count == BAUD_RATE_DIVISOR) begin
//            uart_clk <= 1'b1;
     //       uart_clk_count <= 0; 
   //     end
   // end

    // State Machine Logic 

    typedef enum logic {
        IDLE,
        RECEIVING
    } state_e;

    state_e current_state;
    int received_bit = 0;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= IDLE;
        end
	else begin
            case (current_state) 
                IDLE: begin 
                    if (~rx) begin
                        current_state <= RECEIVING;
                    end
                end
                RECEIVING: begin
                    result[received_bit] <= rx;
                    received_bit <= received_bit + 1;
                    if (received_bit == BITS_TRANSFERED) begin
                        received_bit  <= 0;
                        current_state <= IDLE;
                    end
                end
            endcase 
        end
    end

endmodule: uart_reciever8
