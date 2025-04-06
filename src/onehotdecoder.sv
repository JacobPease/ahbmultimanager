///////////////////////////////////////////
// priorityencoder.sv
//
// Written: jacobpease@protonmail.com 18 March 2022
// Modified: 
//
// Purpose: Priority encoder; One-hot to binary converter
// 
// A component of the Wally configurable RISC-V project.
// 
// Copyright (C) 2021 Harvey Mudd College & Oklahoma State University
//
// MIT LICENSE
// Permission is hereby granted, free of charge, to any person obtaining a copy of this 
// software and associated documentation files (the "Software"), to deal in the Software 
// without restriction, including without limitation the rights to use, copy, modify, merge, 
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
// to whom the Software is furnished to do so, subject to the following conditions:
//
//   The above copyright notice and this permission notice shall be included in all copies or 
//   substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//   INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//   PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS 
//   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
//   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
//   OR OTHER DEALINGS IN THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////////////////////

// onehot = 0001
// i=0 block::  1<<i = 1 = 0001 == onehot => Y=i=0
// input 0001 => output Y=0 (manager 0)



module onehotdecoder #(parameter WIDTH = 4)(
  input logic [WIDTH-1:0] onehot,
  output logic [$clog2(WIDTH)-1:0] decodedint
);

// genvar i;
always_comb
begin
  decodedint = '0;
  for (int i = 0; i < WIDTH; i++) begin : priorityencoder
    if ((1 << i) == onehot) begin
      decodedint = i;
    end  
  end
end




endmodule // bintoonehot
