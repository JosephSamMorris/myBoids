






Flock flock;

//bulb grid size
int bulbGridX=10;
int bulbGridY=18;

//muondetectorgrid;
int muonGridX=5;
int muonGridY=6;

int boidTriggerZone;
int flockSize;

float positionX;
float positionY;

float [] bulbLocX = new float[bulbGridX];
float [] bulbLocY = new float[bulbGridY];



int bulbCount = 181;
Bulb[] bulbs = new Bulb[bulbCount];

boolean [] lastBulbs = new boolean[bulbCount];
long []  bulbsPrevTime = new long[bulbCount];

int marginX=width/10;
int marginY=height/10;
int ellipseScale;

boolean drawFlock;
boolean showBulbNum;

void settings() {

  //only adjust xWidth to change the size of the sketch
  int xWidth = 400;

  flockSize = 6;                  //the number of birds-boids
  boidTriggerZone = xWidth/20;    //how far the boid needs to be to affect a light
  drawFlock = true;              //show the flock in the sketch
  showBulbNum = false;            //show the number attached to each bulb

  float _yWidth = xWidth*1.8;     //maintains proper aspect ratio
  int yWidth = int(_yWidth);
  ellipseScale = xWidth/25;       //overall size of circles

  size(xWidth, yWidth);
}

void setup() {

  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < flockSize; i++) {
    flock.addBoid(new Boid(60, 60));
  }

  // initialize the bulbs class
  for (int i = 1; i < bulbCount; i ++) {
    bulbs[i] = new Bulb(i, 0, 0, 255);
    bulbsPrevTime[i] = 0;
  }
}


void draw() {

  background(180);

  flock.run();
  drawGrid();
  drawBulb();

  for (int i=1; i<bulbCount; i++) {
    bulbs[i].draw();
  }

  if (showBulbNum) showNums();
}

///////////////////////////


void showNums() {
  if (showBulbNum == true) {
    for (int i = 1; i < bulbCount; i ++) {
      fill(255);
      textAlign(LEFT, BOTTOM);
      text(i, bulbs[i].xPos - width/50, bulbs[i].yPos - width/50);
    }
  }
}

void drawGrid() {


  marginX=width/10;
  marginY=height/10;
  int offsetMarginX = marginX + width/25;
  int offsetMarginY = marginY + height/35;

  //draw bulb wire lines and bulbs
  for (int i=0; i<bulbGridY; i++) {
    int h = offsetMarginY + i *(height - offsetMarginY*2)/(bulbGridY-1);
    stroke(0);
    line(0, h, width, h);
    for (int j=0; j<bulbGridX; j++) {
      float b = offsetMarginX + j * (width - offsetMarginX*2)/(bulbGridX-1);
      bulbLocX[j] = b;
      bulbLocY[i] = h;
    }
  }

  //draw geiger tube sections
  stroke(150);
  noFill();
  for (int i=0; i<muonGridY; i++) {
    for (int j=0; j<muonGridX; j++) {
      int w= (width-marginX*2)/muonGridX;
      int h= (height-marginY*2)/muonGridY;
      int rectX=marginX+j*w;
      int rectY=marginY+i*h;
      rect(rectX, rectY, w, h);
    }
  }
  stroke(100);
}


//a list of bulbs with attributes
class Bulb {
  int bulbID;
  float xPos;
  float yPos;
  int fill;
  int fadeCount = 100;
  boolean on;

  Bulb (int id, float x, float y, int f) {
    bulbID = id;
    xPos = x;
    yPos = y;
    //scale = s;
    fill = f;
  }

  void draw() {

    if (on == false) {  //reset the bulb
      fadeCount+=2;
      if (fadeCount>255)fadeCount=255;
      fill(fadeCount);
    } else {          //dim the bulb
      on=false;

      //println(bulbID + " " + millis() + " " +  bulbsPrevTime[bulbID]);
      //if ( millis() - bulbsPrevTime[bulbID] > 500) {
      fadeCount-=20;
      if (fadeCount<0)fadeCount=0;
      fill(fadeCount);
    }
    //}
    ellipse(xPos, yPos, ellipseScale, ellipseScale);
  }
}


//activates a bulb off if the boid comes near
void triggerBulbs(float xLoc, float yLoc) {

  for (int ID = 1; ID < bulbCount; ID ++) {
    if (xLoc > bulbs[ID].xPos - boidTriggerZone && xLoc < bulbs[ID].xPos + boidTriggerZone) {
      if (yLoc > bulbs[ID].yPos - boidTriggerZone && yLoc < bulbs[ID].yPos + boidTriggerZone) {
        bulbs[ID].on = true;

        //println(ID + " " + millis() + " " +  bulbsPrevTime[ID]);
        if ( millis() - bulbsPrevTime[ID] > 1000) {
          println(ID + " " + (millis() - bulbsPrevTime[ID]));
          bulbsPrevTime[ID] = millis();
        }
      }
    }
  }
}


// label and correlate the bulb ID to the grid
void drawBulb() {

  for (int ID = 1; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[0];
  }
  for (int ID = 2; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[1];
  }
  for (int ID = 3; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[2];
  }
  for (int ID = 4; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[3];
  }
  for (int ID = 5; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[4];
  }
  for (int ID = 6; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[5];
  }
  for (int ID = 7; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[6];
  }
  for (int ID = 8; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[7];
  }
  for (int ID = 9; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[8];
  }
  for (int ID = 10; ID < bulbCount; ID += 10) {
    bulbs[ID].xPos = bulbLocX[9];
  }

  for (int ID = 1; ID < bulbCount; ID ++) {

    if (ID <= 10) {
      bulbs[ID].yPos = bulbLocY[0];
    }

    if (ID >= 11 && ID <= 20) {
      bulbs[ID].yPos = bulbLocY[1];
      for (int i = 11; i < 21; i ++) {
        int loc = 20 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    }

    if (ID >= 21 && ID <= 30) {
      bulbs[ID].yPos = bulbLocY[2];
    } 

    if (ID >= 31 && ID <= 40) {
      bulbs[ID].yPos = bulbLocY[3];
      for (int i = 31; i < 41; i ++) {
        int loc = 40 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    } 

    if (ID >= 41 && ID <= 50) {
      bulbs[ID].yPos = bulbLocY[4];
    } 

    if (ID >= 51 && ID <= 60) {
      bulbs[ID].yPos = bulbLocY[5];
      for (int i = 41; i < 51; i ++) {
        int loc = 50 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    } 

    if (ID >= 61 && ID <= 70) {
      bulbs[ID].yPos = bulbLocY[6];
    } 

    if (ID >= 71 && ID <= 80) {
      bulbs[ID].yPos = bulbLocY[7];
      for (int i = 71; i < 81; i ++) {
        int loc = 80 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    }

    if (ID >= 81 && ID <= 90) {
      bulbs[ID].yPos = bulbLocY[8];
    } 

    if (ID >= 91 && ID <= 100) {
      bulbs[ID].yPos = bulbLocY[9];
      for (int i = 91; i < 101; i ++) {
        int loc = 100 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    }

    if (ID >= 101 && ID <= 110) {
      bulbs[ID].yPos = bulbLocY[10];
    } 

    if (ID >= 111 && ID <= 120) {
      bulbs[ID].yPos = bulbLocY[11];
      for (int i = 111; i < 121; i ++) {
        int loc = 120 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    } 

    if (ID >= 121 && ID <= 130) {
      bulbs[ID].yPos = bulbLocY[12];
    } 

    if (ID >= 131 && ID <= 140) {
      bulbs[ID].yPos = bulbLocY[13];
      for (int i = 131; i < 141; i ++) {
        int loc = 140 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    } 

    if (ID >= 141 && ID <= 150) {
      bulbs[ID].yPos = bulbLocY[14];
    } 

    if (ID >= 151 && ID <= 160) {
      bulbs[ID].yPos = bulbLocY[15];
      for (int i = 151; i < 161; i ++) {
        int loc = 160 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    } 

    if (ID >= 161 && ID <= 170) {
      bulbs[ID].yPos = bulbLocY[16];
    } 

    if (ID >= 171) {
      bulbs[ID].yPos = bulbLocY[17];
      for (int i = 171; i < 181; i ++) {
        int loc = 180 - i;
        bulbs[i].xPos = bulbLocX[loc];
      }
    }
  }
}
