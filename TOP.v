`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SCV
// Engineer: NITHISH ROY, SRINIKETH SEKAR, VALAN RAJ S
// 
// Create Date: 05/13/2025 05:52:23 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: used slide switchs to give input to fpga
the it drives the motor using l298 driver
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (
    input clk,               // 50 MHz clock
    input rst,               // Reset signal
    input dir,               // Direction control (0 or 1)
    input [7:0]duty_cycle,
    output [7:0]led,
    output pwm_to_ENA,       // PWM output for ENA
    output reg IN1,          // Direction pin 1
    output reg IN2           // Direction pin 2
);


    // Instantiate the PWM module
    pwm_100hz_fullspread pwm_gen (
        .clk(clk),
        .rst(rst),
        .duty_cycle(duty_cycle),  // Pass duty_cycle input to PWM module
        .pwm_out(pwm_to_ENA)      // PWM signal connected to ENA
    );

    always @(*) begin
        case (dir)
            1'b0: begin
                IN1 = 1;  // Forward direction
                IN2 = 0;
            end
            1'b1: begin
                IN1 = 0;  // Reverse direction
                IN2 = 1;
            end
        endcase
    end
    
    
assign led = duty_cycle;
endmodule

