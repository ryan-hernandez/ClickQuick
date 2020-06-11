import java.util.Map;

int startTime = 0;
int time = 0;
int n = 1;
float avg = 0.0;
float tot = 0.0;
float x = 0.0;
float y = 0.0;
float wh = 0.0;
boolean started = false;

void setup() {
  size(500, 500);
}

void mousePressed() { 
  // If the game hasn't been started yet, let the first click
  // start it and set the necessary values.
  if (!started) {
    started = true;
    
    startTime = millis();
    
    x = random(100, 400);
    y = random(100, 400);
    wh = random(15, 40);
  }
  
  // To find out if the click is inside of the circle, we first
  // find the distance from the users click to the center of the
  // circle. If the distance from the click to the center is less
  // than the radius of the circle, the click is within the circle.
  float dist = dist(mouseX, mouseY, x, y);
  
  if (dist <= wh / 2) {
    calculateAvg(); // Calculate average click time
    
    startTime = millis(); // Refresh startTime
    x = random(100, 400); // Generate new random x value
    y = random(100, 400); // Generate new random y value
    wh = random(15, 40);  // Generate new circle diameter
  } 
}

void draw() {
  background(0);
  
  if (!started) {
    clickToStart();
  } else {
    title();
    timer();
    numClicks();
    avgTime();
    drawCircle(x, y, wh);
  }
}

void clickToStart() {
  textSize(60);
  textAlign(CENTER, CENTER);
  text("CLICK TO START", 250, 250);
}

void title() {
  textSize(40);
  textAlign(CENTER, 35);
  text("Click the Circles", 250, 35);
}

void timer() {
  time = millis() - startTime;
  int timeSeconds = time / 1000;
  int timeMillis = time % 1000;
  textSize(14);
  text("Time to click: " + timeSeconds + "." + nf(timeMillis, 3, 0), 75, 490);
}

void numClicks() {
  textSize(14);
  textAlign(CENTER, 490);
  text("Number of clicks: " + (n - 1), 225, 490);
}

void avgTime() {
  textSize(14);
  text("Average click time: " + nf(avg, 0, 3), 400, 490);
}

void calculateAvg() {
  float currTime = millis() - startTime;
  float clickTime = currTime / 1000;
  tot += clickTime;
  avg = tot / n;
  n++;
}

void drawCircle(float _x, float _y, float _wh) {
  ellipse(_x, _y, _wh, _wh);
}
