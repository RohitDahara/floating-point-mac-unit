`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 02:54:37
// Design Name: 
// Module Name: adder_tb
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

module adder_tb;

    // Inputs
    reg [31:0] a;
    reg [31:0] b;

    // Output
    wire [31:0] sum;

    // Instantiate the floating point adder
    adder uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    // Test procedure
    initial begin
        // Display header
        
        // Test case 1: 1.0 + 1.0
        a = 32'b00111111100000000000000000000000; // 1.0
        b = 32'b00111111100000000000000000000000; // 1.0
        #10;

        // Test case 2: -1.0 + 1.0
        a = 32'b10111111100000000000000000000000; // -1.0
        b = 32'b00111111100000000000000000000000; // 1.0
        #10;

        // Test case 3: 2.0 + 3.0
        a = 32'b01000000000000000000000000000000; // 2.0
        b = 32'b01000000000011000000000000000000; // 3.0
        #10;

        // Test case 4: Small + Large number
        a = 32'b00110100000000000000000000000000; // 0.125 (2^-3)
        b = 32'b01000001000000000000000000000000; // 4.0
        #10;

        a = 32'b01000010001101101011000000000000;
        b = 32'b01000001101111000111000000000000; 
        #10;



        // Finish simulation
        $finish;
    end

endmodule
