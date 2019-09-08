public class Oscillator{
  
  SawOsc saw;
  TriOsc tri;
  Pulse pulse;
  
  LowPass lpf;
  Env env;
  String type_selected;
  Boolean isPlaying;
  Boolean isFilterActive;
  float amp;
  float freq;
  float pulse_width;
  
  int cutoff;
  
  public Oscillator(Pulse pulse, TriOsc tri, SawOsc saw, LowPass lpf, Env env)
  {
    this.saw = saw;
    this.tri = tri;
    this.pulse = pulse;
    
    this.lpf = lpf;
    this.env = env;
    
    this.isPlaying = false;
    this.isFilterActive = false;
    this.type_selected = "pulse";
    
    this.amp = 0;
    this.freq = 0;
    this.pulse_width = 0;
    
    this.cutoff = 0;
    
  }

  public void play()
  {
    if(!this.isPlaying)
    {
      if(this.type_selected=="tri"){
        this.tri.play();
      }
      else if(this.type_selected=="saw"){
        this.saw.play();
      }
      else if(this.type_selected=="pulse")
      {
        this.pulse.play();
      }
      
      this.isPlaying = true;
      
      this.lpf_process();

    }
  }
  
  public void stop()
  {

    this.lpf_stop();
    
    if(this.isPlaying)
    {
      if(this.type_selected=="tri"){
        this.tri.stop();
      }
      else if(this.type_selected=="saw"){
        this.saw.stop();
      }
      else if(this.type_selected=="pulse")
      {
        this.pulse.stop();
      }
      
      this.isPlaying = false;
    }
  }
  
    public void lpf_process()
  {
    if(!this.isFilterActive){
      if(this.type_selected=="tri"){
        this.lpf.process(this.tri);
      }
      else if(this.type_selected=="saw"){
        this.lpf.process(this.saw);
      }
      else if(this.type_selected=="pulse")
      {
        this.lpf.process(this.pulse);
      }
      
    this.isFilterActive = true;
    }
  }
  
  public void lpf_stop()
  {
    if(this.isFilterActive)
    {
      this.lpf.stop();
      this.isFilterActive=false;
    }
  }

  public void fade_out()
  {
    if(this.isPlaying){
      if(this.type_selected=="tri"){
        this.env.play(this.tri, attackTime, sustainTime, sustainLevel, releaseTime);
      }
      else if(this.type_selected=="saw"){
        this.env.play(this.saw, attackTime, sustainTime, sustainLevel, releaseTime);
      }
      else if(this.type_selected=="pulse")
      {
        this.env.play(this.pulse, attackTime, sustainTime, sustainLevel, releaseTime);
      }
    }
    //delay((int)((releaseTime+attackTime+sustainTime)*1000));
    this.isPlaying = false;
  }
  
  public void set_osc_params(float amp, float freq, float pulse_width)
  {
    if(this.isPlaying)
    {
      this.amp = amp;
      this.freq = freq;
      this.pulse_width = pulse_width;
      
      if(this.type_selected=="tri"){
          this.tri.amp(this.amp);
          this.tri.freq(this.freq);
        }
      else if(this.type_selected=="saw"){
          this.saw.amp(this.amp);
          this.saw.freq(this.freq);
        }
      else if(this.type_selected=="pulse")
        {
          this.pulse.amp(this.amp);
          this.pulse.freq(this.freq);
          this.pulse.width(this.pulse_width);
        }
    }
  }
  
  
  void set_filter(float control_val, float max_val, float print_x, float print_y)
  {
    if(this.isPlaying)
    {
    int max_f = 10000;
    int min_f = 500;
  
    float x = norm(control_val, 0.01, max_val);
    if(x<0){x=0;}
    if(x>1){x=1;}
    // exponential mapping
    
    int cutoff = (int)(min_f*pow(max_f/min_f, x));
    if(cutoff>max_f){cutoff=max_f;}
    if(cutoff<min_f){cutoff=min_f;}
    this.cutoff = cutoff;
    
    //int cutoff = (int)pow(max_f-min_f+1,control_val/max_val)+min_f-1;

    this.lpf.freq(this.cutoff);
    
    print_data(35, 242, 242, print_x, print_y, "Filter: "+cutoff+" Hz");
    }
  }

}
