module fp_multiplier(
    input [31:0] a,    // Input floating-point number a
    input [31:0] b,    // Input floating-point number b
    output [31:0] result // Result of the multiplication
);
    // IEEE 754 single precision fields (1-bit sign, 8-bit exponent, 23-bit mantissa)
    wire sign_a = a[31];
    wire sign_b = b[31];
    wire [7:0] exp_a = a[30:23];
    wire [7:0] exp_b = b[30:23];
    wire [23:0] mant_a = {1'b1, a[22:0]}; // Add implicit leading 1
    wire [23:0] mant_b = {1'b1, b[22:0]}; // Add implicit leading 1
    
    // Output fields
    wire sign_result;
    wire [7:0] exp_result;
    wire [47:0] mant_result; // 24-bit * 24-bit = 48-bit result

    // Sign of the result
    assign sign_result = sign_a ^ sign_b;

    // Mantissa multiplication
    assign mant_result = mant_a * mant_b;

    // Exponent addition (subtract the bias)
    wire [8:0] exp_sum;
    assign exp_sum = exp_a + exp_b - 8'd127;

    // Normalize the result
    wire [22:0] normalized_mant;
    wire [7:0] final_exp;
    
    // If the result is normalized (i.e., the top bit is 1), no shift is needed
    // Otherwise, shift mantissa right and adjust the exponent
    assign normalized_mant = mant_result[47] ? mant_result[46:24] : mant_result[45:23];
    assign final_exp = mant_result[47] ? exp_sum + 1'b1 : exp_sum;

    // Handling overflow and underflow (optional: can add conditions for zero, inf, etc.)
    assign exp_result = (final_exp > 8'd255) ? 8'd255 : (final_exp < 8'd0) ? 8'd0 : final_exp;

    // Result assembly
    assign result = {sign_result, exp_result, normalized_mant};

endmodule
