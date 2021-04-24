class Drop {
  float x; // x postion of drop
  float y; // y position of drop
  float z; // z position of drop , determines whether the drop is far or near
  float len; // length of the drop
  float yspeed; // speed of te drop

  //near means closer to the screen , ie the higher the z value ,closer the drop is to the screen.
  Drop() {

    x  = random(width); // random x position ie width because anywhere along the width of screen
    y  = random(height); // random y position, negative values because drop first begins off screen to give a realistic effect
    z  = random(0, 20); // z value is to give a perspective view , farther and nearer drops effect
    len = map(z, 0, 20, 10, 20); // if z is near then  drop is longer
    yspeed  = map(z, 0, 20, 1, 20); // if z is near drop is faster
  }
  Drop(Float xGiven, Float yGiven, float w, Float h, color col) {
    followMyFace(xGiven, yGiven, w, h, col);
  }


  void fall() { // function  to determine the speed and shape of the drop 
    y = y + yspeed; // increment y position to give the effect of falling 
    float grav = map(z, 0, 20, 0, 0.2); // if z is near then gravity on drop is more
    yspeed = yspeed + grav; // speed increases as gravity acts on the drop

    if (y > height) { // repositions the drop after it has 'disappeared' from screen
      y = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 10);
    }
  }

  void show(color col) { // function to render the drop onto the screen
    float thick = map(z, 0, 20, 1, 3); //if z is near , drop is more thicker 
    strokeWeight(thick); // weight of the drop
    stroke(col); // purple color
    line(x, y, x, y+len); // draws the line with two points
  }
  void followMyFace(float xGiven, float yGiven, float w, float h, color col) {
    pushMatrix();
    translate(xGiven, yGiven);
    xGiven  = random(w); // random x position ie width because anywhere along the width of screen
    yGiven  = random(h); 
    z  = random(0, 10); 
    len = map(z, 0, 10, 7, 15); // if z is near then  drop is longer
    
    
    yGiven = yGiven + yspeed; // increment y position to give the effect of falling 
    float grav = map(z, 0, 20, 0, 0.2); // if z is near then gravity on drop is more
    yspeed = yspeed + grav; // speed increases as gravity acts on the drop

    if (yGiven > w) { // repositions the drop after it has 'disappeared' from screen
      yGiven = random(-200, -100);
      yspeed = map(z, 0, 20, 4, 10);
    }

    float thick = map(z, 0, h, 1, 3); //if z is near , drop is more thicker 
    strokeWeight(thick); // weight of the drop
    stroke(col+1); // purple color
    line(xGiven, yGiven, xGiven, yGiven+len); // draws the line with two points 
    popMatrix();
  }
}
