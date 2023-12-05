class Wall {
  
  float wallX;
  float wallY;
  
  float speedX;
  
  float wallW;
  float wallH;
  
  int score=0;
  
  Wall() {
//Start position of the Enemy; 'wall'.
    this.wallX=width-50;
    this.wallY=80;
//Random, higher speed range == enemy wall object appearing more times instead
//of a constant speed.
    this.speedX=random(10,12);
    this.wallW=70;
    this.wallH=250;
    this.score=0;
  }
  
  void render() {
    strokeWeight(5);
    stroke(57,255,20);
    fill(0,0,255);
    rect(wallX, wallY,  wallW,wallH);
  }
  
  void move() {
    textSize(20);
    text("Score: " + score, 10,20);
    wallX=wallX-speedX;
//Enemy object repeating itself, moving from right to left once it
//reaches the 'start'- 0.
    if (wallX+30<0) {
      wallX=width;
//Enemy wall appearing at random Y-locations.
      wallY=random(height)-250/2;
//When the player goes past an enemy wall object - increase the score by 1.
      score=score+1;
    }
  }
  
  void update() {
    render();
    move();
  }
}
