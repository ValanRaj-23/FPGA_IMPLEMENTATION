module pwm_100hz_fullspread (
    input clk,                // 50 MHz input clock
    input rst,                // Active-high reset
    input [7:0] duty_cycle,   // 8-bit duty cycle input (0-255)
    output reg pwm_out        // PWM output at 100 Hz
);

    reg [18:0] counter;       // 19 bits can count up to ~500,000
    wire [31:0] threshold;

    // Calculate duty threshold: (duty_cycle / 255) * 500_000
    // Multiply before division to preserve precision
    assign threshold = (duty_cycle * 500_000) / 255;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            if (counter >= 19'd499_999)
                counter <= 0;
            else
                counter <= counter + 1;

            pwm_out <= (counter < threshold) ? 1'b1 : 1'b0;
        end
    end

endmodule
