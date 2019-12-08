//===================SKELETON=========================//
Kinect kinect;

ArrayList <SkeletonData> bodies;

int LEFT_HAND = Kinect.NUI_SKELETON_POSITION_HAND_LEFT;
int RIGHT_HAND = Kinect.NUI_SKELETON_POSITION_HAND_RIGHT;

int SHOULDER_CENTER = Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER;
int HIP_CENTER = Kinect.NUI_SKELETON_POSITION_HIP_CENTER;

int LEFT_FOOT = Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT;
int RIGHT_FOOT = Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT;

int LEFT_KNEE = Kinect.NUI_SKELETON_POSITION_KNEE_LEFT;
int RIGHT_KNEE = Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT;

float LeftHandMag;
float RightHandMag;

float LeftHandAngle;
float RightHandAngle;

float LeftFootMag;
float RightFootMag;

float FeetMag;

float SkeletonPosZ;

int LeftMidiIdx;
int RightMidiIdx;

//=================================================//

void gather_data(SkeletonData skeleton)
{
   if(if_bones_tracked(skeleton, SHOULDER_CENTER))
   {
     if((if_bones_tracked(skeleton, LEFT_HAND)))
       {
         float[] left_hand_data = hand_to_data(skeleton, LEFT_HAND);  
         LeftHandMag = left_hand_data[0];
         LeftHandAngle = left_hand_data[1];
         //text("LEFT ANGLE: "+LeftHandAngle, width*0.5, height*0.5);
         LeftMidiIdx = map_angle_to_scale_idx(LeftHandAngle, midiSequence.length);
       }
       
       if((if_bones_tracked(skeleton, RIGHT_HAND)))
       {
         float[] right_hand_data = hand_to_data(skeleton, RIGHT_HAND);  
         RightHandMag = right_hand_data[0];
         RightHandAngle = right_hand_data[1];
         //text("RIGHT ANGLE: "+RightHandAngle, width*0.5, height*0.6);
         RightMidiIdx = map_angle_to_scale_idx(RightHandAngle, bassMidiSequence.length);
       }
   }
     
     if(if_bones_tracked(skeleton, HIP_CENTER)){
       if(if_bones_tracked(skeleton, LEFT_FOOT))
       {
         LeftFootMag = leg_to_data(skeleton, LEFT_FOOT);
       }
       if(if_bones_tracked(skeleton, RIGHT_FOOT))
       {
         RightFootMag = leg_to_data(skeleton, RIGHT_FOOT);
       }
     }

     SkeletonPosZ = skeleton.position.z;

}

float leg_to_data(SkeletonData skeleton, int leg_idx)
{
  PVector foot = skeleton.skeletonPositions[leg_idx];
  PVector hip = skeleton.skeletonPositions[HIP_CENTER];
  PVector body_center = new PVector(hip.x, foot.y);
  
  draw_control_line(foot, body_center, 35, 242, 242);

  PVector foot_vect = new PVector(foot.x-body_center.x,foot.y-body_center.y);
  
  return foot_vect.mag();

}


float[] hand_to_data(SkeletonData skeleton, int hand_idx)
{
  // This function gathers the data of hand controller, which is a vector from shoulder center to the hand
  // HandMag: Vector lenght
  // HandAngle: Vector angle
  
  float HandMag;
  float HandAngle;
  
  PVector shoulder_center = skeleton.skeletonPositions[SHOULDER_CENTER];
  PVector hand = skeleton.skeletonPositions[hand_idx];
  
  draw_control_line(shoulder_center, hand, 35, 242, 42);
  
  PVector shoulder_hand_vect = new PVector(hand.x-shoulder_center.x,hand.y-shoulder_center.y);
  
  HandMag = shoulder_hand_vect.mag() * skeleton.position.z/1000;
  HandAngle = degrees(shoulder_hand_vect.heading());
  HandAngle = Math.abs(HandAngle+90)-180;
  
  float[] to_return = {HandMag, HandAngle};
  return to_return;
  
}

boolean if_bones_tracked(SkeletonData body_part, int body_idx){
      if (body_part.skeletonPositionTrackingState[body_idx] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED){
            return true;
      }
      else
      { return false;
    }
}

void printPosition(SkeletonData _s){
  
  print("Left hand position x: ",_s.position.x*width, "\n");
  print("Left hand position y: ",_s.position.y*height,"\n");
}

void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255);
  String s1 = str(_s.dwTrackingID);
  text(s1, _s.position.x*width, _s.position.y*height);
}

void drawSkeleton(SkeletonData _s) 
{
  // Body
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HEAD, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SPINE, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);

  // Left Arm
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, 
  Kinect.NUI_SKELETON_POSITION_HAND_LEFT);

  // Right Arm
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);

  // Left Leg
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
  Kinect.NUI_SKELETON_POSITION_KNEE_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, 
  Kinect.NUI_SKELETON_POSITION_FOOT_LEFT);

  // Right Leg
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT);
}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(255, 255, 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width, 
    _s.skeletonPositions[_j1].y*height, 
    _s.skeletonPositions[_j2].x*width, 
    _s.skeletonPositions[_j2].y*height);
  }
}

void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      //if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      //{
        bodies.remove(i);
      //}
    }
  }
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}
