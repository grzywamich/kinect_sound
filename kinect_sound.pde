import g4p_controls.*;
import processing.sound.*;
import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import java.lang.Math;
import processing.sound.*;
import processing.serial.*;

// TODO:
// ADSR
// delay do melodycznej linii (poglos?)
// badanie zmiany czasu narastania (komfort gry)
// zakladki miedzy dzwiekami (obwiednia) // NIE DA RADY :(
// przygotowac testy

Pulse leftPulse;
Pulse rightPulse;
TriOsc leftTri;
TriOsc rightTri;
SawOsc leftSaw;
SawOsc rightSaw;


OscillatorType leftOscType;
OscillatorType rightOscType;

Oscillator leftOsc;
Oscillator rightOsc;

LFO leftLFO;
LFO rightLFO;

LowPass leftLowPass;
LowPass rightLowPass;

Reverb leftReverb;
Reverb rightReverb;

Env env;
Env rightEnv;

int prev_bodies_size;

void setup()
{
  //size(640, 480);
  fullScreen(1);
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

  
  leftOscType = new OscillatorType(leftPulse, leftTri, leftSaw, "pulse");
  rightOscType = new OscillatorType(rightPulse, rightTri, rightSaw, "pulse");

  leftLFO = new LFO();
  rightLFO = new LFO();

  leftLowPass = new LowPass(this);
  rightLowPass = new LowPass(this);
 
  leftReverb = new Reverb(this);
  rightReverb = new Reverb(this);
  
  env  = new Env(this);
  rightEnv = new Env(this);

  leftOsc = new Oscillator(leftOscType, leftLowPass, env, leftLFO, leftReverb, true);
  rightOsc = new Oscillator(rightOscType, rightLowPass, rightEnv, rightLFO, rightReverb, false);
  
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
    }
    else if(prev_bodies_size!=0 && bodies.size()==0)
    {
      // stop sound if I am not tracked anymore
      leftOsc.stop();
      rightOsc.stop();
    }
    
    prev_bodies_size = bodies.size();
}

void handle_body(int body_idx){

  SkeletonData skeleton = bodies.get(body_idx);
  drawSkeleton(skeleton);
  gather_data(skeleton);

  if(!calibration_finished)
  {
    calibrate();
  }
  else
  {

// =========active left oscillator==============
    process_sound(
    leftOsc,
    LeftHandMag, MAX_LEFT_HAND_MAG_ARR, 
    LeftMidiIdx, midiSequence,
    SkeletonPosZ,
    LeftHandAngle,
    0.05);
    
    leftOsc.set_filter(LeftFootMag, MAX_LEFT_FOOT_MAG, 0.05, 0.25);                    

// =========active right oscillator=============
    process_sound(
    rightOsc,
    RightHandMag, MAX_RIGHT_HAND_MAG_ARR,
    RightMidiIdx, bassMidiSequence,
    SkeletonPosZ,
    RightHandAngle,
    0.6);
    
    rightOsc.set_filter(RightFootMag, MAX_RIGHT_FOOT_MAG, 0.6, 0.25);

// ============================================
    
  }
}
