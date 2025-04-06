///////////////////////////////////////////
// rotator.sv
//
// Written: jacobpease@protonmail.com 18 March 2022
// Modified: 
//
// Purpose: Rotating bit shifter. Can be any width.
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

module rotator #(parameter WIDTH = 4) (
  input logic [WIDTH-1:0] X,
  input logic Right,
  input logic [$clog2(WIDTH)-1:0] Amt,

  output logic [WIDTH-1:0] Y
);

  logic [WIDTH+2**($clog2(WIDTH))-2:0] z, zshift;
  logic [$clog2(WIDTH)-1:0] offset;

  // Extend input for rotation.
  // Left shifting and right shifting are unique.
  // Input is extended by maximum right shift.
  if (2**($clog2(WIDTH)) - 1 - WIDTH > 0) begin
    always_comb
      begin 
        if (Right)   z = {X[2*WIDTH-2**($clog2(WIDTH))-1:0],X, X};
        else         z = {X, X, X[WIDTH-1:2*WIDTH-2**($clog2(WIDTH))+1]};
      end
  end else if (2**($clog2(WIDTH)) - 1 - WIDTH == 0) begin // WIDTH ~ 2^N - 1
    always_comb
      begin 
        if (Right)   z = {X, X};
        else         z = {X, X};
      end
  end else begin // WIDTH ~ 2^N
    always_comb
      begin 
        if (Right)   z = {X[WIDTH-2:0], X};
        else         z = {X, X[WIDTH-1:1]};
      end
  end

  assign offset = Right ? Amt : ~Amt;

  assign zshift = z >> offset;
  assign Y = zshift[WIDTH-1:0];

endmodule // rotator

