`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 14:00:39
// Design Name: 
// Module Name: macc
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


module macc (
    input [31:0] a,          // First floating-point input for multiplication
    input [31:0] b,          // Second floating-point input for multiplication
    input [31:0] acc,        // Accumulator input (previous accumulated result)
    output [31:0] result     // Output result (new accumulated value)
);
    wire [31:0] mult_result; // Intermediate result of the multiplier
    wire [31:0] add_result;  // Intermediate result of the adder
    
    // Instantiate floating-point multiplier
    fp_multiplier multiplier (
        .a(a),
        .b(b),
        .result(mult_result)  // Store intermediate multiplication result
    );
    
    // Instantiate floating-point adder
    adder adder (
        .a(mult_result),      // Use multiplier result as input to the adder
        .b(acc),
        .sum(add_result)   // Store intermediate addition result
    );
    
    // The result of the MAC operation (accumulation)
    assign result = add_result;  // Only the adder drives the final result

endmodule
