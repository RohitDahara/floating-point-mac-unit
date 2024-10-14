`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 02:51:53
// Design Name: 
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder (
    input [31:0] a,  // 32-bit IEEE 754 single-precision floating-point number
    input [31:0] b,  // 32-bit IEEE 754 single-precision floating-point number
    output [31:0] sum  // 32-bit IEEE 754 floating-point result
);
    // Unpack the operands
    wire sign_a, sign_b;
    wire [7:0] exp_a, exp_b;
    wire [23:0] mantissa_a, mantissa_b;

    // Sign
    assign sign_a = a[31];
    assign sign_b = b[31];

    // Exponent
    assign exp_a = a[30:23];
    assign exp_b = b[30:23];

    // Mantissa (with implied leading 1 for normalized numbers)
    assign mantissa_a = {1'b1, a[22:0]};
    assign mantissa_b = {1'b1, b[22:0]};

    // Intermediate signals for alignment and sum
    reg [23:0] mantissa_a_shifted, mantissa_b_shifted;
    reg [7:0] exp_diff;
    reg [7:0] exp_result;
    reg sign_result;
    reg [24:0] mantissa_sum;  // 1 extra bit for carry

    // Step 1: Align the exponents by shifting the smaller mantissa
    always @(*) begin
        if (exp_a > exp_b) begin
            exp_diff = exp_a - exp_b;
            mantissa_a_shifted = mantissa_a;
            mantissa_b_shifted = mantissa_b >> exp_diff;
            exp_result = exp_a;
            sign_result = sign_a;
        end else begin
            exp_diff = exp_b - exp_a;
            mantissa_a_shifted = mantissa_a >> exp_diff;
            mantissa_b_shifted = mantissa_b;
            exp_result = exp_b;
            sign_result = sign_b;
        end
    end

    // Step 2: Add or subtract the mantissas based on signs
    always @(*) begin
        if (sign_a == sign_b) begin
            mantissa_sum = mantissa_a_shifted + mantissa_b_shifted;  // Same sign, add mantissas
        end else begin
            if (mantissa_a_shifted > mantissa_b_shifted) begin
                mantissa_sum = mantissa_a_shifted - mantissa_b_shifted;  // Different signs, subtract mantissas
            end else begin
                mantissa_sum = mantissa_b_shifted - mantissa_a_shifted;
                sign_result = sign_b;  // Result sign should follow larger magnitude
            end
        end
    end

    // Step 3: Normalize the result
    reg [22:0] mantissa_result;
    reg [7:0] exp_result_final;
    always @(*) begin
        if (mantissa_sum[24]) begin  // Check for overflow in mantissa addition
            mantissa_result = mantissa_sum[23:1];  // Right shift to normalize
            exp_result_final = exp_result + 1;
        end else if (mantissa_sum[23]) begin
            mantissa_result = mantissa_sum[22:0];  // Already normalized
            exp_result_final = exp_result;
        end else begin  // Leading zeroes in mantissa, normalize by shifting left
            mantissa_result = mantissa_sum[22:0];
            exp_result_final = exp_result;  // Adjust exponent after shift (implementing this would require more shifts)
        end
    end

    // Step 4: Pack the result
    assign sum = {sign_result, exp_result_final, mantissa_result};

endmodule
