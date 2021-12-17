import java.util.Arrays;
import java.util.ArrayList;
float growth = 5;
ArrayList<Circle> circles = new ArrayList<Circle>();
float counter = 0.0;
float INC = 0.001;
PVector v1, CENTER;

void setup() {
  fullScreen();
  background(100);
  
  // Turn is our initial reference vector that we later use to grow the curve
   v1 = new PVector(10, 0);
   v1.normalize();
  // Center reference vector
   CENTER = new PVector(width / 2, height / 2);
}
void draw() {
  // Use a counter system so frameCount stuff doesn't get weird later
  counter += INC;
  if (counter == 1 || counter == 0){
    INC *= -1;
  }
  
  background(255);
  // Modulate how for spaced out lines are for a little zoom-in, zoom-out fun
  growth = map(sin(frameCount * 0.003), -1, 1, 4, 7);
  
  // Copy the reference turn vector
  PVector t = v1.copy();
  // Empty the circles array
  circles.clear();
  
  // Loop through and add control points
  for (int i = 0; i < 100; i++){
    // Add our current turn vector to the center to get a point radiating out from the middle
    PVector c = PVector.add(CENTER, t);
    // Store that point as circles[i][x, y]
   Circle cir = new Circle(c.x, c.y);
    circles.add(cir);
    // Increase the magnitute of our turn by the GROWTH amount
    t.setMag(t.mag() + growth);
    // Rotate our turn by the COUNTER amount (use very tiny amounts or things get trippy real quick)
    t.rotate(growth);
  }
  
  // Loop through our control points and draw curves
  for (int i = 0; i < circles.size() - 4; i++){
    // Have the lines near the middle be slightly thicker
    strokeWeight(map(i, 0, circles.size() - 4, 2, 0.25));
    // Alternate between two colors. 
    if (i % 2 == 0){
      stroke(0);
      fill(205, 46, 58, 75);
    } else{
      stroke(0);
      fill(0, 71, 160, 75);
    }
    // Use each series of 4 points to draw a curve.
    curve(circles.get(i).x, circles.get(i).y, circles.get(i+1).x, circles.get(i+1).y, circles.get(i+2).x, circles.get(i+2).y, circles.get(i+3).x, circles.get(i+3).y);
    if(i >= circles.size() - 2)
      break;
  }  
}
class Circle{
  public float x,y;

  public Circle(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
}
