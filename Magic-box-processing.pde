

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;



import processing.opengl.*; 
import processing.video.*;
import processing.serial.*;

Minim minim;
AudioPlayer player;
Serial arduino; 

PImage img1, img2, img3, img4, img5, img6;
float x, y, z,puls;
float ant=1;
float tecla;


final int VIEW_SIZE_X = 1300, VIEW_SIZE_Y = 650; //1680x1050 , 1280x800

void setup() 
{
  size(VIEW_SIZE_X, VIEW_SIZE_Y, P3D);  
  println(arduino.list());
   minim = new Minim(this);
  arduino = new Serial(this, Serial.list()[0], 115200); // second COM port (COM9)
  arduino.bufferUntil('\n');
  player = minim.loadFile("MC.mp3");
  player.play();
  
  img1 = loadImage("museo-alberto-mena-caamano-7.jpg"); // front
  img2 = loadImage("url.jpg");
  img3 = loadImage("museo-alberto-mena-caamano-3.jpg");
  img4 = loadImage("Museo_Alberto_Mena_Caamaño_(Eugenio_y_Manuela_Espejo).JPG"); // left img4 - originally
  img5 = loadImage("museo-alberto-mena-caamano-8.jpg");
  img6 = loadImage("museo.jpg"); // back img6 - originally
  
  
  delay(100);
}

void draw() {
  background(0);            
  readQ();
  printAxis();
  camera(0,0,0,0,0,1,0,1,0); 
 beginCamera();
   // rotation using sensor information
   rotateZ(-x); 
   rotateX(y);
   rotateY(-z);
   int center = 600;
   pushMatrix();
    translate(0,0,center);
    image(img1,-img1.width/2,-img1.height/2); // front image
    translate(0,0,400);
    //image(myMovie,-myMovie.width/2,-myMovie.height/2); // ,myMovie.width,myMovie.height
   popMatrix();
   
   pushMatrix();
    translate(0,0,-center);
    image(img6,-img6.width/2,-img6.height/2); // back image
   popMatrix();
   
   pushMatrix();
    translate(0,center,0);
    rotateX(radians(90));
    rotateZ(radians(180));
    image(img2,-img2.width/2,-img2.height/2); // bottom image
   popMatrix();
   
   pushMatrix();
    translate(0,-center,0);
    rotateX(radians(90));
    image(img3,-img3.width/2,-img3.height/2); // up image
   popMatrix();
   
   pushMatrix();
    translate(center,0,0);
    rotateY(radians(90));
    image(img4,-img4.width/2,-img4.height/2); // left image
   popMatrix();
   
   pushMatrix();
    translate(-center,0,0);
    rotateY(radians(90));
    image(img5,-img5.width/2,-img5.height/2); // right image
   popMatrix();
  // walls();
 endCamera();

}

void readQ() {
  if(arduino.available() >= 10) {
    String inputString = arduino.readStringUntil('\n');
    if (inputString != null && inputString.length() > 0) {
      String [] inputStringArr = split(inputString, ",");
      if(inputStringArr.length >= 4) { 
        x=float(inputStringArr[0]);
        y=float(inputStringArr[1]);
        z=float(inputStringArr[2]);
        puls=float(inputStringArr[3]);
        if(ant==0)
        {
          tecla=1;
        }
        if(ant==1)
        {
         tecla=0; 
        }
        if(tecla==1)
        {
        player.pause();
        }
        if(tecla==0)
        {
         player.play(); 
        }
         ant=puls;
      }
    }
  }
  arduino.clear();
} 

void printAxis() {
  print(x); print("\t");
  print(y); print("\t");
  print(z); print("\t");
  print(puls); print("\t");
  println();
}
