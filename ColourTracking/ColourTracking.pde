import processing.video.*;

Capture video;
float mr, mg, mb, dist;
float threshold = 25;
int stx = 0;
int sty = 0;

void setup () {
  size(320, 240);
  String [] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, 320, 240);
  video.start();
}

void captureEvent (Capture video) {
  video.read();
}

void mouseClicked () {
  int mx = mouseX;
  int my = mouseY;
  int idx = mx + my * width;
  mr = red (pixels[idx]);
  mg = green (pixels[idx]);
  mb = blue (pixels[idx]);
}

void draw () {
  image(video,0,0); 
    
  float leastdist = 179200;
  float r,g,b;
    
  loadPixels();
  
  for (int x =0;x < width;x++) {
    for (int y =0;y < height;y++) {
      
      int index = x + y * width;
      
      r = red (pixels[index]);
      g = green (pixels[index]);
      b = blue (pixels[index]);
      
      dist = dist(r,g,b,mr,mg,mb);
      
      if(dist < leastdist) {
        leastdist = dist;
        stx = x;
        sty = y;
      }
            
    }
  }
    
  updatePixels();
  
  if (leastdist > 0) {
    fill(mr,mg,mb);
    //fill(0);
    stroke(255,0,0);
    strokeWeight(2);
    ellipse(stx, sty, 10, 10);
  }
}
