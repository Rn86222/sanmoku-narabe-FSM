module sanmoku 
  (
    input logic CLK,
    input logic RST,
    input logic [3:0] A,
    output logic isNotEnd,
    output logic userWins,
    output logic [23:0] s
  );

  // one-hot encoding
  typedef enum logic [23:0] {S0=24'b000000000000000000000001, S1=24'b000000000000000000000010, S2=24'b000000000000000000000100, S3=24'b000000000000000000001000, S4_0=24'b000000000000000000010000, S4_1=24'b000000000000000000100000, S4_2=24'b000000000000000001000000, S4_3=24'b000000000000000010000000, S4_4=24'b000000000000000100000000, S5=24'b000000000000001000000000, S6_0=24'b000000000000010000000000, S6_1=24'b000000000000100000000000, S6_2=24'b000000000001000000000000, S7_0=24'b000000000010000000000000, S7_1=24'b000000000100000000000000, S7_2=24'b000000001000000000000000, S7_3=24'b000000010000000000000000, S7_4=24'b000000100000000000000000, S8=24'b000001000000000000000000, S9=24'b000010000000000000000000, S10_0=24'b000100000000000000000000, S10_1=24'b001000000000000000000000, S10_2=24'b010000000000000000000000, S11=24'b100000000000000000000000} statetype;
  statetype state, nextstate;

  // combinational
  always_comb begin
    case (state)
      S0: if (A % 2 == 1) nextstate = S1;
          else if (A == 4) nextstate = S11;
          else nextstate = S2;
      S1: case (A)
            8: nextstate = S3;
            2: nextstate = S4_0;
            3: nextstate = S4_1;
            5: nextstate = S4_2;
            6: nextstate = S4_3;
            7: nextstate = S4_4;
            default: nextstate = S11;
          endcase
      S2: case (A)
            2: nextstate = S8;
            1: nextstate = S7_0;
            3: nextstate = S7_1;
            5: nextstate = S7_2;
            7: nextstate = S7_3;
            8: nextstate = S7_4;
            default: nextstate = S11;
          endcase
      S3: case (A)
            6: nextstate = S5;
            2: nextstate = S6_0;
            5: nextstate = S6_1;
            7: nextstate = S6_2;
            default: nextstate = S11;
          endcase
      S8: case (A)
            1: nextstate = S9;
            3: nextstate = S10_0;
            5: nextstate = S10_1;
            8: nextstate = S10_2;
            default: nextstate = S11;
          endcase
      default: nextstate = state;
    endcase
  end

  // sequential
  always_ff @(posedge CLK, posedge RST) begin
    if (RST) state <= S0;
    else state <= nextstate;
  end

  assign isNotEnd = (state == S0 | state == S1 | state == S2 | state == S3 | state == S8);
  assign userWins = (state == S9);
  assign s = state;

endmodule