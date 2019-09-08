import g4p_controls.*;
import processing.sound.*;
import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import java.lang.Math;
import processing.sound.*;
import processing.serial.*;


Pulse leftPulse;
Pulse rightPulse;
TriOsc leftTri;
TriOsc rightTri;
SawOsc leftSaw;
SawOsc rightSaw;

Oscillator leftOsc;
Oscillator rightOsc;
String leftOsc_selected;
String rightOsc_selected;

int prev_bodies_size;

void setup()
{
  //size(640, 480);
  fullScreen(3);
  background(0);
  textSize(26);
  kinect = new Kinect(this);
  smooth();
  bodies = new ArrayList<SkeletonData>();  
  calibration_timestamp = millis();
  
  leftPulse = new Pulse(this);
  rightPulse = new Pulse(this);
  leftTri = new TriOsc(this);
  rightTri = new TriOsc(this);
  leftSaw = new SawOsc(this);
  rightSaw = new SawOsc(this);
  
  leftLowPass = new LowPass(this);
  rightLowPass = new LowPass(this);
 
  env  = new Env(this);
  rightEnv = new Env(this);

  leftOsc = new Oscillator(leftPulse, leftTri, leftSaw, leftLowPass, env);
  rightOsc = new Oscillator(rightPulse, rightTri, rightSaw, rightLowPass, rightEnv);
  
  prev_bodies_size = bodies.size();  // init

  createGUI();
}


void draw()
{
  enable_image();
  handle_bodies();
}

void handle_bodies(){

    
    if(bodies.size()!=0)
    {
      handle_body(0);  // only one skeleton supported
      //for (int i=0; i<bodies.size(); i++) 
      //{    
      //  handle_body(i);
      //}
    }
    else if(prev_bodies_size!=0 && bodies.size()==0)
    {
      // what to do if I'm not tracked anymore
      leftOsc.stop();
      rightOsc.stop();
    }
    
    prev_bodies_size = bodies.size();
}

void handle_body(int body_idx){

  SkeletonData skeleton = bodies.get(body_idx);
  drawSkeleton(skeleton);
  gather_data(skeleton);
        // for now, only one person is supported
        //if(body_idx==0)
        //{

  if(!calibration_finished)
  {
    calibrate();
  }
  else
  {

// =========active left oscillator==============
    activate_osc(
    leftOsc,
    LeftHandMag, MAX_LEFT_HAND_MAG_ARR, 
    LeftMidiIdx, midiSequence,
    SkeletonPosZ,
    0.05);
    
    leftOsc.set_filter(LeftFootMag, MAX_LEFT_FOOT_MAG, 0.05, 0.25);                    

// =========active right oscillator=============
    activate_osc(
    rightOsc,
    RightHandMag, MAX_RIGHT_HAND_MAG_ARR,
    RightMidiIdx, bassMidiSequence,
    SkeletonPosZ,
    0.7);
    
    rightOsc.set_filter(RightFootMag, MAX_RIGHT_FOOT_MAG, 0.7, 0.25);

// ============================================
    
  }
}
