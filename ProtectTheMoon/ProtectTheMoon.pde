//Enables the use of different gameStates within the game.
String gameState;

//Loading scrolling background image.
PImage skyBackground;
int bgX=0;

//Winner screen.
PImage winner;

//startGame Background
PImage startG;

//gameInstructions Background
PImage gameI;

Player player1;
Wall enemy1;
Moon goal;

//Time remaining will be dispalyed as red lines on the left and right side of the screen.
Timer timerL;
Timer timerR;

//List to store all the dragon objects.
ArrayList<Dragon> dragonList;

void setup() {
  size(1200,600);
  resetGame();
  startGame();
}

void draw() {
  background(255,255,255);
//Different gameStates.
  if (gameState == "START") {
    startGame();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN") {
    winGame();
  } else if (gameState == "LOSE") {
    loseGame();
  }   
}

void startGame() {
  background(startG);
  textAlign(CENTER);
  textSize(35);
  fill(0,188,255);
  text("PROTECT THE MOON!", width/2, height/2-180);
  textSize(20);
  fill(0,188,255);
  text("GOOD LUCK!\nClick the 'p' key To Play!", width/2, height/2-100);
  textAlign(LEFT);
  textSize(15);
  text("Press the space bar key to read the game instructions", 865,20);
//When the 'p' key is pressed, change gameState.
  if (keyCode == 'P' == true) {
    gameState = "PLAY";
  }
  if (keyCode==' ' == true) {
    gameInstructions();
  }
} 

void playGame() {
//Game logic.
  skyBackground();
  player1.update();
  enemy1.update();
  goal.update();
  timerL.update();
  timerR.update();
  
  for (int i=0; i<dragonList.size(); i++) {
    Dragon drgn = dragonList.get(i);
    drgn.update();
//Collision detected, reset the ArrayList.
  if (drgn.collidesWithGoal(goal.moonX, goal.moonY, goal.moonD) || (drgn.collidesWithPlayer(player1.playerX, player1.playerY, player1.d))) {
      gameState = "LOSE";
      dragonList = new ArrayList<Dragon>();
      break;
    }
  }

//If the player collides with the wall, the player will lose.
  if (circleRect(player1, player1, player1,  enemy1, enemy1, enemy1, enemy1) == true) {
    gameState = "LOSE";
  }

//If the player remains alive until the timer reaches the bottom of the screen, whilst successfully defending the moon, the player
//will win the game.
  if (timerL.timeY >= height) //As the timers decrease at the same speed, only one of them will need this code.
  {
    gameState = "WIN";
  }
}

void winGame() {
  background(winner);
  textAlign(CENTER);
  textSize(30);
  fill(0,247,255);
  text("Well done! \nYou surived the enemies!", 200, 100);
  textSize(19);
  text("You surived with a score of: " + enemy1.score + 
  "\nNow lets see if you have what it takes to beat it...", 1000,100);
  textSize(15);
  text("Press the 'R' key to play again", 1000,200);
  if (keyCode == 'R' == true) {
    resetGame();
  }
}

void loseGame() {
  background(0);
  fill(255,0,0);
  textSize(24);
  text("GAME OVER", width/2, height/2);
  textSize(12);
  textSize(20);
  text("Your score was: " + enemy1.score, width/2,height/2+60);
  text("Press the 'z' key to play again", width/2, height/2+90);
  if (keyCode == 'Z' == true) {
    resetGame();
  }
}

void resetGame() {
//Code initialised here so that when it is called in void setup,
//EVERYTHING will be reset without any issues or bugs.

  skyBackground = loadImage("Space.png");
  skyBackground.resize(width, height);
  skyBackground();
  winner = loadImage("winnerBackground.png");
  startG = loadImage("moonBackground.png");
  gameI = loadImage("Earth.png");
  
  dragonList = new ArrayList<Dragon>();
  
//Adding dragons to the ArrayList.
  dragonList.add(new Dragon(random(1000,1190), random(100,500)));
  dragonList.add(new Dragon(random(1000,1190), random(100,500)));
  dragonList.add(new Dragon(random(1000,1190), random(100,500)));
  dragonList.add(new Dragon(random(1000,1190), random(100,500)));

  player1 = new Player();
  enemy1 = new Wall();
  goal = new Moon();
  timerL = new Timer(0,0,  0.33); // 0.33 is the speed which the timer will decrease at (~30 seconds).
                                 // This timer can be altered to increase or decrease the difficulty of obtaining a higher score in less or more time. 
  timerR = new Timer(width-10, 0,  0.33);

  gameState = "START";
}

void skyBackground() {
//Scrolling / moving skyBackground.
  image(skyBackground, bgX, 0);
  image(skyBackground, bgX+skyBackground.width, 0);
  bgX -=4;
  if (bgX == -skyBackground.width) {
    bgX=0;
  }
}

void gameInstructions() {
  background(gameI);
  textAlign(CENTER);
  fill(0,255,102);
  textSize(50);
  text("Game Instructions: ", width/2, height/2-110);
  textSize(15);
  text("1. Use the 'w' & 's' keys to move the player up and down, respectively.\n2. You have 30 seconds to survive until the timer runs out whilst avoiding the enemy objects to win the game.\nIf you crash, collide with an enemy object, or allow the dragon to reach the moon; you lose.\n Subsequently, if you hit the top or bottom of the screen, you lose.\n Everytime you avoid an enemy wall object, your score will increase by 1.\n Everytime you double click (the mouse) on a dragon object, your score will increase by 10.", width/2, height/2-80);
  textSize(15);
  text("Tip: When double clicking the dragon object, try to double click slightly ahead of the dragon you are attempting to get rid of.", width/2, 25);
  textAlign(LEFT);
  textSize(14);
  text("Press the '1' key to return back to the 'Start Game' mode", 860,590);
  if (keyCode== '1' == true) {
    gameState= "START";
  }
}


//This is the logic for the Player-enmy1 (wall) collision detction.
boolean circleRect(Player cx, Player cy, Player radius, Wall rx, Wall ry, Wall rw, Wall rh) {

//Temporary variables to set edges for testing.
  float testX = cx.playerX;
  float testY = cy.playerY;

//Which edge is closest?
  if (cx.playerX < rx.wallX)         testX = rx.wallX;      //Test left edge.
  else if (cx.playerX > rx.wallX+rw.wallW) testX = rx.wallX+rw.wallW;   //Right edge.
  if (cy.playerY < ry.wallY)         testY = ry.wallY;      //Top edge.
  else if (cy.playerY > ry.wallY+rh.wallH) testY = ry.wallY+rh.wallH;   //Bottom edge.

//Get distance from closest edges.
  float distX = cx.playerX-testX;
  float distY = cy.playerY-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

//If the distance is less than the radius, collision!
  if (distance <= radius.d) {
    return true;
  }
  return false;
}

void mouseClicked() {
//Check if any of the dragon objects is clicked.
  for (int d=0; d<dragonList.size(); d++) {
    if (dragonList.get(d).isClicked(mouseX, mouseY)) {
//Remove the object if it is clicked, spawn another random dragon in
//& increase the score by 10.
      enemy1.score= enemy1.score+10;
      dragonList.remove(d);
      dragonList.add(new Dragon(random(1000,1190), random(100,500)));
//Decrement the index to check the next object.
      d--;
    }
  }
}
