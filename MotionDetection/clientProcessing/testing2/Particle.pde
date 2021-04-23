class Particle {
 
  float x;
  float y;
  
  float velX; // speed or velocity
  float velY;
  
  
  Particle (float xGiven, float yGiven) {
   //x and y position to be in middle of screen
   x = xGiven;
   y = yGiven;
    x = width/2;
    y = height/2;
    
    velX = random (-10,10);
    velY = random (-10,10);
    
   
  }
  
  void update () {
    
    pushMatrix();
    x+=velX;
    y+=velY;
    
    fill (255);
    ellipse (x,y,10,10);
    popMatrix();
  }
}
