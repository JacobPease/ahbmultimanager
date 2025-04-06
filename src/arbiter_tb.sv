// xz.sv
// David_Harris@hmc.edu 30 January 2022
// Demonstrate impact of x and z.

// load with vsim xz.sv

module testbench #(parameter MANAGERS = 4) ();
  logic [MANAGERS-1:0] requestV, grantedV;
  logic       clk;

  arbiter #(.MANAGERS(4)) dut(clk, requestV, grantedV);

  initial begin
      #0; clk = 0;
      requestV = 1111;
      #13 requestV = 4'b1111;
    //   #13 requestV = 4'b1111;
    //   #13 requestV = 4'b1111;
    //   #13 requestV = 4'b1111;
    //   #13 requestV = 4'b1111;
    //   #13 requestV = 4'b1111;
    //   #13 requestV = 4'b1111;
    //   #13 requestV = 4'b1111;
      #13 requestV = 4'b1111;
      #13 requestV = 4'b1010;
      #13 requestV = 4'b1110;      
      #13 requestV = 4'b1110;
      #13 requestV = 4'b0110;
      #13 requestV = 4'b0111;

      
      #13;  // y should be floating
      requestV = 4'b0001;
      #13;  // y should be floating
      requestV = 4'b0011;
      #13;  // y should be floating
      requestV = 4'b1011;
      #13;  // y should be floating

  end

    always begin
        #10 clk = ~clk;
    end

endmodule