float pip_size = 0.3;

void enable_image(){
  
  // background
  background(0);
  // pip screen in right bottom corner of RGB camera
  image(kinect.GetImage(), width - 640, height - 480, 640, 480);
  
}

void draw_control_line(PVector start, PVector end, int r, int g, int b){
        stroke(r,g,b);
        line(start.x*width,start.y*height,end.x*width,end.y*height);
}
