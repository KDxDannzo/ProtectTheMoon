class Moon {
  float moonX;
  float moonY;
  
  float moonD;
  
  Moon() {
    this.moonX=50;
    this.moonY=height/2-30;
    this.moonD=80;
  }
  
  
  void render() {
    strokeWeight(2);
    stroke(98,96,95);
    fill(165,162,160);
    moon();
    }
  
  void moon() {
    //Moon
    ellipse(moonX, moonY, moonD, moonD);
    fill(36,33,32);
    //Crater 1
    ellipse(90, moonY+40,   15,15);
    //Crater 2
    ellipse(80, moonY+10,   15, 15);
    //Crater 3
    ellipse( 55, moonY+20,  15, 15);
  }
  
  void update() {
    render();
  }
  
}
