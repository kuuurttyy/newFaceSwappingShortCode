import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

//PImages to store captured faces
PImage face0;
PImage face1;
PImage face2;
PImage face3;
PImage face4;
PImage face5;

//create image to store mask
PImage mask;

//scaled down image
PImage smaller;
int scale = 2;

void setup() {
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

  //stores detected faces in images
  //iterate through to check how many faces there are
  if (faces.length >= 1) {
    face0 = get(faces[0].x*scale, faces[0].y*scale, faces[0].width*scale, faces[0].height*scale);
    if (faces.length >= 2) {
      face1 = get(faces[1].x*scale, faces[1].y*scale, faces[1].width*scale, faces[1].height*scale);
      if (faces.length >= 3) {
        face2 = get(faces[2].x*scale, faces[2].y*scale, faces[2].width*scale, faces[2].height*scale);
        if (faces.length >= 4) {
          face3 = get(faces[3].x*scale, faces[3].y*scale, faces[3].width*scale, faces[3].height*scale);
          if (faces.length >= 5) {
            face4 = get(faces[4].x*scale, faces[4].y*scale, faces[4].width*scale, faces[4].height*scale);
            if (faces.length >= 6) {
              face5 = get(faces[5].x*scale, faces[5].y*scale, faces[5].width*scale, faces[5].height*scale);
            }
          }
        }
      }
    }
  }

  //swap two faces over
  if (faces.length == 2) {
    //resize images to current tracked faces
    face0.resize(faces[1].width*scale, faces[1].height*scale);
    face1.resize(faces[0].width*scale, faces[0].height*scale);

    //resize and mask images to smooth transition
    mask.resize(faces[1].width*scale, faces[1].height*scale);
    face0.mask(mask);
    mask.resize(faces[0].width*scale, faces[0].height*scale);
    face1.mask(mask);

    //place swapped faces
    image(face1, faces[0].x*scale, faces[0].y*scale);
    image(face0, faces[1].x*scale, faces[1].y*scale);
  }

  //swap three faces over
  if (faces.length == 3) {
    //resize images to current tracked faces
    face0.resize(faces[2].width*scale, faces[2].height*scale);
    face1.resize(faces[0].width*scale, faces[0].height*scale);
    face2.resize(faces[1].width*scale, faces[1].height*scale);

    //resize and mask images to smooth transition
    mask.resize(faces[2].width*scale, faces[2].height*scale);
    face0.mask(mask);
    mask.resize(faces[0].width*scale, faces[0].height*scale);
    face1.mask(mask);
    mask.resize(faces[1].width*scale, faces[1].height*scale);
    face2.mask(mask);

    //place swapped faces
    image(face0, faces[2].x*scale, faces[2].y*scale);
    image(face1, faces[0].x*scale, faces[0].y*scale);
    image(face2, faces[1].x*scale, faces[1].y*scale);
  }

  //swap four faces over
  if (faces.length >= 4) {
    //resize images to current tracked faces
    face0.resize(faces[3].width*scale, faces[3].height*scale);
    face1.resize(faces[0].width*scale, faces[0].height*scale);
    face2.resize(faces[1].width*scale, faces[1].height*scale);
    face3.resize(faces[2].width*scale, faces[2].height*scale);

    //resize and mask images to smooth transition
    mask.resize(faces[3].width*scale, faces[3].height*scale);
    face0.mask(mask);
    mask.resize(faces[0].width*scale, faces[0].height*scale);
    face1.mask(mask);
    mask.resize(faces[1].width*scale, faces[1].height*scale);
    face2.mask(mask);
    mask.resize(faces[2].width*scale, faces[2].height*scale);
    face3.mask(mask);

    //place swapped faces
    image(face0, faces[3].x*scale, faces[3].y*scale);
    image(face1, faces[0].x*scale, faces[0].y*scale);
    image(face2, faces[1].x*scale, faces[1].y*scale);
    image(face3, faces[2].x*scale, faces[2].y*scale);
  }

  //swap five faces over
  if (faces.length >= 5) {
    //resize images to current tracked faces
    face0.resize(faces[4].width*scale, faces[4].height*scale);
    face1.resize(faces[0].width*scale, faces[0].height*scale);
    face2.resize(faces[1].width*scale, faces[1].height*scale);
    face3.resize(faces[2].width*scale, faces[2].height*scale);
    face4.resize(faces[3].width*scale, faces[3].height*scale);

    //resize and mask images to smooth transition
    mask.resize(faces[4].width*scale, faces[4].height*scale);
    face0.mask(mask);
    mask.resize(faces[0].width*scale, faces[0].height*scale);
    face1.mask(mask);
    mask.resize(faces[1].width*scale, faces[1].height*scale);
    face2.mask(mask);
    mask.resize(faces[2].width*scale, faces[2].height*scale);
    face3.mask(mask);
    mask.resize(faces[3].width*scale, faces[3].height*scale);
    face4.mask(mask);

    //place swapped faces
    image(face0, faces[4].x*scale, faces[4].y*scale);
    image(face1, faces[0].x*scale, faces[0].y*scale);
    image(face2, faces[1].x*scale, faces[1].y*scale);
    image(face3, faces[2].x*scale, faces[2].y*scale);
    image(face4, faces[3].x*scale, faces[3].y*scale);
  }

  //swap six faces over
  if (faces.length >= 6) {
    //resize images to current tracked faces
    face0.resize(faces[5].width*scale, faces[5].height*scale);
    face1.resize(faces[0].width*scale, faces[0].height*scale);
    face2.resize(faces[1].width*scale, faces[1].height*scale);
    face3.resize(faces[2].width*scale, faces[2].height*scale);
    face4.resize(faces[3].width*scale, faces[3].height*scale);
    face5.resize(faces[4].width*scale, faces[4].height*scale);

    //resize and mask images to smooth transition
    mask.resize(faces[5].width*scale, faces[5].height*scale);
    face0.mask(mask);
    mask.resize(faces[0].width*scale, faces[0].height*scale);
    face1.mask(mask);
    mask.resize(faces[1].width*scale, faces[1].height*scale);
    face2.mask(mask);
    mask.resize(faces[2].width*scale, faces[2].height*scale);
    face3.mask(mask);
    mask.resize(faces[3].width*scale, faces[3].height*scale);
    face4.mask(mask);
    mask.resize(faces[4].width*scale, faces[4].height*scale);
    face5.mask(mask);

    //place swapped faces
    image(face0, faces[5].x*scale, faces[5].y*scale);
    image(face1, faces[0].x*scale, faces[0].y*scale);
    image(face2, faces[1].x*scale, faces[1].y*scale);
    image(face3, faces[2].x*scale, faces[2].y*scale);
    image(face4, faces[3].x*scale, faces[3].y*scale);
    image(face5, faces[4].x*scale, faces[4].y*scale);
  }
  
  // saves the frame if the space bar is pressed to to create videos if needed
  if (keyPressed) {
    if (key == ' '){
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

