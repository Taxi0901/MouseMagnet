

int numX, numY; //グリッドの数
float offsetX, offsetY; //余白
float gridX, gridY;

int numCircles;

float minR;
float maxR;
float deltaR;

float maxDistance;

boolean printValueOn;

boolean mouseClickedOn;

void setup(){
  size(800, 600);
  
  numX = 30;
  numY = 20;
  
  offsetX = 5;
  offsetY = 5;
  
  gridX = (width - 2 * offsetX) / (numX - 1);
  gridY = (height - 2 * offsetY) / (numY - 1);
  
  numCircles = 8;
  
  //maxR = 200;
  maxR = gridX * 0.5;
  minR = maxR / numCircles;
  
  deltaR = (maxR - minR)/ (numCircles - 1);
  
  maxDistance = dist(0, 0, width, height);
  
  mouseClickedOn = false;
  
  printValueOn = false; 
}

void draw(){
  background(255);
  

  //グリッドを作る。グリッドを何個作るか、グリッドのx, yの大きさ、余白を決める。Molnarの時と一緒。
  
  for(int i = 0; i < numX; i++){
    for(int j = 0; j < numY; j++){
        
        //center
        float cx = gridX * i + offsetX; //offset;余白
        float cy = gridY * j + offsetY;
        PVector c = new PVector(cx, cy);
  
      for(int k = 0; k < numCircles; k++){
        
        float r = maxR - k * deltaR;
        
        if(mouseClickedOn){
          
          //ズラス軸
          PVector mc = new PVector(c.x - mouseX, c.y - mouseY);
          
          float distance = mc.mag();
          
          mc.normalize();
          
          float rotAngle = map(distance, 0, maxDistance, 0, 1.2*PI);
          
          //軸の回転
          mc.rotate(rotAngle);
          
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
      }//k
     }//j
   }//i

     saveFrame("frames/20230105/####.png");

   if (frameCount >= 100) { // 100コマアニメーションした時
    exit();
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
