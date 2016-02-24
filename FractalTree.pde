private double fractionLength = .8; 
private int smallestBranch = 1; 
private double branchAngle = .4;  
Colors c;

public void setup() {   
	size(640,480);
	c = new Colors(true);    
	// noLoop(); 
} 
public void draw() { 
	c.run();
	background(c.getDifferentColor());     
	stroke(c.getColor());   
	line(320,480,320,380);   
	drawBranches(320,380,100,3*Math.PI/2);
} 
public void drawBranches(int x,int y, double branchLength, double angle) {   
	double angle1 = angle + branchAngle;
	double angle2 = angle - branchAngle;
	branchLength*=fractionLength;
	int endX1 = (int)(branchLength*Math.cos(angle1) + x);
	int endY1 = (int)(branchLength*Math.sin(angle1) + y);
	int endX2 = (int)(branchLength*Math.cos(angle2) + x);
	int endY2 = (int)(branchLength*Math.sin(angle2) + y);
	strokeWeight(1.5);
	line(x,y,endX1,endY1);
	line(x,y,endX2, endY2);
	
	if(branchLength > smallestBranch){
		drawBranches(endX1,endY1,branchLength*fractionLength,angle1);
		drawBranches(endX2,endY2,branchLength*fractionLength,angle2);
	}
} 

class NiceColor {
  float x, y, w, val, rate;
  int max = 255;
  float minimum = .75;
  float maximum = 1.5;
  boolean r; //short for random
  
  boolean goBack = false;

  NiceColor(float x, float y, float w, float val, float rate) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.val= val;
    this.rate = rate;
  }

  NiceColor(float val, float rate, boolean r) {
    this.val = val;
    this.rate = rate;
    this.r = r;
  }

  void changeVal() {
    if (goBack) {
      val -= rate;
    } else {
      val += rate;
    }
  }

  float getVal() {
    return val;
  }

  void maxVal() {
    if (val >= max) {
      goBack = true;
      if (r)
        rate = random(minimum, maximum);
    } else if (val <= 0) {
      goBack = false;
      if (r)
        rate = random(minimum, maximum);
    }
  }

  void display() {
    rect(x, y, w, -val);
  }

  void run() { //changes color doesnt display graph
    changeVal();
    maxVal();
  }
}

class Colors {
  NiceColor[] rgb = new NiceColor[3];

  Colors(int startingVal, int startingRate, boolean r) {
    // rgb = {new NiceColor(startingVal, startingRate, random), new NiceColor(startingVal, startingRate, random), new NiceColor(startingVal, startingRate, random)}; //doesnt work?

    for (int i = 0; i < 3; i++) {
      rgb[i] = new NiceColor(startingVal, startingRate, r);
    }
  }

  Colors(boolean r) {
    for (int i = 0; i < 3; i++) {
      rgb[i] = new NiceColor((float)(Math.random()*256), 1.5, r);
    }
  }

  void run() {
    for (NiceColor c : rgb) {
      c.run();
    }
  }

  color getColor() {
    return color(rgb[0].getVal(), rgb[1].getVal(), rgb[2].getVal());
  }

  color getDifferentColor() {
    return color(rgb[1].getVal(), rgb[2].getVal(), rgb[0].getVal());
  }
}