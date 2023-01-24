module test;

	localparam FIRST = 1;
  localparam SECOND = 2;
  localparam THIRD = 4;
  localparam FOURTH = 8;
	logic CLK;
	logic RST;
  logic [3:0] A;
	logic isNotEnd;
  logic userWins;
  logic [23:0] s;
  typedef enum logic [23:0] {S0=24'b000000000000000000000001, S1=24'b000000000000000000000010, S2=24'b000000000000000000000100, S3=24'b000000000000000000001000, S4_0=24'b000000000000000000010000, S4_1=24'b000000000000000000100000, S4_2=24'b000000000000000001000000, S4_3=24'b000000000000000010000000, S4_4=24'b000000000000000100000000, S5=24'b000000000000001000000000, S6_0=24'b000000000000010000000000, S6_1=24'b000000000000100000000000, S6_2=24'b000000000001000000000000, S7_0=24'b000000000010000000000000, S7_1=24'b000000000100000000000000, S7_2=24'b000000001000000000000000, S7_3=24'b000000010000000000000000, S7_4=24'b000000100000000000000000, S8=24'b000001000000000000000000, S9=24'b000010000000000000000000, S10_0=24'b000100000000000000000000, S10_1=24'b001000000000000000000000, S10_2=24'b010000000000000000000000, S11=24'b100000000000000000000000} statetype;

	sanmoku 
	uut
	(
		.CLK(CLK),
		.RST(RST),
    .A(A),
		.isNotEnd(isNotEnd),
    .userWins(userWins),
    .s(s)
	);

  int isEnd;

	initial begin
		$dumpfile("uut.vcd");
		$dumpvars(0, uut, CLK, RST, s);
	end

	// generate a clock sequence
	initial begin
		CLK = 0;
		forever begin
			#5 CLK = !CLK;
		end
	end

	// geberate a reset sequence
	initial begin
		RST = 0;
 		#50;
		RST = 1;
		#50
		RST = 0;
		#100;
		$finish;
	end

  // select action
  always_comb begin
    if (uut.s == S0) begin
      A = FIRST;
    end else if (uut.s == S1 | uut.s == S2) begin
      A = SECOND;
    end else if (uut.s == S3 | uut.s == S4_0 | uut.s == S4_1 | uut.s == S4_2 | uut.s == S4_3 | uut.s == S4_4 | uut.s == S7_0 | uut.s == S7_1 | uut.s == S7_2 | uut.s == S7_3 | uut.s == S7_4 | uut.s == S8) begin
      A = THIRD;
    end else begin
      A = FOURTH;
    end
  end

	// observe signals
	initial begin
    A = FIRST;
		#100;
    $write("state = %b isNotEnd = %b userWins = %b\n", uut.s, uut.isNotEnd, uut.userWins);
    $display("-------");
    $display("| | | |");
    $display("-------");
    $display("| |o| |");
    $display("-------");
    $display("| | | |");
    $display("-------");
		forever begin
			@(posedge CLK);
			#5;
      if (isEnd == 0 & uut.s != S11) begin
        $write("state = %b isNotEnd = %b userWins = %b\n", uut.s, uut.isNotEnd, uut.userWins);
        $display("-------");
        if (uut.s == S1) begin
          $display("|o|x| |");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("| | | |");
        end else if (uut.s == S2) begin
          $display("|x| | |");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("|o| | |");
        end else if (uut.s == S3) begin
          $display("|o|x| |");
          $display("-------");
          $display("|o|o| |");
          $display("-------");
          $display("| | |x|");
        end else if (uut.s == S4_0) begin
          $display("|o|x|x|");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("| | |o|");
        end else if (uut.s == S4_1) begin
          $display("|o|x| |");
          $display("-------");
          $display("|x|o| |");
          $display("-------");
          $display("| | |o|");
        end else if (uut.s == S4_2) begin
          $display("|o|x| |");
          $display("-------");
          $display("| |o|x|");
          $display("-------");
          $display("| | |o|");
        end else if (uut.s == S4_3) begin
          $display("|o|x| |");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("|x| |o|");
        end else if (uut.s == S4_4) begin
          $display("|o|x| |");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("| |x|o|");
        end else if (uut.s == S5) begin
          $display("|o|x| |");
          $display("-------");
          $display("|o|o|o|");
          $display("-------");
          $display("|x| |x|");
        end else if (uut.s == S6_0) begin
          $display("|o|x|x|");
          $display("-------");
          $display("|o|o| |");
          $display("-------");
          $display("|o| |x|");
        end else if (uut.s == S6_1) begin
          $display("|o|x| |");
          $display("-------");
          $display("|o|o|x|");
          $display("-------");
          $display("|o| |x|");
        end else if (uut.s == S6_2) begin
          $display("|o|x| |");
          $display("-------");
          $display("|o|o| |");
          $display("-------");
          $display("|o|x|x|");
        end else if (uut.s == S7_0) begin
          $display("|x|x|o|");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("|o| | |");
        end else if (uut.s == S7_1) begin
          $display("|x| |o|");
          $display("-------");
          $display("|x|o| |");
          $display("-------");
          $display("|o| | |");
        end else if (uut.s == S7_2) begin
          $display("|x| |o|");
          $display("-------");
          $display("| |o|x|");
          $display("-------");
          $display("|o| | |");
        end else if (uut.s == S7_3) begin
          $display("|x| |o|");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("|o|x| |");
        end else if (uut.s == S7_4) begin
          $display("|x| |o|");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("|o| |x|");
        end else if (uut.s == S8) begin
          $display("|x| |x|");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("|o|o| |");
        end else if (uut.s == S9) begin
          $display("|x|x|x|");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("|o|o| |");
        end else if (uut.s == S10_0) begin
          $display("|x|o|x|");
          $display("-------");
          $display("|x|o| |");
          $display("-------");
          $display("|o|o| |");
        end else if (uut.s == S10_1) begin
          $display("|x|o|x|");
          $display("-------");
          $display("| |o|x|");
          $display("-------");
          $display("|o|o| |");
        end else if (uut.s == S10_2) begin
          $display("|x|o|x|");
          $display("-------");
          $display("| |o| |");
          $display("-------");
          $display("|o|o|x|");
        end
        $display("-------");
      end

      if (isEnd == 1) begin
        if (uut.userWins == 1) begin
          $display("You Win");
        end else begin 
          $display("You Lose");
        end
        $finish;
      end
      if (uut.isNotEnd == 0) isEnd = 1;
		end
	end

endmodule
