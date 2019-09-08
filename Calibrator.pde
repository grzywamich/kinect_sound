import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

float[] MAX_LEFT_HAND_MAG_ARR = new float[5];
float[] MAX_RIGHT_HAND_MAG_ARR = new float[5];

float MIN_Z = Float.MAX_VALUE;
float MAX_Z = Float.MIN_VALUE;

float MAX_LEFT_FOOT_MAG = Float.MIN_VALUE;
float MAX_RIGHT_FOOT_MAG = Float.MIN_VALUE;

int calibration_timestamp;
Boolean calibration_finished = false;
int CALIBRATION_TIME = 5*1000; //milisecs
int final_countdown;

void calibrate(){

  float y = height*0.25;
  float x =width*0.1;
  
  fill(255);
  pushMatrix();
  textSize(32);
  text("CALIBRATION IN PROGRESS", x*4, height*0.2);
  popMatrix();

  if(LeftMidiIdx!=-1){
    MAX_LEFT_HAND_MAG_ARR[LeftMidiIdx] = _round(_calibrate(LeftHandMag, MAX_LEFT_HAND_MAG_ARR[LeftMidiIdx]),2);
  }
  text(String.format("Left hand max value = "+Arrays.toString(MAX_LEFT_HAND_MAG_ARR)), x, y);
  y += height*0.05;
  
  if(RightMidiIdx!=-1){
    MAX_RIGHT_HAND_MAG_ARR[RightMidiIdx] = _round(_calibrate(RightHandMag, MAX_RIGHT_HAND_MAG_ARR[RightMidiIdx]),2);
  }
  text(String.format("Right hand max value = "+Arrays.toString(MAX_RIGHT_HAND_MAG_ARR)), x, y);
  y += height*0.05;
  
  
  MAX_LEFT_FOOT_MAG = _calibrate(LeftFootMag, MAX_LEFT_FOOT_MAG);
  text(String.format("Left foot max value = %.2f",MAX_LEFT_FOOT_MAG), x, y);
  y += height*0.05;
  
  MAX_RIGHT_FOOT_MAG = _calibrate(RightFootMag, MAX_RIGHT_FOOT_MAG);
  text(String.format("Right foot max value = %.2f",MAX_RIGHT_FOOT_MAG), x, y);
  y += height*0.05;
  
  MAX_Z = _calibrate(SkeletonPosZ, MAX_Z);
  text(String.format("Max depth-Z value = %.2f", MAX_Z), x, y);
  y += height*0.05;
  
  MIN_Z = -_calibrate(-SkeletonPosZ, -MIN_Z);
  text(String.format("Min depth-Z foot max value = %.2f", MIN_Z), x, y);
  y += height*0.05;
  
  // if nothing changes in 5 seconds, end calibration
  
  if((millis()-calibration_timestamp) > 2000)
  {
    final_countdown = (int)CALIBRATION_TIME/1000 - (int)Math.floor(((millis()-calibration_timestamp)/1000));
    pushMatrix();
    textSize(32);
    text(String.format("CALIBRATION ENDS IN %d s", final_countdown), x*4, y);
    popMatrix();
  }
  if((millis()-calibration_timestamp) > CALIBRATION_TIME)
  {
    // rescale a little bit volume range...
    float scale_coeff = 0.9;
    for(int i=0;i<5;i++){
      MAX_LEFT_HAND_MAG_ARR[i] *= scale_coeff;
      MAX_RIGHT_HAND_MAG_ARR[i] *= scale_coeff;
    }
    
    leftPulse_select.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    rightPulse_select.setLocalColorScheme(GCScheme.GREEN_SCHEME);
    calibration_finished = true;
  }
}

float _calibrate(float value, float max_value)
{
  if(value > max_value)
  {
    calibration_timestamp = millis();
    return value;
  }
  
  return max_value;
}
