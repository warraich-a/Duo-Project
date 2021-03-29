//import sound
import processing.sound.*;
SoundFile file;


// Creates a client that sends input to a server

import processing.net.*; 
Client myClient; 
int clicks;
int dataIn;
String inString;
String[] emotion;
String[] emotionScore;

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
  file = new SoundFile(this, "sound.wav");
  file.play();
  //change volume; number between 1 and 0.0
  file.amp(0.25);
} 

void draw() { 
  myClient.write("Connection is stable");
  if (myClient.available() > 0) { 
    background(0); 
    noFill();
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
    emotion = inString.split("q")[0].split(" ");
    //float x = Float.parseFloat(emotion);


    // to assign the correct values to for 4 ends of the square
    for (int i=0; i<emotion.length; i++) {

      // to remove the space from the beginning of the numbers 
      String firstValue =emotion[i].substring(0);
      if (i == 0)
      {
        // to convert the first value to Float.
        x = Float.parseFloat(firstValue);
        System.out.println(x);
      } else if (i == 1)
      {
        // to convert the second value to Float.
        String secondValue =emotion[i].substring(0);
        y = Float.parseFloat(secondValue);
        System.out.println(y);
      } else if (i == 2)
      {
        // to convert the second value to Float.
        String thirdValue =emotion[i].substring(0);
        w = Float.parseFloat(thirdValue);
        System.out.println(w);
      } else if (i == 3)
      {
        // to convert the second value to Float.
        String fouthValue =emotion[i].substring(0);
        h = Float.parseFloat(fouthValue);
        System.out.println(h);
      }
      // to draw the rectangle
      stroke(0, 0, 255);
      rect(x, y, w, h);
    }

    //for (int i=0; i<emotion.length; i++){
    //String x =emotion[i].substring(1);
    //String x0 = x.replaceAll(",","");
    //Float first = Float.parseFloat(x0);
    //  if(i == 0)
    //  {
    //   System.out.println(first);
    //  }else if(i == 1)
    //  {
    // String x1 =emotion[i].substring(0);
    // x1 = emotion[i].replaceAll(",","");
    //  Float second = Float.parseFloat(x1);
    // System.out.println(second);
    //  }else if(i == 2)
    //  {
    //  String x2 =emotion[i].substring(0);
    //  x2 = emotion[i].replaceAll(",","");
    //  Float second = Float.parseFloat(x2);
    // System.out.println(second);
    //  System.out.println(x2);
    //  }else if(i == 3)
    //  {
    //   String xEnd =emotion[i].substring(0);
    //  String x3 = xEnd.replaceAll(",","");
    //   System.out.println(x3);
    //  }
    //for(String str : emotion){
    //      //test = str;
    //      //test = test.trim();
    //      //score = Integer.parseInt(s);
    //      //x = Float.parseFloat(str);
    //      String x = str.substring(1);
    //    //  String[] splitter = x.split(",");
    //    //   for(String s : splitter){

    //    //    System.out.print(s);

    //    //}
    //      System.out.println(x);
    //      //System.out.print(Float.parseFloat(str));
    //  }
    //rect(emotion);
    //emotionScore = inString.split(":")[1].split(" ");
  }
} 
