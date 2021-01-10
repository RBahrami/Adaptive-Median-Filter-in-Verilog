// sb_tb.v
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

module sb_tb;
	reg [7 : 0] _1, _2, _3;
	wire [7 : 0] min, med, max;

	sb #(.DATA_WIDTH(8)) sb0(min, med, max, _1, _2, _3);

	initial begin
		_1 <= 0;
		_2 <= 0;
		_3 <= 0;
		$monitor("%d, %d, %d : min = %d, med = %d, max = %d", _1, _2, _3, min, med, max);
		#10
		_1 <= 200;
		#10
		_2 <= 255;
		#10
		_3 <= 220;
		#10
		_2 <= 100;
		#10
		_3 <= 10;
		#10
		_1 <= 1;
		#10
		_1 <= 145;
		_2 <= 145;
		_3 <= 145;
	end
endmodule
