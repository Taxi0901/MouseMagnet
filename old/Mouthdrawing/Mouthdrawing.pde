
//animation loop
//adobe flash ---> animate
//unity(C#), unreal engine(C++) //void update(){}

PVector centrePt;

PVector targetPt;

PVector velocity;

float easing;

float maxSpeed;

float minR; //min radius
float maxR; //max radius

color pink;
color green;

float alpha;

void setup(){ 
 size(640, 400);
 background(255);
 //frameRate(60);
 
 centrePt = new PVector(0.5*width, 0.5*height);
 //centrePt = new PVector();
 //centrePt.x = 0.5*width;  //.x 
 //centrePt.y = 0.5*height;
 
 targetPt = new PVector(0, 0); //new PVector();
 velocity = new PVector(0, 0); //new PVector();
 
 maxSpeed = dist(0, 0, width*1.0, height*1.0);
 
 easing = 0.05;
 
 minR = 1.0;
 maxR = 5000.0;
 
 alpha = 150;
 
 pink = color(255, 0, 128, alpha);
 green = color(153, 255, 0, alpha);
 
 
 
 //centrePt = new PVector();
 //centrePt.x = 0.5*width;  //.x 
 //centrePt.y = 0.5*height;
}

//frame buffer
void draw(){
  //println(frameCount);
  //println(frameRate);
  
  //background(255);
  //ellipse(mouseX, mouseY, 100, 100);
  
  targetPt.x = mouseX;
  targetPt.y = mouseY;
  
  velocity = PVector.sub(targetPt, centrePt);
  velocity.mult(easing);//easing//mult
  
  float speed = velocity.mag();
  
  centrePt.add(velocity); //centrePt = centrePt.add(velocity)
  
  float radius = map(speed, 0, maxSpeed, minR, maxR);
  
  float colorRate = map(speed, 0, maxSpeed*0.02, 0, 1);

  color c = lerpColor(green, pink, colorRate);

  float alphaRate = 1 - colorRate;
  
  c = color(red(c), green(c), blue(c), alpha * alphaRate);

  
  
  
  fill(c);
  stroke(220, 150);
  //float radius = 50;
  strokeWeight(2);
  ellipse(centrePt.x, centrePt.y, 2*radius, 2*radius);
  
}
