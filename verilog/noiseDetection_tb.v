// noiseDetection_tb.v
// Adaptive Median Filter
// Noise Detection Module test bench
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

module noiseDetection_tb;
	// Wires
	wire noiseF;

	// Registers
	reg [7 : 0] wCenter;

	noiseDetection #(.DATA_WIDTH(8), .T1(0), .T2(255))	noiseDetection0(noiseF, wCenter);

	initial begin
		$monitor("wCenter = %d, noiseF = %b", wCenter, noiseF);
		#10 wCenter = 14;
		#10 wCenter = 0;
		#10 wCenter = 200;
		#10 wCenter = 100;
		#10 wCenter = 255;
		#10 wCenter = 0;
		#10 wCenter = 250;
		#10 wCenter = 255;
	end
endmodule
