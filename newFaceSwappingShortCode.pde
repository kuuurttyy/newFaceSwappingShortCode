import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
//create image to store mask
PImage mask;

//scaled down image
PImage smaller;
int scale = 2;

void setup() {
  //run fill size of the screen
  size(displayWidth, displayHeight);
  frameRate(20);
  video = new Capture(this, width, height);
  opencv = new OpenCV(this, video.width/scale, video.height/scale);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  //make scaled down image for openCV to track
  smaller = createImage(opencv.width, opencv.height, RGB);
}

void draw() {
  //load mask image
  mask = loadImage("mask12.jpg");

  //load smaller image into OpenCV for tracking, better framerate
  opencv.loadImage(smaller);
  //display video feed

  //display video
  image(video, 0, 0 );

  //Array to store faces
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  //draw rectangle around seen faces
  //NOT BEING USED
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    //style face rectangle
    noFill();
    stroke(0, 255, 0);
    noStroke();
    strokeWeight(3);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  } 

  //empty array to store captured faces for swapping
  PImage[] captured = new PImage[faces.length];

  //fill the array with the faces
  for (int i = 0; i < faces.length; i++) {
    captured[i] = get(faces[i].x*scale, faces[i].y*scale, faces[i].width*scale, faces[i].height*scale);
  }

  //swap over the faces
  for (int s = 0; s < captured.length-1; s++) {
    captured[s].resize(faces[s+1].width*scale, faces[s+1].height*scale);

    mask.resize(faces[s+1].width*scale, faces[s+1].height*scale);
    captured[s].mask(mask);

    image(captured[s], faces[s+1].x*scale, faces[s+1].y*scale);
  }

  //swap the last detected face with the first detected face
  if (captured.length >= 2) {
    int c = captured.length-1;
    captured[c].resize(faces[0].width*scale, faces[0].height*scale);

    mask.resize(faces[0].width*scale, faces[0].height*scale);
    captured[c].mask(mask);

    image(captured[c], faces[0].x*scale, faces[0].y*scale);
  }

  //used to save the frame while holding the spacebar
  if (keyPressed) {
    if (key == ' ') {
      saveFrame("#####.jpg");
    }
  }
} // close draw


void captureEvent(Capture c) {
  c.read();

  // Make smaller image
  smaller.copy(video, 0, 0, video.width, video.height, 0, 0, smaller.width, smaller.height);
  smaller.updatePixels();
}

