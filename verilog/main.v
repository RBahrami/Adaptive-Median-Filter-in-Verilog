// main.v
// Adaptive Median Filter
// Main Module
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

// defines
`define DATA_WIDTH 	8
`define ADDR_WIDTH 	18
`define DEPTH		262144

module main(endF, clk, rst);
	// Parameters

	// Outputs
	output reg endF;
	
	// Inputs
	input wire clk, rst;

	// Registers
	reg [3:0] state; // FSM
	reg loadEn, saveEn, filterEn;

	// Wires
	wire [`ADDR_WIDTH - 1 : 0]	addr0, addr1, addr2, addr3, addr01, addr23;
	wire [`DATA_WIDTH - 1 : 0]	data0, data1, data2, data3;
	wire [31 : 0] 				dataCount;
	wire [15 : 0]				M, N;
	wire 						loadF, saveF, filterF, wr0 , wr1;

	
	// Instantiation of modules
	sram 	#(.DATA_WIDTH (`DATA_WIDTH),.ADDR_WIDTH(`ADDR_WIDTH), .DEPTH(`DEPTH)) 	sram0(data1, data0, addr01, wr0, clk, rst);
	sram 	#(.DATA_WIDTH (`DATA_WIDTH),.ADDR_WIDTH(`ADDR_WIDTH), .DEPTH(`DEPTH)) 	sram1(data3, data2, addr23, wr1, clk, rst);

	load	#(.DATA_WIDTH (`DATA_WIDTH),.ADDR_WIDTH(`ADDR_WIDTH), .DEPTH(`DEPTH))	load0(data0, addr0, dataCount, M, N, loadF, loadEn, clk,rst);
	amf		#(.DATA_WIDTH (`DATA_WIDTH),.ADDR_WIDTH(`ADDR_WIDTH))					amf0(data2, addr2, addr1, filterF, data1, M, N, filterEn, clk, rst);
	save	#(.DATA_WIDTH (`DATA_WIDTH),.ADDR_WIDTH(`ADDR_WIDTH))					save0(addr3, saveF, data3, dataCount, M, N, saveEn, clk, rst);

	mux21 	#(.W(`ADDR_WIDTH))														mux0(.y(addr01), .d1(addr0), .d0(addr1), .s(loadEn)),
																					mux1(.y(addr23), .d1(addr3), .d0(addr2), .s(saveEn));
	
	// Dataflow description of signals
	assign wr0 = ~loadF;
	assign wr1 = ~filterF & loadF;

	// Behavioral description of FSM
	// state 0 : Initial Load Data
	// state 1 : Loading Data
	// state 2 : Initial Filter
	// state 3 : Filtering
	// state 4 : Initial Save Data
	// state 5 : Saving Data
	// state 6 : Finish
	always @(posedge clk) begin
		if(rst) begin
			endF		<= 0;
			state		<= 0;
			loadEn		<= 0;
			saveEn		<= 0;
			filterEn 	<= 0;
		end
		else 
			case(state)
				0 : begin // state 0 : Initial Load Data
					loadEn		<= 1;
					state		<= 1;
				end
				1 : begin // state 1 : Loading Data
					if(loadF) state <= 2;
				end
				2 : begin // state 2 : Initial Filter
					loadEn		<= 0;
					filterEn 	<= 1;
					state		<= 3;
				end
				3 : begin
					if(filterF) state <= 4;
				end
				4 : begin
					saveEn		<= 1;
					filterEn	<= 0;
					state 		<= 5;
				end
				5 : begin
					if(saveF) begin
						saveEn	 = 0;
						state	 = 6;
					end // if(saveF)
				end
				6 : begin
					endF = 1;
				end
			endcase
	end // always @(posedge clk)
endmodule
