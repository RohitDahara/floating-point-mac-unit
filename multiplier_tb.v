`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 03:19:59
// Design Name: 
// Module Name: multiplier_tb
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


`timescale 1ns / 1ps

module multiplier_tb;

    // Parameters
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] result;

    // Instantiate the multiplier
    fp_multiplier uut (
        .a(a),
        .b(b),
        .result(result)
    );


    // Test procedure
    initial begin
        // Initialize inputs
        a = 0; 
        b = 0;
        #10;

        // Test case 1: 2.0 * 3.0
        a = 32'b01000000000000000000000000000000; // 2.0
        b = 32'b01000000011000000000000000000000; // 3.0
        #10;
        
        // Test case 2: -2.0 * -3.0
        a = 32'b11000000000000000000000000000000; // -2.0
        b = 32'b11000000011000000000000000000000; // -3.0
        #10;

        // Test case 3: 0.0 * 3.0
        a = 32'b00000000000000000000000000000000; // 0.0
        b = 32'b01000000011000000000000000000000; // 3.0
        #10;

        // Test case 4
        a = 32'b01000010001101101011000000000000;  // 45.678 in IEEE 754 format
        b = 32'b01000001101111000111000000000000; // t76yu
        #10;

        // Finish simulation
        $finish;
    end


endmodule
