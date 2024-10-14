`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 14:08:39
// Design Name: 
// Module Name: mac_tb
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


module tb_mac_unit;
    
    // Declare inputs to the MAC unit as reg (to drive values) and output as wire
    reg [31:0] a;           // Input 'a' for multiplication
    reg [31:0] b;           // Input 'b' for multiplication
    reg [31:0] acc;         // Input accumulator (previous result)
    wire [31:0] result;     // Output result from the MAC unit
    
    // Instantiate the MAC unit
    mac_unit uut (
        .a(a),
        .b(b),
        .acc(acc),
        .result(result)
    );
    
    // Clock and reset signals (optional if needed in the design)
    // initial begin statement for generating stimulus to the inputs
    initial begin
        // Initialize inputs
        a = 32'h3F800000;  // 1.0 in IEEE 754 floating-point format
        b = 32'h40000000;  // 2.0 in IEEE 754 floating-point format
        acc = 32'h00000000; // 0.0 in IEEE 754 floating-point format
        
        // Wait for 10 time units
        #10;
        // Test case 2: Update inputs
        a = 32'h40400000;  // 3.0 in IEEE 754 floating-point format
        b = 32'h40800000;  // 4.0 in IEEE 754 floating-point format
        acc = result;      // Use previous result as the new accumulator

        // Wait for 10 time units
        #10;

        // Test case 3: Update inputs
        a = 32'h40A00000;  // 5.0 in IEEE 754 floating-point format
        b = 32'h40C00000;  // 6.0 in IEEE 754 floating-point format
        acc = result;      // Use previous result as the new accumulator

        // Wait for 10 time units
        $finish;
    end

endmodule
