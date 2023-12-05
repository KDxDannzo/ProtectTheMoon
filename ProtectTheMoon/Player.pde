class Player {
//Player X and Y location and speed, as well as the diameter.
  float playerX;
  float playerY;
  
  float speedY;
  float speedX;
  
  float d;
  
  Player() {
    this.playerX=200;
    this.playerY=50;
    this.speedX=2;
    this.speedY=5;
    this.d=30;
  }
  
  void render() { 
  ellipseMode(RIGHT);
  strokeWeight(2);
  stroke(0);
  fill(57,255,20);
  ellipse(playerX,playerY,  d,d);
  }
  
  void move() {
    if (keyPressed && key=='w')
    {
      playerY=playerY-speedY;
    } else {
      if (keyPressed && key=='s')
    {
      playerY=playerY+speedY;
    }
  }
      
//This prevents the ball from going off the screen.
//If player collides with top or bottom of the screen, the player will lose.
    if (playerY<=0 || playerY>=height) {
      gameState = "LOSE";
    }
    
//Keeping the speed at a constant / limiting number - the speed will not decrease
//or increase less/more than -6 or 6, respectively.
    if (speedY<-6) {
      speedY=-6;
    } else if (speedY>6) {
      speedY=6;
    }
}

  void update() {
    render();
    move();
  }
}
