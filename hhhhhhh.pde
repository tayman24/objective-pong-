
// Global Variables
int section;
int ballX, ballY;
int ballStartX, ballStartY;
int ballDiameter;
int ballMoveX = 1, ballMoveY = 1;
int score1 = 0;
int score2 = 0;
int numberX;
int numberY;
int paddleWidthRatio;
int paddleHeightRatio = 10;
int [] paddle = {0, 0}; //Paddle width and height
int [] player = new int [4];

void setup() {
  size(500, 600);
  ballDiameter = width/70; 
  paddleWidthRatio = ballDiameter/2;
  paddle[0] = paddleWidthRatio; 
  paddle[1] = height/paddleHeightRatio; 

  player[1] = height/2 - height/paddleHeightRatio/2; //middle minus half the paddle to find the paddle's center
  int section = width / paddleWidthRatio; // Local Variable: calculate the divisions of the paddle and draw in the last one
  player[2] = width*(section-1)/section; // *(paddlewidthRatio-1)/paddlewidthRatio
  player[3] = height/2;
  ballStartX = width/2;
  ballStartY = height/2;
  ballX = ballStartX;
  ballY = ballStartY;
  //ballDiameter = width/70; //must pick one dimension for both ellipse diameters, for a circle
  score1 =0;
  score2=0;
}

void draw() {
  background(#E1FF99); //whiteish yllow

  //Calcualting "next" ball position
  //Section necessary when calling functions so passing current arguements
  ballX += ballMoveX; //origonally x+1 operation
  ballY += ballMoveY; //origonally x+1 operation

  //Ball Movement within Pong Table
  if (ballX == paddle[0] && ballY >= player[1] & ballY <= player[1] + paddle[1]) {
    ballMoveX *= (-1); //Shorthand for previous x*-1
  }
//Ball Movement within Pong Table
  if (ballX == player[2] && ballY >= player[3] & ballY <= player[3] + paddle[1]) {
    ballMoveX *= (-1); //Shorthand for previous x*-1
  }
  if (ballY == height || ballY == 0) {
    ballMoveY = ballMoveY * (-1);
  }
  if (ballX == 0) {
    score2 +=1;
    println ("player1:"+score1 + ":" + "player2:" + score2);
  }
  if (ballX == width) {
    score1 +=1;
    println ("player1:"+score1 + ":" + "player2:" + score2);
  }
  //Printing Ball
  fill(0); //Black
  ellipse(ballX, ballY, ballDiameter, ballDiameter);

  //Debugging Ball Position
  if (score1 == 10) {
    println("GAME OVER"+ " PLAYER ONE WINS");
    exit();
  }
  if (score2 == 10) {
    println("GAME OVER"+ " PLAYER TWO WINS");
    exit();
  }
  if (ballX == width || ballX == 0) {
    ballX = width/2;
    ballY = height/2;
    numberX = int (random (-2, 2));
    while (numberX ==0) {
      numberX = int (random (-2, 2));
    }
    numberY = int (random (-2, 2));
    while (numberY ==0) {
      numberY = int (random (-2, 2));
    }
    ballMoveX= ballMoveX * (numberX);
    ballMoveY= ballMoveY * (numberY);
  }

  if (keyPressed == true & key == CODED) { //alternate is void keyPressed(){}, always contains the most recent keyboard key stroke
    if (keyCode == UP) { //KeyCode is used for UP, DOWN, LEFT, and RIGHT; and ALT, CONTROL, and SHIFT
      if (player[1] >= 5) { //Easier to use && instead of nesting IF Statements
        player[1] -= 5; //Review incrementation other than -1
      }
      if (player[1] < 0) { //Catch any subtraction equalling less than zero
        player[1] = 0;
      }
    }

    if (keyCode == DOWN) {
      if (player[1] + paddle[1] <= height) {
        player[1] += 5; //Review incrementation other than +1
      }
      if (player[1] + paddle[1] > height) {
        player[1] = height - paddle[1] - 1; //Cannot add "player[1] + paddle[1]" in an assignment; thus, algebra needed
        //Note: the "-1" shows the black border of the paddle at the bottom, which looks more aesthetic
        //Note: the height is actaully -1 pixel because of the border
      }
    }
  } //End of keyPressed

  //Player 2 Movement
  player[3] = ballY - paddle[1]/2;
  if (player[3] <= 0) {
    player[3] = 0;
  }
  if (player[3] >= height - paddle[1]) {
    player[3] = height - paddle[1] - 1;
  }
  //if (mouseY >=0 || mouseY - paddle[1] < height) {
  //  player[3] = mouseY;
  //}
  //if (mouseY >= height - paddle[1]) {
  //  player[3] = height - paddle[1] - 1;
  //}
  //println (mouseY);

  //Drawing Paddles
  fill(#FF00FF); //Purple
  rect(player[0], player[1], paddle[0], paddle[1]);
  rect(player[2], player[3], paddle[0], paddle[1]);
  fill(0); //Reseting to Black
}
