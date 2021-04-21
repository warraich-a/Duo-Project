//<>// //<>// //<>//


//import sound
import processing.sound.*;
SoundFile file;   

int leaves = 10;
int branches = 1;
int a = 0, t=0; 

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

// A "Wiggler" object
Wiggler wig;
Drop[] drops;
Drop[] faceDrops;
void setup() { 
  // Connect to the local machine at port 10002.
  // This example will not run if you haven't
  // previously started a server on this port.
  myClient = new Client(this, "127.0.0.1", 5204); 
  // Say hello
  myClient.write("Hello There");
  size(800, 800);
  //frameRate(30);

  //Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "D1.wav");
  file.play();
  //change volume; number between 1 and 0.0
  file.amp(0.05);
} 

void getEmotionColor(String emotionName) {
  if (emotionName.contains("happy")) {
    background(0);
    emotionColor = color(250, 255, 10);
    // to start the visuals from face location
    //surface.setLocation(0,0);
    //translate(0, 0);
    //float val = randomGaussian();

    //float sd = 5;             // Define a standard deviation
    //float mean = y;           // Define a mean value (middle of the screen along the x-axis)
    //x = ( val * sd ) + mean;  // Scale the gaussian random number by standard deviation and mean

    //noStroke();
    //  // to draw the methods accordingly the emotion score, e.g. if the score is 40 then it will draw 40 circles
    //  for (int i = 0; i < score; i++) {
    //  noStroke();
    //  fill(emotionColor, 50);
    //    // draw the ellipse
    //    ellipse(x, y, w, h);


    //  }
    //pushMatrix();/
    drops = new Drop[500];
    faceDrops = new Drop[score];
    for (int i = 0; i < drops.length; i++) 
    { // we create the drops 
      drops[i] = new Drop();
    }
    for (int j = 0; j < faceDrops.length; j++) 
    { // we create the drops 
      faceDrops[j] = new Drop(x, y, w, h, emotionColor);
    }

    for (int i = 0; i < drops.length; i++) {
      drops[i].fall(); // sets the shape and speed of drop
      drops[i].show(emotionColor); // render drop
    }
    //popMatrix();
  } else if (emotionName.contains("sad")) {
    emotionColor = color(2, 165, 250);
  } else if (emotionName.contains("neutral")) {
    background(0);
    emotionColor = color(155, 255, 255);
    translate(x, y);
    // wig = new Wiggler(x, y, 155);
    //wig.display();
    // wig.wiggle();
    //rect(x, y, w, h);
    ellipse(x, y, w, h);
    stroke(000); 


    fill(emotionColor);
    arc(x*2/2-30, y*2/2-40, 50, score, -PI, 0);  // upper half of circl
    arc(x*2/2+30, y*2/2-40, 50, score, -PI, 0);  // upper half of circl
    arc(x*2/2, y*2/2+30, 50, score, -PI, 0);  // upper half of circl
  } else if (emotionName.contains("surprise")) {
    emotionColor = color(0, 255, 0);
  } else if (emotionName.contains("disgust")) {
    emotionColor = color(208, 5, 255);
  } else if (emotionName.contains("angry")) {
    emotionColor = color(250, 0, 0);
  } else if (emotionName.contains("fear")) {
    emotionColor = color(41, 149, 101);
  }
}






void draw() { 
  myClient.write("Connection is stable");
  if (myClient.available() > 0) { 
    background(0); 
    //noFill();
    stroke(200);
    inString = myClient.readString(); 

    // to remove the first few characters until bracket e.g. €X(191, 112, 243, 243)q.
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
    } 
    //file.amp(1.0);
  }

  a++;
  t+=0.3;
  // if a greater than 359 -. a = 0
  a %= 359;
  t %= 359;
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
