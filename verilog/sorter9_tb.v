// sorter9_tb.v
// Adaptive Median Filter
// 9 input sorter module test bench
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

module sorter9_tb;
	reg [7 : 0] _1, _2, _3, _4, _5, _6, _7, _8, _9;
	wire [7 : 0] min, med, max;

	sorter9 #(.DATA_WIDTH(8))	sorter0(min, med, max, _1, _2, _3, _4, _5, _6, _7, _8, _9);

	initial begin
		_1 <= 0;
		_2 <= 0;
		_3 <= 0;
		_4 <= 0;
		_5 <= 0;
		_6 <= 0;
		_7 <= 0;
		_8 <= 0;
		_9 <= 0;
		$monitor("%d, %d, %d, %d, %d, %d, %d, %d, %d : min = %d, med = %d, max = %d", _1, _2, _3, _4, _5, _6, _7, _8, _9, min, med, max);
		#10
		_1 <= 10;
		#10
		_2 <= 30;
		#10
		_3 <= 20;
		#10
		_4 <= 50;
		#10
		_5 <= 44;
		#10
		_6 <= 100;
		#10
		_7 <= 70;
		#10
		_8 <= 250;
		#10
		_9 <= 8;
		#10
		_4 <= 200;
		#10
		_7 <= 150;
		#10
		_2 <= 0;
		#10
		_1 <= 10;
		#10
		_3 <= 254;
		#10
		_6 <= 255;
		#10
		_2 <= 138;
		#10
		_8 <= 46;
		#10
		_1 <= 100;
		_2 <= 20;
		_3 <= 19;
		_4 <= 65;
		_5 <= 70;
		_6 <= 150;
		_7 <= 252;
		_8 <= 100;
		_9 <= 101;

	end

endmodule
