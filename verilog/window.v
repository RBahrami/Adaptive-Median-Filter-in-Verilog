// window.v
// Adaptive Median Filter
// Window creation module
// AUTHOR : Reza Bahrami
// Email : r.bahrami.work@outlook.com

// MIT License
// 
// Copyright (c) 2021 Reza Bahrami
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

`default_nettype none

`include "PACK_ARRAY.v"

module window(pack_w , addrIn, windowF, dataIn, addrP, N, clk, rst);
	// Parameters
	parameter DATA_WIDTH = 8, ADDR_WIDTH = 8, WINDOW_N = 2;
	parameter WINDOW_W = 2 * WINDOW_N + 1;
	parameter WINDOW_S = WINDOW_W * WINDOW_W;

	// Outputs 
	output wire [199 : 0] 			pack_w;
	output reg [ADDR_WIDTH - 1 : 0] 	addrIn;
	output reg 					windowF;

	// Inputs
	input wire [DATA_WIDTH - 1 : 0] 	dataIn;
	input wire [ADDR_WIDTH - 1 : 0] 	addrP;
	input wire [15 : 0]			N;
	input wire 					clk, rst;

	// Registers
	reg [7 : 0] 				w [24 : 0];
	`PACK_ARRAY(8, 25, w, pack_w)

	// Wires
	wire [ADDR_WIDTH - 1 : 0] 		addrW;

	// Variables
	integer index, i, j;

	// Dataflow description 
	assign addrW = addrP + (i * N) + j;

	// Behavioral description of module
	always @(addrP) begin // Create new window
		windowF 	<= 0;
		i 		<= -WINDOW_N;
		j		<= -WINDOW_N;
		index		<= 0;
	end // always @(addrP)

	always @(posedge clk)
		if(rst) begin // Reset window
			// Reset w
			for (index = 0; index < 25; index = index + 1)
				w[index] = 0;
			windowF 	<= 1;
		end // if(rst)
		else if(~windowF) begin // Load window
			addrIn 	<= addrW;
			j		<= j + 1;
			if(j == WINDOW_N) begin
				j	<= -WINDOW_N;
				i	<= i + 1;
				// if (i == WINDOW_N + 1)
				// 	i <= -N
			end // if(j == WINDOW_W)
			@(negedge clk)
			#5
			w[index] 	<= dataIn;
			index 	<= index + 1;
			if (index == WINDOW_S)
				windowF = 1;
		end // if(~windowF)
endmodule
