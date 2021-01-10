// slider.v
// Adaptive Median Filter
// slider module
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

module slider(addrP, lastPixelF, trig, M , N, clk, rst);
	// Parameters
	parameter ADDR_WIDTH = 8, WINDOW_N = 2;

	// Outputs
	output reg [ADDR_WIDTH - 1 : 0] 	addrP;
	output reg					lastPixelF;
	
	// Inputs
	input wire 			trig, clk, rst;
	input wire [15 : 0] 	M, N;
	
	// Registers
	reg [15 : 0]	i, j;
	reg 			lastPixel;
	always @(posedge rst) begin
		i		<= WINDOW_N;
		j		<= WINDOW_N;
		lastPixelF	<= 0;
		lastPixel	<= 0;
	end // always @(posedge rst)

	always @(posedge trig) begin
		#5
		addrP <= i * N + j;
		if(lastPixel)
			lastPixelF = 1;
		j <= j + 1;
		if(j == N - WINDOW_N - 1) begin
			j <= WINDOW_N;
			i <= i + 1;
			if(i == M - WINDOW_N - 1)
				lastPixel <= 1;
		end // f(j == N)
	end // always @(posedge trig)
endmodule
