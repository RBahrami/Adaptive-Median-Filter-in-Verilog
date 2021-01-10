// sorter5.v
// Adaptive Median Filter
// 5 input bubble sorter module
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

module sorter5 (o1, o2, o3, o4, o5, i1, i2, i3, i4, i5);
	// Parameters
	parameter DATA_WIDTH = 8;

	// Outputs
	output wire [DATA_WIDTH - 1 : 0] o1, o2, o3, o4, o5;

	// Inputs
	input wire [DATA_WIDTH - 1 : 0]  i1, i2, i3, i4, i5;

	// Wires
	wire [DATA_WIDTH - 1 : 0]	_11, _12, _13, _14, _15, _16, _17;
	wire [DATA_WIDTH - 1 : 0]	_21, _22, _23, _24, _25, _26, _27;
	wire [DATA_WIDTH - 1 : 0]	_31, _32, _33, _34, _35, _36, _37;
	wire [DATA_WIDTH - 1 : 0]	_41, _42, _43, _44, _45, _46, _47;

	// Dataflow of signals
	assign _21 = _11;
	assign _41 = _31;

	assign _15 = i5;
	assign _35 = _25;
	assign o5 = _45;

	// Instantiation of modules
	sorter2 #(.DATA_WIDTH(8))	
						sb11(_11, _12, i1, i2),
						sb12(_13, _14, i3, i4),
						
						sb21(_22, _23, _12, _13),
						sb22(_24, _25, _14, _15),

						sb31(_31, _32, _21, _22),
						sb32(_33, _34, _23, _24),

						sb41(_42, _43, _32, _33),
						sb42(_44, _45, _34, _35),

						sb51(o1, o2, _41, _42),
						sb52(o3, o4, _43, _44);

endmodule

