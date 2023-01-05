
int numCircles;

float minR;
float maxR;
float deltaR;

float maxDistance;

boolean printValueOn;

boolean mouseClickedOn;

void setup(){
  size(800, 600);
  
  numCircles = 8;
  
  maxR = 200;
  minR = maxR / numCircles;
  
  deltaR = (maxR - minR)/ (numCircles - 1);
  
  maxDistance = dist(0, 0, width, height);
  
  mouseClickedOn = false;
  
  printValueOn = false; 
}

void draw(){
  background(255);
  
  float cx = width * 0.5;
  float cy = height * 0.5;
  PVector c = new PVector(cx, cy);
  
  for(int k = 0; k < numCircles; k++){
    
    float r = maxR - k * deltaR;
    
    if(mouseClickedOn){
      
      PVector mc = new PVector(c.x - mouseX, c.y - mouseY);
      
      float distance = mc.mag();
      
      mc.normalize();
      
      float displacement = map(distance, 0, 0.5*maxDistance, 0.5*maxR, 0);
      //float displacement = map(distance, 0, 1.0*maxDistance, 0.5*maxR, 0);
      //float displacement = map(distance, 0, 0.5*maxDistance, 5.0*maxR, 0);
      //if(displacement < 0) displacement = 0;
      
      if(printValueOn){
        println("k : " + k + " , displacement : " +displacement);
      }
      c.add(mc.mult(displacement));
      //c.x += mc.mult(displacement).x; 
      //c.y += mc.mult(displacement).y;
    }
    
    ellipse(c.x, c.y, 2*r, 2*r);
  }
}

void mouseClicked(){
  mouseClickedOn = !mouseClickedOn;
}

void keyPressed(){
  if(key == 'p'){
    printValueOn = !printValueOn;
  }
}
