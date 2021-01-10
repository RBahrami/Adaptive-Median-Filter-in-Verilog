// load.v
// Adaptive Median Filter
// Load Module
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

module load (data, addr, dataCount, M, N, loadF, loadEn, clk, rst);
	// Parameters
	parameter ADDR_WIDTH = 8, DATA_WIDTH = 8, DEPTH = 256;

	// Outputs
	output reg [DATA_WIDTH - 1 : 0]	data;
	output reg [ADDR_WIDTH - 1 : 0]	addr;
	output reg [31 : 0] 			dataCount;
	output reg [15 : 0]				M, N;
	output reg						loadF;

	// Inputs
	input wire 						loadEn, clk, rst;

	// Variables
	integer imageFile;

	initial begin
		imageFile 	= $fopen ("../inputImage.hex", "r");
		$fscanf(imageFile, "M = %d N = %d\n", M, N);
	end

	always @(posedge clk)
		if(rst) begin
			data 		<= 0;
			addr 		<= 0;
			dataCount	<= 0;
			loadF 	<= 0;
		end // if(rst)
		else if(loadEn) begin
			if ($fscanf(imageFile , "%h\n", data) == -1) begin
							loadF <= 1;
			end // if(End of file)
			else begin
				@(negedge clk)
				#5
				addr 		<= addr + 1;
				dataCount	<= dataCount + 1;
			end // else
		end // else if(loadEn)

endmodule