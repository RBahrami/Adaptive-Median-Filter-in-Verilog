// amf_tb.v
// Adaptive Median Filter (AMF)
// AMF module test bench
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

module amf_tb;
	// Registers
	reg 			filterEn, clk, rst;
	reg [7 : 0] 	sram0 [255 : 0];
	reg [7 : 0]		sram1[255 : 0];
	reg [15 : 0]	M,N;
	reg [7 : 0]		dataIn;
	// Wires
	wire [7 : 0] dataOut;
	wire [7 : 0] addrOut, addrIn;
	wire filterF;

	// Instantiation of amf module
	amf #(.DATA_WIDTH(8), .ADDR_WIDTH(8))	amf0(dataOut, addrOut, addrIn, filterF, dataIn, M, N, filterEn, clk, rst);

	// Load SRAM 0 (input data)
	integer index;
	initial
		for (index = 0; index <256; index = index + 1)
			sram0[index] = index;

	
	initial begin
		clk = 0;
		M = 15;
		N = 15;
		forever #10 clk = ~clk;
	end

	initial begin
		rst = 1;
		filterEn = 0;
		#30
		rst = 0;
		filterEn = 1;
		@(posedge filterF)
		#10
		@(posedge clk)
		$stop;
	end

	always @(negedge clk) fork
		dataIn = sram0[addrIn];
		sram1[addrOut] = dataOut;
	join
endmodule
