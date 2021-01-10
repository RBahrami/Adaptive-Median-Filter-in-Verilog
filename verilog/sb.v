// sb.v
// Adaptive Median Filter
// Sorting Block Module
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

module sb (min, med, max, _1, _2, _3);
	// Parameters
	parameter DATA_WIDTH = 8;

	// Outputs
	output wire [DATA_WIDTH - 1 : 0] min, med, max;

	// Inputs
	input wire [DATA_WIDTH - 1 : 0] _1, _2, _3;

	// Wires
	wire [DATA_WIDTH - 1 : 0]	max12, min12, med0;
	wire 					c0, c1 ,c2;

	// Instantiation of modules
	comparator	#(.DATA_WIDTH(DATA_WIDTH))	cmp0(c0, _1, _2),
								cmp1(c1, max12, med0),
								cmp2(c2, min12, _3);
	
	mux21		#(.W(DATA_WIDTH))			mux0(max12, _2, _1, c0),
								mux1(min12, _1, _2, c0),
								mux2(med0, _3, min12, c2),
								mux3(min, min12, _3, c2),
								mux4(max, med0, max12, c1),
								mux5(med, max12, med0, c1);
endmodule