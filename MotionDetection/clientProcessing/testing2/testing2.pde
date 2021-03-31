//<>// //<>//


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

Float x = 0.0;
Float y= 0.0;
Float w= 0.0;
Float h= 0.0;

void setup() { 
  // Connect to the local machine at port 10002.
  // This example will not run if you haven't
  // previously started a server on this port.
  myClient = new Client(this, "127.0.0.1", 5204); 
  // Say hello
  myClient.write("Hello There");
  size(800, 800);


  // Load a soundfile from the /data folder of the sketch and play it back
 // file = new SoundFile(this, "D1.wav");
  //file.play();
  //change volume; number between 1 and 0.0
  //file.amp(0.25);
} 

void getEmotionColor(String emotionName) {
  if (emotionName.contains("happy")) {
    emotionColor = color(250, 255, 10);
  } else if (emotionName.contains("sad")) {
    emotionColor = color(2, 165, 250);
  } else if (emotionName.contains("neutral")) {
    emotionColor = color(255, 255, 255);
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
          String score =emotion[i].substring(0);
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

        translate(x, y);
        for (int b =0; b<branches; b++) {

          // rotate(TWO_PI/branches);
          pushMatrix(); //remember origin in center + 1 rotation

          //draw the leaves of the branch
          for (int f=1; f<=leaves; f++) {
            float distance = -30*(sin(radians(a)));
            float size = 20*(cos(radians(a))+1);

            translate(f*distance, 0);
            rotate(radians(90/leaves));
            fill(emotionColor, 128*f/leaves);
            rect(0, 0, w*size, y*size);
          }

          popMatrix(); //restore origin in center + 1 rotation
        }
      }
    }
    a++;
    t+=0.3;
    // if a greater than 359 -. a = 0
    a %= 359;
    t %= 359;
  } 
