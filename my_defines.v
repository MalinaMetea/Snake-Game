`ifndef my_defines 
`define my_defines
`define TOTAL_HORIZONTAL_PIXELS    800
`define TOTAL_VERTICAL_PIXELS      525
`define ACTIVE_HORIZONTAL_PIXELS   640
`define ACTIVE_VERTICAL_PIXELS     480
`define COUNT_H_SIZE               10
`define COUNT_V_SIZE               10
`define FRONT_PORCH_H              16
`define BACK_PORCH_H               48
`define FRONT_PORCH_V              10
`define BACK_PORCH_V               33
`define APPLE_POS_SIZE             10
`define APPLE_COUNTER_SIZE         9
`define APPLE_SQUARE_SIZE          20
`define INITIAL_APPLE_POSITION_X   150
`define INITIAL_APPLE_POSITION_Y   150
`define APPLE_POS_LIMIT_LEFT       60
`define APPLE_POS_LIMIT_RIGHT      570
`define APPLE_POS_LIMIT_UP         60
`define APPLE_POS_LIMIT_DOWN       370


`define SNAKE_POS_SIZE             10
`define SNAKE_SQUARE_SIZE          20
`define SNAKE_LENGTH_SIZE          9
`define MAX_SNAKE_LENGTH           (1<<`SNAKE_LENGTH_SIZE)
`define LENGTH_INCREASE            10
`define INITIAL_SNAKE_HEAD_POS_X   320
`define INITIAL_SNAKE_HEAD_POS_Y   240
`define SPEED                      1
`define SCORE_DIGIT_SIZE           4
`define BORDER_UP_POSITION         50 
`define BORDER_DOWN_POSITION       461 
`define BORDER_LEFT_POSITION       20  
`define BORDER_RIGHT_POSITION      621  
`define DIRECTION_SIZE             4
`define DIRECTION_UP               3
`define DIRECTION_DOWN             0
`define DIRECTION_LEFT             2
`define DIRECTION_RIGHT            1
`define RAND_X_INCREMENT           20
`define RAND_Y_INCREMENT           10
`define RAND_X_INIT              (`BORDER_LEFT_POSITION + 50)
`define RAND_Y_INIT              (`BORDER_UP_POSITION + 40)
`endif