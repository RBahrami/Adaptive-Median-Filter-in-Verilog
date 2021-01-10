// median_tb.v
// Adaptive Median Filter
// Median Calculation Module test bench
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

module median_tb;
	// Output Signals
	wire [7 : 0] min3, med3, max3, min5, med5, max5;

	// Input Signals
	reg [7 : 0] wBuffer [24 : 0];
	wire [199 : 0] pack_wBuffer;
	`PACK_ARRAY(8, 25, wBuffer, pack_wBuffer)

	// Instantiation of module
	median #(.WINDOW_BITS(200), .WINDOW_S(25), .DATA_WIDTH(8))	median0(min3, med3, max3, min5, med5, max5, pack_wBuffer);

	integer index;
	always begin
		// Generate window with random numbers
		for (index = 0; index < 25; index = index + 1)
			wBuffer[index] = $urandom%255;
		#10
		$display("%d	%d	%d	%d	%d", wBuffer[0],	wBuffer[1],	 wBuffer[2],  wBuffer[3],  wBuffer[4]);
		$display("%d	%d	%d	%d	%d", wBuffer[5], 	wBuffer[6],  wBuffer[7],  wBuffer[8],  wBuffer[9]);
		$display("%d	%d	%d	%d	%d", wBuffer[10], wBuffer[11], wBuffer[12], wBuffer[13], wBuffer[14]);
		$display("%d	%d	%d	%d	%d", wBuffer[15], wBuffer[16], wBuffer[17], wBuffer[18], wBuffer[19]);
		$display("%d	%d	%d	%d	%d", wBuffer[20], wBuffer[21], wBuffer[22], wBuffer[23], wBuffer[24]);
		#10
		$display("\n min3 = %d, med3 = %d, max3 = %d \n min5 = %d ,med5 = %d, max5 = %d", min3, med3, max3, min5, med5, max5);
		$stop;
	end
endmodule
