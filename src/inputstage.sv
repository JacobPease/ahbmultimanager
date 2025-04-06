/*`include "wally-config.vh"

import ahbspec::*;

module inputstage(
	input logic HCLK, 
	input logic HRESETn,
	input AHBManager inRequest,
	input logic HSEL, // HSELD or just HSEL?
	input logic GRANT,
	input logic GRANTD,
	input logic HREADY,
	output AHBManager outRequest
);

	AHBManager requestDelay;
	// AHBManager requestMux;
	logic enable;

	typedef enum logic {INCOMING, STORED} statetype;
 	statetype curState, nextState;

	flopenl #(.TYPE(statetype)) busreg(HCLK, ~HRESETn, 1'b1, nextState, INCOMING, curState);

	always_comb
	case(curState)
		INCOMING: if (HSEL & HREADY & inRequest.HTRANS != 2'b00) // First request or first request response
					 			if (GRANT) nextState = INCOMING; // If granted access immediately upon requesting, send Incoming value as output
					 			else nextState = STORED; // Else, immediately output the stored value
					 		else nextState = INCOMING;
		STORED: if (HSEL & inRequest.HTRANS != 2'b00)
					 		if (GRANT & GRANTD) nextState = INCOMING;
					 		else nextState = STORED;
				 		else nextState = INCOMING;
	 	default: nextState = INCOMING;
	endcase


	// Feedback the delayed request if HREADY is low.
	// assign requestMux = HREADY ? inRequest : requestDelay;

	//flopr #(1) hreadyDelay(HCLK, ~HRESETn, HREADY, enable);
	// Store the input request until 

	assign enable = HREADY;
  flopenl #(.TYPE(AHBManager)) requestreg(HCLK, ~HRESETn, enable, inRequest, '{0,0,0,0,0,0,0,0}, requestDelay);

	// assign outRequest = curState == INCOMING ? inRequest : requestDelay;
	assign outRequest.HADDR = curState == INCOMING ? inRequest.HADDR : requestDelay.HADDR;
	assign outRequest.HWDATA = curState == INCOMING ? inRequest.HWDATA : requestDelay.HWDATA;
	assign outRequest.HSIZE = curState == INCOMING ? inRequest.HSIZE : requestDelay.HSIZE;
	assign outRequest.HWRITE = curState == INCOMING ? inRequest.HWRITE : requestDelay.HWRITE;
	assign outRequest.HTRANS = inRequest.HTRANS;



endmodule

// Think about if the flip flop works appropriately.

/*
	  |
	-----
	-____

*/

