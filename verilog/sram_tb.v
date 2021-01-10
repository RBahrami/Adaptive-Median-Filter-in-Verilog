// sram_tb.v
// Adaptive Median Filter
// SRAM Module test bench
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

`define DATA_WIDTH 	8
`define ADDR_WIDTH 	8
`define DEPTH		256

module sram_tb1;
	reg 	clk, wr;
	reg 	[`ADDR_WIDTH - 1 : 0] addr;
	reg 	[`DATA_WIDTH - 1 : 0] dataIn;
	wire	[`DATA_WIDTH - 1 : 0] dataOut;

	sram #(.DATA_WIDTH (`DATA_WIDTH),.ADDR_WIDTH(`ADDR_WIDTH), .DEPTH(`DEPTH)) sram0(dataOut, dataIn, addr, wr, clk);

	initial begin
		$display("sram test bench.");
		// Generate clock signal
		clk = 0;
		forever #10 clk = ~clk;
	end

	initial begin
		addr = 0;
		dataIn = 50;
		wr = 1;
		$display("Write data to sram");
		repeat (10) begin
			@(posedge clk)
			#5
			addr = addr + 1;
			dataIn = dataIn + 1;
		end

		wr = 0;
		addr = 0;
		dataIn = 0;
		$display("Read data from sram");
		repeat (10) begin
			@(posedge clk)
			#5
			$display ("addr = %h, data = %d", addr, dataOut);
			addr = addr + 1;
			dataIn = dataIn + 1;
		end

		$stop;
	end
endmodule


module sram_tb2;
	reg 	clk, wr;
	reg 	[`ADDR_WIDTH - 1 : 0] addr;
	reg 	[`DATA_WIDTH - 1 : 0] dataIn;
	wire 	[`DATA_WIDTH - 1 : 0] dataOut;

	reg [1 : 0] state;
	reg [15 : 0] dataCount;
	integer inFile, outFile;
	
	sram #(.DATA_WIDTH (`DATA_WIDTH),.ADDR_WIDTH(`ADDR_WIDTH), .DEPTH(`DEPTH)) sram0(dataOut, dataIn, addr, wr, clk);

	initial begin
		$display("sram test bench 2.");

		// Open input and output files 
		inFile 	= $fopen ("../inFile.hex", "r");
		outFile	= $fopen ("../outFile.hex", "w");

		// Generate clock signal
		clk = 0;
		forever #10 clk = ~clk;
	end

	initial begin
		state = 0; // Read Mode
		addr = 0;
		dataCount = 0;
		forever @(posedge clk) begin
			case (state)
				0 :	begin // Read data from inFile into sram
						wr = 1;
						if ($fscanf(inFile , "%d\n", dataIn) == -1) begin
							wr = 0;
							addr = 0;
							state = 1; // Write Mode
						end // if(End of file)
						else begin
							@(negedge clk)
							#5 wr = 0;
							addr = addr + 1;
						end // else
						dataCount = dataCount + 1;
				end // case 0
				1 :	begin // Write data from sram into outFile
						#5
						$fwrite(outFile, "address : %d , data : %d\n", addr, dataOut);
						addr = addr + 1;
						dataCount = dataCount - 1;
						if(dataCount == 1)
							state = 2;
				end // case 1
				2 : 	$stop;
			endcase
		end // forever @(posedge clk)
	end
endmodule
