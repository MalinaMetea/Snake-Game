module split_digits(
    input [`SNAKE_LENGTH_SIZE-1:0] snake_length, 
    output reg [`SCORE_DIGIT_SIZE-1:0] hundreds, 
    output reg [`SCORE_DIGIT_SIZE-1:0] tens, 
    output reg [`SCORE_DIGIT_SIZE-1:0] ones  );
integer i;
always @ (snake_length)
begin
    hundreds=0;
    tens=0;
    ones=0;
    for(i=(`SNAKE_LENGTH_SIZE-1); i>=0 ; i=i-1)
    begin
        if(hundreds >=5) hundreds=hundreds+3;
        if(tens>=5) tens=tens+3;
        if(ones>=5) ones=ones+3;
        hundreds = hundreds<<1;
        hundreds[0] = tens[3];
        tens = tens<<1;
        tens[0] = ones[3];
        ones = ones<<1;
        ones[0] = snake_length[i];
    end
end 
endmodule