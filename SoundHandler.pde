//===================SOUND=========================//
//float[] octave = {0.25, 0.5, 1.0, 2.0, 4.0};

Boolean isLeftPlaying = false;
Boolean isRightPlaying = false;

int higher_oct = 4;
int lower_oct = 2;
                   
int[] midiSequence = set_octave(higher_oct);     // d4, f4, g4, a4, c5    from 293.66 to 523.25 Hz             
int[] bassMidiSequence = set_octave(lower_oct);  // d3, f3, g3, a3, c4      from 146.83 to 261.63 Hz

float SOUND_TRIGGER_VAL = 0.6;


//===========Left Oscillator Parameters=================//

float LeftAmp;
int LeftMidiIdx;
float LeftPulseWidth;

float LeftPrevAmp= 0;
int LeftPrevMidiIdx = -1;
float LeftPrevPulseWidth = 0;

//===========Right Oscillator Parameters=================//


float RightAmp;
int RightMidiIdx;
float RightPulseWidth;

float RightPrevAmp= 0;
int RightPrevMidiIdx = -1;
float RightPrevPulseWidth = 0;

//====================EFFECTS=======================//
//Reverb reverb;
//float PrevWet;

Env env;
Env rightEnv;
float attackTime = 0.001;
float sustainTime = 0.004;
float sustainLevel = 0.3;
float releaseTime = 0.1;

LowPass leftLowPass;
int leftPrevCutoff;

LowPass rightLowPass;
int rightPrevCutoff;

//=================================================//


void activate_osc(Oscillator osc,
                  float amp, float[] max_amps, 
                  int midi_idx, int[] midi_seq,
                  float width_val,
                  float where_to_print)
{
  
  float pulse_width=0;
  float volume=0;  
  
  // ACTIVATE VOLUME IF HAND IS IN ACTIVATING ANGLE
  if(midi_idx!=-1)
  {
    // hand is in active zone. Initiate amplitude value
    float max_amp = max_amps[midi_idx];
    volume = norm(amp, 0, max_amp);
    if(volume>1){volume = 1;}
  }

  
  // PLAY IF HAND IS IN THE ACTIVATING DISTANCE
  if(volume>=SOUND_TRIGGER_VAL)
  {
    // SET PARAMETERS
    
    // volume
    volume = map(volume, SOUND_TRIGGER_VAL, 1, 0.01, 1);
    volume = _round(volume, 2);
    
    // pulse width (pulse generator case)
    pulse_width = map(width_val, MIN_Z, MAX_Z,0.05,0.95);
    if(pulse_width>0.95){pulse_width=0.95;}
    if(pulse_width<0.05){pulse_width=0.05;}
    pulse_width = _round(pulse_width,2);
    
    // frequency
    int midi_note = midi_seq[midi_idx];
    float freq = midiToFreq(midi_note);
    freq = _round(freq, 2);
    
    
    if(osc.type_selected == "pulse"){
      print_data(35, 242, 42, where_to_print, 0.1, "Pulse Width: "+pulse_width);
    }
    print_data(35, 242, 42, where_to_print, 0.15, "Amplitude: "+ volume); 
    print_data(35, 242, 42, where_to_print, 0.2, "MIDI/Frequency: "+ midi_note+"/"+freq+"Hz");
    

   // turn on oscillator and filter
   osc.play();  
   osc.set_osc_params(volume, freq, pulse_width);
  }
  

  else{
    if(osc.isPlaying)
    { 
      // make a fade out effect using envelope to stop sound smoothly
      osc.fade_out();
    }
  }
}
