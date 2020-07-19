public class OscillatorType{
  SawOsc saw;
  TriOsc tri;
  Pulse pulse;
  String type_selected;
  
  
  public OscillatorType(Pulse pulse, TriOsc tri, SawOsc saw, String type){
    this.saw = saw;
    this.tri = tri;
    this.pulse = pulse;
    this.type_selected = type;
  }
   //<>//
  void play()
  {
      if(this.type_selected=="tri"){
        this.tri.play();
      }
      else if(this.type_selected=="saw"){
        this.saw.play(); //<>//
      }
      else if(this.type_selected=="pulse")
      {
        this.pulse.play();
      }
  }
  
  void stop()
  {
      if(this.type_selected=="tri"){
        this.tri.stop(); //<>//
      }
      else if(this.type_selected=="saw"){
        this.saw.stop(); //<>//
      }
      else if(this.type_selected=="pulse")
      {
        this.pulse.stop();
      }
  }
  
  
  void lpf_process(LowPass lpf)
  {
      if(this.type_selected=="tri"){
        lpf.process(this.tri);
      }
      else if(this.type_selected=="saw"){
        lpf.process(this.saw);
      }
      else if(this.type_selected=="pulse")
      {
        lpf.process(this.pulse);
      }
  }
  
  void reverb_process(Reverb reverb)
  {
      if(this.type_selected=="tri"){
        reverb.process(this.tri);
      }
      else if(this.type_selected=="saw"){
        reverb.process(this.saw);
      }
      else if(this.type_selected=="pulse")
      {
        reverb.process(this.pulse);
      }
      
      reverb.set(0.5, 0.8, 0.8);
  }

  void envelope(Env env, float attack_t, float sustain_t, float sustain_lvl, float release_t)
  {
      if(this.type_selected=="tri"){
        env.play(this.tri, attack_t, sustain_t, sustain_lvl, release_t);
      }
      else if(this.type_selected=="saw"){
        env.play(this.saw, attack_t, sustain_t, sustain_lvl, release_t);
      }
      else if(this.type_selected=="pulse")
      {
        env.play(this.pulse, attack_t, sustain_t, sustain_lvl, release_t);
      }
  }
  
  
   void amp(float amp)
  {

      if(this.type_selected=="tri"){
          this.tri.amp(amp);
        }
      else if(this.type_selected=="saw"){
          this.saw.amp(amp);
        }
      else if(this.type_selected=="pulse")
        {
          this.pulse.amp(amp);
        }
  }
  
  
   void freq(float freq)
  {
    
        if(this.type_selected=="tri"){
          this.tri.freq(freq);
        }
      else if(this.type_selected=="saw"){
          this.saw.freq(freq);
        }
      else if(this.type_selected=="pulse")
        {
          this.pulse.freq(freq);
        }

  }
 
  void width(float pulse_width)
  {
      if(this.type_selected=="pulse")
        {
          this.pulse.width(pulse_width);
        }
  }
  
  void set(float freq, float pulse_width, float amp)
  {
    
     if(this.type_selected=="tri"){
       this.tri.set(freq, amp, 0, 0);
     }
     else if(this.type_selected=="saw"){
       this.saw.set(freq, amp, 0, 0);
     }
     else if(this.type_selected=="pulse")
       {
         this.pulse.set(freq, pulse_width, amp, 0, 0);
       }
  }

}
