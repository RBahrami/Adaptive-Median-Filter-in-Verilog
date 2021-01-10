// adaptive.v
// Adaptive Median Filter
// Adaptive computation module
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

module adaptive (out, min3, med3, max3, min5, med5, max5, wCenter);
	// Parameters
	parameter DATA_WIDTH = 8;

	// Outputs
	output wire [DATA_WIDTH - 1 : 0] out;

	// Inputs 
	input wire [DATA_WIDTH - 1 : 0] min3, med3, max3, min5, med5, max5, wCenter;

	// Wires
	wire ws;
	wire [DATA_WIDTH - 1 : 0] out3, out5;

	// Dataflow description of module

	// Select Window Size (ws = 1 : 5x5, ws = 0 : 3x3)
	assign ws = ((min3 == med3)) || (med3 == max3) ? 1 : 0;

	// 3x3 Window
	assign out3 = ((wCenter == min3) || (wCenter == max3)) ? med3 : wCenter;

	// 5x5 Window
	assign out5 = ((wCenter == min5) || (wCenter == max5)) ? med5 : wCenter;

	// Output Selection
	assign out = ws ? out5 : out3;
endmodule