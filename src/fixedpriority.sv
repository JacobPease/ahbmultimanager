///////////////////////////////////////////
// reversearbiter.sv
//
// Written: jacobpease@protonmail.com 18 March 2022
// Modified: 
//
// Purpose: Fixed priority arbiter. Highest priority is LSB.
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

module fixedpriority #(parameter WIDTH = 4)(
  input logic [WIDTH-1:0] X,
  output logic [WIDTH-1:0] Y
);

  logic [WIDTH-1:0] cascade;
  logic [WIDTH-2:0] forwardNot;

  assign cascade[0] = 1'b1;

  genvar i;
  generate
    for (i = 0; i < WIDTH - 1; i++) begin : fixedPriority
      and (cascade[i+1], forwardNot[i], cascade[i]);
      not (forwardNot[i], X[i]);
      and (Y[i], cascade[i], X[i]);
    end
  endgenerate

  and (Y[WIDTH-1], cascade[WIDTH-1], X[WIDTH-1]);

endmodule // fixed arbiter

