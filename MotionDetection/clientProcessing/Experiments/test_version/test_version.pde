//<>// //<>// //<>//


//int xPos = width;
//int yPos = height;

//import sound
import processing.sound.*;
SoundFile file;   

//inner circle
float circle1 = 150;
//size outer circles
float circle2 = 200 + width + height;
float circle3 = 300;
float circle4 = 400+width+height;



float angnoise, radiusnoise;
float xnoise, ynoise;
float angle = -PI/2;
float radius; 


// Creates a client that sends input to a server

import processing.net.*; 
Client myClient; 
int clicks;
int dataIn;
String inString;
String[] faceLocation;
String[] emotion;
color emotionColor;
int score;

Float x = 0.0;
Float y= 0.0;
Float w= 0.0;
Float h= 0.0;


int howMany = 100;// 100?
//here you make a empty array of type Sample
//One array to rule them all :)
//Fear[] fears  = new Fear[howMany];


void setup() { 

  fullScreen();
  //size(800, 800);
  //size(1920, 1080);


  // Connect to the local machine at port 10002.
  // This example will not run if you haven't
  // previously started a server on this port.
  myClient = new Client(this, "127.0.0.1", 5204); 
  // Say hello
  myClient.write("Hello There");


  background(0);



  //Load a soundfile from the /data folder of the sketch and play it back
  //file = new SoundFile(this, "D1.wav");
  //file.play();
  //change volume; number between 1 and 0.0
  // file.amp(0.05);
} 

void getEmotionColor(String emotionName) {
  if (emotionName.contains("happy")) {
    background(0);
    //in the middle of the screen
    translate(width/2+x, height/2+y);
    float scaleVar = map(width, 0, height, 0.5, 5);
    scale(scaleVar);


    circle2 = score;
    noStroke();

    fill(#FFC915);

    //translate(x, y);

    //ang1 shows how close and how many lines/dots circle
    for (float ang1 = 0; ang1 < 360; ang1 += 8) {
      float radian1 = radians(ang1);
      pushMatrix();
      translate(circle1 * cos(radian1), circle1 * sin(radian1));


      //ang2 how close the dots are to eachother (ex. 1 is a line, 10 are small dots)
      for (float ang2 = 0; ang2 < 90; ang2 += 1) {
        //frameCount is speed of animation
        float radian2 = radians(ang2) - frameCount * 0.15 + radian1;
        //draw the circle(ellipse) because of the small circles from radian2 and width of circle2
        ellipse(circle2 * cos(radian2), circle2 * sin(radian2), 2, 2);
      }
      popMatrix();
    }

    for (float ang2 = 0; ang2 < 360; ang2 += 12) {
      float radian4 = radians(ang2);
      pushMatrix();
      translate(circle1 * cos(radian4), circle1 * sin(radian4));
      //ang2 how close the dots are to eachother (ex. 1 is a line, 10 are small dots)
      for (float ang3 = 0; ang3 < 360; ang3 += 10) {
        //frameCount is speed of animation
        float radian3 = radians(ang3) - frameCount * 0.1 + radian4+width;
        //draw the circle(ellipse) because of the small circles from radian2 and width of circle2
        ellipse(circle2 * cos(radian3), circle2 * sin(radian3), 2, 2);
      }
      popMatrix();
    }
    //for (float ang2 = 0; ang2 < 360; ang2 += 3) {
    //  float radian5 = radians(ang2);
    //  pushMatrix();
    //  translate(circle3 * cos(radian5), circle3 * sin(radian5));
    //  //ang2 how close the dots are to eachother (ex. 1 is a line, 10 are small dots)
    //  for (float ang3 = 0; ang3 < 360; ang3 += 5) {
    //    //frameCount is speed of animation
    //    float radian3 = radians(ang3) - frameCount * 0.1 + radian5;
    //    //draw the circle(ellipse) because of the small circles from radian2 and width of circle2
    //    ellipse(circle4+width * cos(radian3), circle4+height * sin(radian3), 2, 2);
    //  }
    //  popMatrix();
    //}
  } else if (emotionName.contains("sad")) {
    emotionColor = color(2, 165, 250);
    background(0);
  } else if (emotionName.contains("neutral")) {
    background(0);
    emotionColor = color(155, 255, 255);

    translate(width/50+x, height/2+y);


    String s = "DO YOU DARE TO SHOW YOUR TRUE COLOURS?";
    fill(emotionColor);
    text(s, 0, 0);

    textSize(height/15);
  } else if (emotionName.contains("surprise")) {
    emotionColor = color(0, 255, 0);
    background(0);
  } else if (emotionName.contains("angry")) {
    emotionColor = color(250, 0, 0);
    translate(x, y);
    //if(!background(0){
    //background(0);
    //}
    //else(background(0)){

    //angnoise = random(10);
    ////radiusnoise = random(10);
    //xnoise = random(20);
    //ynoise = random(20);

    angnoise = 10;
    //radiusnoise = random(10);
    xnoise = 800;
    ynoise = 800;


    //stroke(255,0,0);

    //line(random(800), random(800),400,400);
    // pushMatrix();
    for (int i = 0; i < score; i++) {

      // length of connection line change by varying the radius
      radiusnoise += 5;
      // radiusnoise += 1000;
      // radiusnoise += 0.5;
      //radius = (noise(radiusnoise) * 550) +1;
      //if 550 is replaced with the width and +1 with height, the lines fill the entire screen
      radius = (noise(radiusnoise) * width) +height;

      //vary density of the line packing. Allow angle to increase or decrease -> reverse rotation
      angnoise += 0.01;
      // angnoise += 0.005;

      //angle += (noise(angnoise) * 6) - 3;
      angle += (noise(angnoise) * 200) - 1;
      if (angle > 360) { 
        angle -= 360;
      }
      if (angle < 0) { 
        angle += 360;
      }

      //wobble center circle slightly; move plus or minus 10 pixels in x or y
      xnoise += 0.01;
      ynoise += 0.01;

      //width -> x ; height ->y; 
      float centerX = width/2 + (noise(xnoise) * 100) -50;
      float centerY = height/2 + (noise(ynoise) * 100) -50;

      float rad = radians(angle);
      float x1 = centerX + (radius * cos(rad));
      float y1 = centerY + (radius * sin(rad));

      float rad2 = rad + PI;
      float x2 = centerX + (radius * cos(rad2));
      float y2 = centerY + (radius * sin(rad2));

      //stroke(250, 0, 0, 20);
      stroke(250, 0, 0, 60);
      strokeWeight(3); 
      line(x1, y1, x2, y2);
    }
    // popMatrix();
  }
}






void draw() { 
  myClient.write("Connection is stable");
  if (myClient.available() > 0) { 
    //background(0); 
    //noFill();
    stroke(200);
    inString = myClient.readString(); 

    // to remove the first few characters until bracket e.g. ???X(191, 112, 243, 243)q.
    inString = inString.substring(7);
    // to remove all the brakets
    inString= inString.replaceAll("\\p{P}", "");
    // ro remove all the commas
    inString = inString.replaceAll(",", "");
    println(inString);

    // to remove the q from the list.
    faceLocation = inString.split("q")[0].split(" ");
    emotion = inString.split("q")[1].split(" ");


    // to assign the correct values to for 4 ends of the square
    for (int i=0; i<faceLocation.length; i++) {

      // to remove the space from the beginning of the numbers 
      String firstValue =faceLocation[i].substring(0);
      if (i == 0)
      {

        String emotionName =emotion[i].substring(0);

        // to remove spaces 
        emotionName  = emotionName.replaceAll("\\s", "");
        // method to change the colors according to the emotions.
        getEmotionColor(emotionName);

        System.out.println(emotionColor);
        // to convert the first value to Float.
        x = Float.parseFloat(firstValue);
        System.out.println(x);
      } else if (i == 1)
      {
        // to remove the 0 from the begining of the value e.g. 089 should be 89
        String scoreV =emotion[i].substring(0);
        //scoreV = scoreV;
        score = Integer.parseInt(scoreV);
        System.out.println(score);
        // to convert the second value to Float.
        String secondValue =faceLocation[i].substring(0);
        y = Float.parseFloat(secondValue);
        System.out.println(y);
      } else if (i == 2)
      {

        // to convert the second value to Float.
        String thirdValue =faceLocation[i].substring(0);
        w = Float.parseFloat(thirdValue);
        System.out.println(w);
      } else if (i == 3)
      {
        // to convert the second value to Float.
        String fouthValue =faceLocation[i].substring(0);
        h = Float.parseFloat(fouthValue);
        System.out.println(h);
      }
      // to draw the rectangle
      //  fill(emotionColor);
      //  rect(x, y, w, h);
    }
  }
}

//class Fear {

//  //class vars
//  float xv, yv, xsp, ysp;

//  // a constructor
//  Fear(float _xv, float _yv, float _xsp, float _ysp) {
//    xv  = _xv;
//    yv  = _yv;
//    xsp = _xsp;
//    ysp = _ysp;
//  }

//  void display() {
//    ellipse(xv, yv, 50, 50);
//  }
//}
