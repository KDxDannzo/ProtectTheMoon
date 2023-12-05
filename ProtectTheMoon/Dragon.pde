class Dragon {
  float dragonX;
  float dragonY;
  
  float speedDX;
  
  float dragonW;
  float dragonH;
    
//Deciding which image to render.
  int imgCounter;
  
//Creating an array of PImages to store 3 PImage objects.
  PImage[] imgs = new PImage[3];
  
  Dragon(float randomX, float randomY) {
    this.dragonX=randomX;
    this.dragonY=randomY;
    
    this.speedDX=8;
    
    this.dragonW=75;
    this.dragonH=52;
        
    for(int i=0; i<imgs.length; i++)
    {
      imgs[i] = loadImage("dragon" + (i+1) + ".png");
    }
  }
  
  void move() { 
    dragonX=dragonX-speedDX;
//If dragon goes off screen, reset the x to the width.
    if (dragonX+30 < 0-imgs[0].width) {
      dragonX = width;
      dragonY=random(height)-250/2;
    }
  }
  
  void render() {
    if (imgCounter < 10) {
      image(imgs[0], dragonX, dragonY, dragonW, dragonH);
    } else if (imgCounter < 20) {
      image(imgs[1], dragonX, dragonY, dragonW, dragonH);
    } else if (imgCounter < 30) {
      image(imgs[2], dragonX, dragonY, dragonW, dragonH);
    } else {
      image(imgs[2], dragonX, dragonY, dragonW, dragonH);
      imgCounter=0;
    }
    imgCounter++;
  }
  
  void update() {
    move();
    render();
  }
    
//Method to check if the dragon is clicked
  boolean isClicked(float mx, float my) {
    return (mx >= dragonX && mx <= dragonX + dragonW && my >= dragonY
    && my <= dragonY + dragonH);
  }   
  
//Method to check for a collision with the player.
  boolean collidesWithPlayer(float playerX, float playerY, float d) {
//Calculate the distance between the center of the dragon and the center of the player.
    float distance = dist(this.dragonX, this.dragonY, player1.playerX, player1.playerY);
//Check if the distance is smaller than the sum of the sizes of the dragon and the player.
    if (distance <= this.dragonW-60 + player1.d || distance <= this.dragonH-60 + player1.d) {
      return true;
    }
    return false;
  }
  
//Method to check for a collision with the moon.
  boolean collidesWithGoal(float moonX, float moonY, float moonD) {
//Calculate the distance between the center of the dragon and the center of the moon.
    float distance = dist(this.dragonX, this.dragonY, goal.moonX, goal.moonY);
//Check if the distance is smaller than the sum of the sizes of the dragon and the moon.
    if (distance < this.dragonW + goal.moonD-80 || distance < this.dragonH + goal.moonD-80) {
      return true;
    }
    return false;
  }
}
