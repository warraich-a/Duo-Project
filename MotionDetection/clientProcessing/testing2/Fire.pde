class Fire {
  float x;
  float y;
  float vx;
  float vy;
  color col;
  float lifetime = 1000;

  Fire(float x, float y, float vx, float vy, color col) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.col = col;
  }

  void draw() {
    if (lifetime-50>0) {
      noStroke();
      fill(col, lifetime-300);
      ellipse(x, y, 4, 4);
      lifetime -= 0.9;
    }
  } 

  void update() {
    vy += G;
    x += vx;
    y += vy;
  }
}
