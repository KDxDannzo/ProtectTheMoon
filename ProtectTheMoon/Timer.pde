class Timer {
  
  float timeX,timeY;
  float speedY;
  
  Timer(float locationX, float locationY, float setSpeed) {
    this.timeX=locationX;
    this.timeY=locationY;
    this.speedY=setSpeed;
  }
  
  
  void render() {
    stroke(0);
    fill(255,0,0);
    rect(timeX, timeY, 10, height);
  }
  
  void move() {
    timeY=timeY + speedY;
  }
  
  void update() {
    render();
    move();
  }
  
}
