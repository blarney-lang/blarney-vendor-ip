module PipelinedDivider (
	clock,
	denom,
	numer,
	quotient,
	remain);

  parameter DATA_WIDTH;
  parameter LATENCY;
  
	input	clock;
	input	[DATA_WIDTH-1:0] denom;
	input [DATA_WIDTH-1:0] numer;
	output [DATA_WIDTH-1:0] quotient;
	output [DATA_WIDTH-1:0] remain;

	lpm_divide LPM_DIVIDE_component (
				.clock(clock),
				.denom(denom),
				.numer(numer),
				.quotient(quotient),
				.remain(remain),
				.aclr(1'b0),
				.clken(1'b1));
	defparam
		LPM_DIVIDE_component.lpm_drepresentation = "SIGNED",
		LPM_DIVIDE_component.lpm_hint = "LPM_REMAINDERPOSITIVE=FALSE",
		LPM_DIVIDE_component.lpm_nrepresentation = "SIGNED",
		LPM_DIVIDE_component.lpm_pipeline = LATENCY,
		LPM_DIVIDE_component.lpm_type = "LPM_DIVIDE",
		LPM_DIVIDE_component.lpm_widthd = DATA_WIDTH,
		LPM_DIVIDE_component.lpm_widthn = DATA_WIDTH;

endmodule
