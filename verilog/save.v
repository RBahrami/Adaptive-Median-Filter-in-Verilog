// save.v
// Adaptive Median Filter
// Save Module
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

module save(addr, saveF, data, dataCount, M, N, saveEn, clk, rst);
	// Parameter
	parameter DATA_WIDTH = 8, ADDR_WIDTH = 8;
	
	// Outputs
	output reg [ADDR_WIDTH - 1 : 0]	addr;
	output reg 					saveF;

	// Inputs
	input wire [DATA_WIDTH - 1 : 0]	data;
	input wire [31 : 0]			dataCount;
	input wire [15 : 0] 			M, N;
	input wire saveEn, clk, rst;

	// Variables
	integer imageFile;

	// Registers
	reg [31 : 0] 				count;
	reg [15 : 0]				column;
	reg						metaF;

	// Open / Create output file
	initial begin
		imageFile = $fopen("../outputImage.hex", "w");
	end

	always @(posedge clk)
		if(rst) begin
			addr	<= 0;
			saveF <= 0;
			count <= 1;
			metaF <= 0;
			column <= 0;
		end // if(rst)
		else if(saveEn) begin
			if(~metaF) begin
				$fwrite(imageFile, "M = %d, N = %d\n", M, N);
				metaF = 1;
			end // if(~metaF);
			#5
			$fwrite(imageFile, "%h ", data);
			addr 		= addr + 1;
			column 	= column + 1;
			if(column == N) begin
				$fwrite(imageFile, "\n");
				column = 0;
			end // if(column == N)
			count 	= count + 1;
			if(count == dataCount)
				saveF <= 1;
		end // else if(saveEn)
endmodule
