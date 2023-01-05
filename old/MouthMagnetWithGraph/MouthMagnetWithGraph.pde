
int numCircles;

float minR;
float maxR;
float deltaR;

float maxDistance;

boolean printValueOn;

boolean mouseClickedOn;

//drawingCanvas
float drawingCanvasWidth, drawingCanvasHeight;

//graph Canvas
float graphCanvasWidth, graphCanvasHeight;

//max distance between points in the drawing canvas, 
//which is diagonal.
//
float maxDistanceInDrawingCanvas;

void setup(){
  //size(800, 600);
  size(800, 1200);
  
  //drawingCanvas
  drawingCanvasWidth = width;
  drawingCanvasHeight = 0.5 * height;

  graphCanvasWidth = width;
  graphCanvasHeight = height - drawingCanvasHeight;
    
  numCircles = 8;
  
  maxR = 200;
  minR = maxR / numCircles;
  
  deltaR = (maxR - minR)/ (numCircles - 1);
  
  //maxDistance = dist(0, 0, width, height);
  
  maxDistanceInDrawingCanvas = dist(0, 0, drawingCanvasWidth, drawingCanvasHeight);
  
  mouseClickedOn = false;
  
  printValueOn = false; 
}

void draw(){
  background(255);
  
  //float cx = width * 0.5;
  //float cy = height * 0.5;
  float cx = drawingCanvasWidth * 0.5;
  float cy = drawingCanvasHeight * 0.5;
  PVector c = new PVector(cx, cy);
  
  for(int k = 0; k < numCircles; k++){
    
    float r = maxR - k * deltaR;
    
    if(mouseClickedOn){
      
      PVector mc = new PVector(c.x - mouseX, c.y - mouseY);
      
      float distance = mc.mag();
      
      mc.normalize();
      
      //float displacement = map(distance, 0, 0.5*maxDistance, 0.5*maxR, 0);
      //float displacement = map(distance, 0, 1.0*maxDistance, 0.5*maxR, 0);
      //float displacement = map(distance, 0, 0.5*maxDistance, 5.0*maxR, 0);
      //if(displacement < 0) displacement = 0;
      
      float minDistance = 0;
      float maxDisplacement = 0.5 * maxR;
      
      float maxDistance = 0.5 * maxDistanceInDrawingCanvas;
      float minDisplacement = 0;
      
      
      float displacement 
      = getLinearInterpolatedValue
        (distance, minDistance, maxDistance, maxDisplacement, minDisplacement);

      
      if(printValueOn){
        println("k : " + k + " , displacement : " +displacement);
      }
      c.add(mc.mult(displacement));
      //c.x += mc.mult(displacement).x; 
      //c.y += mc.mult(displacement).y;
      
      //draw the interpolation graph
      displayInterpolationGraph(minDistance, maxDisplacement, maxDistance, minDisplacement);
      
    }
    
    //draw the circle
    stroke(10);
    strokeWeight(0.8);
    fill(255);
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

void displayInterpolationGraph
     (float x0, float y0, float x1, float y1){
       
  
  float ox = graphCanvasWidth  * 0.1;
  float oy = drawingCanvasHeight + 0.5 * graphCanvasHeight;
  
  //debug
  fill(10);
  ellipse(ox, oy, 20, 20);
  
  displayAxesAndMinMaxPts(ox, oy, x0, y0, x1, y1);
}

//draw x and y axis and 2pts on the linear line
/* 
   y
   ^
   |
   |
   |
 y0|   *p0
   |    \
   |     \
 y1|      *p1
------------------------>x
   |   x0 x1
   |

*/

void displayAxesAndMinMaxPts
     (float ox, float oy, float x0, float y0, float x1, float y1){


}



float getLinearInterpolatedValue(float x,
        float x0, float x1, float y0, float y1) {//cal, ...
  //answer
  float y;
  
  if(x1 != x0){
    y = (y1 - y0)/(x1 - x0) * (x - x0) + y0;
    return y;
  } else {
    //cannot decide. y unknown
    y = -10000; //for error check
    return y;
  }
}


       
