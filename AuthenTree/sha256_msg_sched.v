module sha256_msg_sched (
    input  wire         clk_i,
    input  wire         rst_n,
    input  wire [511:0] msg_block,
    input  wire [5:0]   round_idx,
    input  wire         start,
    input  wire         advance,
    output wire [31:0]  word_out
);

  //-------------------------------------------------------------------------
  // Internal storage for the 16-word sliding window
  //-------------------------------------------------------------------------
  reg [31:0] mem_words [0:15];
  reg [31:0] new_word0,  new_word1,  new_word2,  new_word3;
  reg [31:0] new_word4,  new_word5,  new_word6,  new_word7;
  reg [31:0] new_word8,  new_word9,  new_word10, new_word11;
  reg [31:0] new_word12, new_word13, new_word14, new_word15;
  reg        write_enable;

  //-------------------------------------------------------------------------
  // Output register and next-word computation
  //-------------------------------------------------------------------------
  reg [31:0] word_reg;
  reg [31:0] msg_new;

  assign word_out = word_reg;

  //-------------------------------------------------------------------------
  // Synchronous memory update
  //-------------------------------------------------------------------------
  always @(posedge clk_i or negedge rst_n) begin
    integer i;
    if (!rst_n) begin
      for (i = 0; i < 16; i = i + 1)
        mem_words[i] <= 32'b0;
    end else if (write_enable) begin
      mem_words[ 0] <= new_word0;
      mem_words[ 1] <= new_word1;
      mem_words[ 2] <= new_word2;
      mem_words[ 3] <= new_word3;
      mem_words[ 4] <= new_word4;
      mem_words[ 5] <= new_word5;
      mem_words[ 6] <= new_word6;
      mem_words[ 7] <= new_word7;
      mem_words[ 8] <= new_word8;
      mem_words[ 9] <= new_word9;
      mem_words[10] <= new_word10;
      mem_words[11] <= new_word11;
      mem_words[12] <= new_word12;
      mem_words[13] <= new_word13;
      mem_words[14] <= new_word14;
      mem_words[15] <= new_word15;
    end
  end

  //-------------------------------------------------------------------------
  // Read-selection: either from initial window or the newly computed word
  //-------------------------------------------------------------------------
  always @* begin
    if (round_idx < 16)
      word_reg = mem_words[round_idx];
    else
      word_reg = msg_new;
  end

  //-------------------------------------------------------------------------
  // Message-schedule logic: σ0, σ1, and word rotation
  //-------------------------------------------------------------------------
  always @* begin
    reg [31:0] w0, w1, w9, w14;
    reg [31:0] s0, s1;

    // Default: clear all next-word registers and disable write
    { new_word0,  new_word1,  new_word2,  new_word3,
      new_word4,  new_word5,  new_word6,  new_word7,
      new_word8,  new_word9,  new_word10, new_word11,
      new_word12, new_word13, new_word14, new_word15 } = {16{32'b0}};
    write_enable = 1'b0;

    // Fetch taps for σ0 and σ1
    w0  = mem_words[0];
    w1  = mem_words[1];
    w9  = mem_words[9];
    w14 = mem_words[14];

    // σ0(x) = ROTR7(x) ^ ROTR18(x) ^ SHR3(x)
    s0 = {w1[6:0],  w1[31:7]}  ^
         {w1[17:0], w1[31:18]} ^
         (w1 >> 3);

    // σ1(x) = ROTR17(x) ^ ROTR19(x) ^ SHR10(x)
    s1 = {w14[16:0],  w14[31:17]} ^
         {w14[18:0],  w14[31:19]} ^
         (w14 >> 10);

    // Compute the new word
    msg_new = s1 + w9 + s0 + w0;

    // On initialization, load the first 16 words from the input block
    if (start) begin
      new_word0  = msg_block[511:480];
      new_word1  = msg_block[479:448];
      new_word2  = msg_block[447:416];
      new_word3  = msg_block[415:384];
      new_word4  = msg_block[383:352];
      new_word5  = msg_block[351:320];
      new_word6  = msg_block[319:288];
      new_word7  = msg_block[287:256];
      new_word8  = msg_block[255:224];
      new_word9  = msg_block[223:192];
      new_word10 = msg_block[191:160];
      new_word11 = msg_block[159:128];
      new_word12 = msg_block[127:96];
      new_word13 = msg_block[95:64];
      new_word14 = msg_block[63:32];
      new_word15 = msg_block[31:0];
      write_enable = 1'b1;
    end
    // After the first 16 rounds, shift the window and append the new word
    else if (advance && (round_idx > 15)) begin
      new_word0  = mem_words[1];
      new_word1  = mem_words[2];
      new_word2  = mem_words[3];
      new_word3  = mem_words[4];
      new_word4  = mem_words[5];
      new_word5  = mem_words[6];
      new_word6  = mem_words[7];
      new_word7  = mem_words[8];
      new_word8  = mem_words[9];
      new_word9  = mem_words[10];
      new_word10 = mem_words[11];
      new_word11 = mem_words[12];
      new_word12 = mem_words[13];
      new_word13 = mem_words[14];
      new_word14 = mem_words[15];
      new_word15 = msg_new;
      write_enable = 1'b1;
    end
  end

endmodule
