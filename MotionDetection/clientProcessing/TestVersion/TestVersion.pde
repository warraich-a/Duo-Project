   //<>// //<>// //<>// //<>//
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

float easing = 0.05;

float p = 0;
float xt = 300, yt = 300;
float xs = 100, ys = 100;
float speed = .01;
float xc, yc;
    
void setup() { 
  // Connect to the local machine at port 10002.
  // This example will not run if you haven't
  // previously started a server on this port.
  
  myClient = new Client(this, "127.0.0.1", 5204); 
  // Say hello
  myClient.write("Hello There");
  size(800,800,P2D);
  frameRate(60);
   background(0);
} 

 void getEmotionColor(String emotionName){
    if (emotionName.contains("happy")){
      background(0);
           emotionColor = color(255, 0, 0);
            translate(x, y);
            float val = randomGaussian();
          
            float sd = 10;                  // Define a standard deviation
            float mean = y;           // Define a mean value (middle of the screen along the x-axis)
            x = ( val * sd ) + mean;  // Scale the gaussian random number by standard deviation and mean
          
            noStroke();
            fill(emotionColor);
            ellipse(x, y, w/2, h/2);   // Draw an ellipse at our "normal" random location
         } else if (emotionName.contains("sad")){
           emotionColor = color(0, 255, 0);
         } else if (emotionName.contains("neutral")){
           background(0);
           emotionColor = color(155, 255, 255);
           translate(x, y);
            float val = randomGaussian();
          
            float sd = 5;                  // Define a standard deviation
            float mean = y;           // Define a mean value (middle of the screen along the x-axis)
            x = ( val * sd ) + mean;  // Scale the gaussian random number by standard deviation and mean
          
            noStroke();
            fill(emotionColor);
            ellipse(x, y, w/2, h/2);   // Draw an ellipse at our "normal" random location
         } else if (emotionName.contains("surprise")){
           emotionColor = color(0, 255, 155);
         } else if (emotionName.contains("disgust")){
           emotionColor = color(155, 155, 155);
         } else if (emotionName.contains("angry")){
           emotionColor = color(255, 255, 255);
         } else if (emotionName.contains("fear")){
           emotionColor = color(155, 155, 155);
         }
     }
void draw() { 
  
   myClient.write("Connection is stable");
   //println(frameCount);
 if (myClient.available() > 0) { 
     //<>//
    //noFill();
    noStroke();
    inString = myClient.readString(); 
    
    // to remove the first few characters until bracket e.g. €X(191, 112, 243, 243)q.
    inString = inString.substring(7);
    // to remove all the brakets
     inString= inString.replaceAll("\\p{P}","");
     // ro remove all the commas
     inString = inString.replaceAll(",","");
    println(inString);
    
// to remove the q from the list.
   faceLocation = inString.split("q")[0].split(" ");
   emotion = inString.split("q")[1].split(" ");
   

int pCounter = 0;
int cCounter =  0;
// to assign the correct values to for 4 ends of the square
for (int i=0; i<faceLocation.length; i++){
pCounter++;

// to remove the space from the beginning of the numbers 
    String firstValue =faceLocation[i].substring(0);
      if(i == 0)
      {
      cCounter = pCounter;
      String emotionName =emotion[i].substring(0);
      
      // to remove spaces 
      emotionName  = emotionName.replaceAll("\\s","");
      // method to change the colors according to the emotions.
      getEmotionColor(emotionName);
              
      System.out.println(emotionColor);
        // to convert the first value to Float.
       x = Float.parseFloat(firstValue);
        float dx =  x;
        x += dx * easing;
        

       System.out.println(x);
      }
      else if(i == 1)
      {
        String score =emotion[i].substring(0);
        System.out.println(score);
         // to convert the second value to Float.
        String secondValue =faceLocation[i].substring(0);
        y = Float.parseFloat(secondValue);
        float dy = y;
        y += dy * easing;
        System.out.println(y);
      }
      else if(i == 2)
      {
        //shapeSketch0();
        // to convert the second value to Float.
        String thirdValue =faceLocation[i].substring(0);
        w = Float.parseFloat(thirdValue);
        System.out.println(w);
      }
      else if(i == 3)
      { //<>//
        // to convert the second value to Float.
        String fouthValue =faceLocation[i].substring(0);
        h = Float.parseFloat(fouthValue);
        System.out.println(h);
      }

      // to draw the rectangle
      //fill(emotionColor);
      //rect(x, y, w, h);
      //if(p<1) p += speed; //<>//
    
    
   }
   
  }
} 


//void shapeSketch0() {
//  background(191, 33, 33);
//  stroke(52, 11, 11);
//  line(117.0, 75.0, 224.0, 308.0);
//  line(299.0, 91.0, 86.0, 279.0);
//  line(74.0, 125.0, 328.0, 268.0);
//  line(192.0, 86.0, 156.0, 309.0);
//  ellipse(183.5, 63.5, 41.0, 41.0);
//  ellipse(300.0, 66.0, 46.0, 46.0);
//  ellipse(340.0, 257.0, 0.0, 0.0);
//  ellipse(360.0, 275.0, 52.0, 52.0);
//  ellipse(260.5, 340.5, 53.0, 53.0);
//  ellipse(257.5, 333.5, 11.0, 11.0);
//  ellipse(151.0, 339.0, 46.0, 46.0);
//  ellipse(68.0, 289.0, 34.0, 34.0);
//  ellipse(55.5, 109.5, 41.0, 41.0);
//  ellipse(106.0, 63.0, 34.0, 34.0);
//  ellipse(183.0, 198.5, 72.0, 61.0);
//  rect(354.0, 123.0, 105.0, 102.0);
//  rect(24.0, 157.0, 78.0, 90.0);
//}
