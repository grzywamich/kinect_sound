float pip_size = 0.3;

void enable_image(){
  
  // background
  background(0);
  // pip screen in right bottom corner of RGB camera
  image(kinect.GetImage(), width*(1-pip_size), height*(1-pip_size), width*pip_size, height*pip_size);
  
}

void draw_control_line(PVector start, PVector end, int r, int g, int b){
        stroke(r,g,b);
        line(start.x*width,start.y*height,end.x*width,end.y*height);
}
