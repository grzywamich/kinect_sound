//===================SOUND=========================//
//float[] octave = {0.25, 0.5, 1.0, 2.0, 4.0};

int higher_oct = 4;
int lower_oct = 2;
                   
int[] midiSequence = set_octave(higher_oct);     // d4, f4, g4, a4, c5    from 293.66 to 523.25 Hz             
int[] bassMidiSequence = set_octave(lower_oct);  // d3, f3, g3, a3, c4      from 146.83 to 261.63 Hz

float SOUND_TRIGGER_VAL = 0.6;

//===========================================//

float slope_time = 0.2;
//=================================================//


void process_sound(Oscillator osc,
                  float amp, float[] max_amps, 
                  int midi_idx, int[] midi_seq,
                  float width_val,
                  float hand_angle,
                  float where_to_print)
{
    

  osc.on_off_lfo(hand_angle);

  float volume=0;
  
  if(is_active(midi_idx))
  {
    // hand is in active zone. Initiate amplitude value
    float max_amp = max_amps[midi_idx];
    volume = norm(amp, 0, max_amp);
    if(volume>1){volume = 1;}
  }else
  {
    stop_playing(osc);
  }


  if(is_volume_active(volume)) // PLAY IF HAND IS IN THE ACTIVATING DISTANCE
  {
    start_playing(osc, volume, width_val, midi_idx, midi_seq, where_to_print);
  }else
  {
    stop_playing(osc);
  }
}

void start_playing(Oscillator osc, float volume, float width_val, int midi_idx, int[] midi_seq, float where_to_print)
{
    // SET PARAMETERS
    
    // volume
     volume = map(volume, SOUND_TRIGGER_VAL, 1, 0.01, 1);
     volume = _round(volume, 2);

    // pulse width (if generator is pulse)
     float pulse_width = map(width_val, MIN_Z, MAX_Z,0.05,0.95);
     if(pulse_width>0.95){pulse_width=0.95;}
     if(pulse_width<0.05){pulse_width=0.05;}
     pulse_width = _round(pulse_width,2);
    
    // frequency
    // change midi if triggered
     int midi_note = midi_seq[midi_idx];
     float freq = midiToFreq(midi_note);
     freq = _round(freq, 2);
    
     if(osc.get_type() == "pulse"){
       print_data(35, 242, 42, where_to_print, 0.1, "Pulse Width: "+pulse_width);
     }
     print_data(35, 242, 42, where_to_print, 0.15, "Amplitude: "+ volume); 
     print_data(35, 242, 42, where_to_print, 0.2, "MIDI/Frequency: "+ midi_note+"/"+freq+"Hz"); //<>//

     if(osc.is_lfo_active())
     {
       print_data(35, 242, 42, where_to_print, 0.3, "LFO active");
       osc.freq = osc.modulate_parameter(freq); //<>//
     }
     else
     {
       osc.freq = freq;
     }

     osc.pulse_width = pulse_width;
     osc.amp = volume;
     osc.play();

     osc.set(); //<>//

     osc.prev_freq = osc.freq;
}

void stop_playing(Oscillator osc)
{
    if(osc.isPlaying)
    {
      // make a fade out effect using envelope to stop sound smoothly
      osc.fade_out(slope_time);
      osc.isPlaying = false;
      osc.freq=0;
      osc.prev_freq=0;
      osc.amp=0;
      osc.pulse_width=0;
    }
}

Boolean is_active(int midi_idx)
{
  // ACTIVATE VOLUME IF HAND IS IN ACTIVATING ANGLE
  return midi_idx!=-1;
}

Boolean is_volume_active(float volume)
{
  // PLAY IF HAND IS IN THE ACTIVATING DISTANCE
  return volume>=SOUND_TRIGGER_VAL;
}
