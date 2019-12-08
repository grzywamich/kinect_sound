public class Oscillator{
  
  OscillatorType osc;
  LowPass lpf;
  LFO lfo;
  Reverb reverb;
  Boolean use_reverb;
  
  Env env;

  Boolean isPlaying;
  Boolean isFilterActive;
  Boolean isReverbActive;
  
  float amp;
  float freq;
  float pulse_width;
  
  int cutoff;

  float prev_amp;
  float prev_freq;
  float prev_pulse_width;
  
  int prev_cutoff;

  public Oscillator(OscillatorType osc, LowPass lpf, Env env, LFO lfo, Reverb reverb, Boolean use_reverb)
  {
    this.osc = osc;

    this.lpf = lpf;
    this.env = env;
    this.reverb = reverb;
    this.lfo = lfo;
    this.isPlaying = false;
    this.isFilterActive = false;
    this.isReverbActive = false;

    this.use_reverb = use_reverb;
    
    this.amp = 0;
    this.freq = 0;
    this.pulse_width = 0;
        
    this.prev_amp=0;
    this.prev_freq=0;
    this.prev_pulse_width=0;

    this.cutoff = 0;
    this.prev_cutoff = 0;
  }

  void play()
  {
    if(!this.isPlaying)
    {
      this.osc.play();
      if(this.use_reverb)
      {
        this.reverb_process();
      }
      this.lpf_process();

      this.isPlaying = true;
    }
  }
  
  void stop()
  {
    if(this.isPlaying)
    {
      this.lpf_stop();
      this.reverb_stop();
      this.osc.stop();
      
      this.amp = 0;
      this.freq = 0;
      this.pulse_width = 0;

      this.prev_freq = 0;
      this.prev_amp = 0;
      this.prev_pulse_width = 0;

      this.isPlaying = false;
    }
  }
  
   void lpf_process()
  {
    if(!this.isFilterActive){
      this.osc.lpf_process(this.lpf);
      this.isFilterActive = true;
    }
  }
  
  void reverb_process()
  {
    if(!this.isReverbActive){
      this.osc.reverb_process(this.reverb);
      this.isReverbActive = true;
    }
  }

   void reverb_stop()
  {
    if(this.isReverbActive){
      this.reverb.stop();
      this.isReverbActive = false;
    }
  }

  void lpf_stop()
  {
    if(this.isFilterActive)
    {
      this.lpf.stop();
      this.cutoff = 0;
      this.prev_cutoff = 0;
      this.isFilterActive=false;
    }
  }

  void envelope(float attack_t, float sustain_t, float sustain_lvl, float release_t)
  {
    if(this.isPlaying){
      this.osc.envelope(this.env, attack_t, sustain_t, sustain_lvl, release_t);
    }
  }
  
  void set_osc_params(float amp, float freq, float pulse_width)
  {
    this.amp(amp);
    this.freq(freq);
    this.width(pulse_width);
  }
  

   void amp(float amp)
  {
    if(this.isPlaying)
    {
      this.amp = amp;
      if(this.amp != this.prev_amp){
        this.osc.amp(this.amp);
        this.prev_amp = this.amp;
      }  
  }
  }
  
  
   void freq(float freq)
  {
    if(this.isPlaying)
    {
      this.freq = freq;
      if(this.freq != this.prev_freq){
        this.osc.freq(this.freq);
        this.prev_freq = this.freq;
      }  
    }
  }
 
    void width(float pulse_width)
  { 
    if(this.isPlaying) //<>//
    {
      this.pulse_width = pulse_width;
      if(this.pulse_width!=this.prev_pulse_width){
        this.osc.width(this.pulse_width);
        this.prev_pulse_width = this.pulse_width;
      }
    }
  }
  
  void set()
  {
    if(this.isPlaying){
      this.osc.set(this.freq, this.pulse_width, this.amp);
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

    if(this.cutoff!=this.prev_cutoff){
      this.lpf.freq(this.cutoff);
      this.prev_cutoff=this.cutoff;
    }
    print_data(35, 242, 242, print_x, print_y, "Filter: "+cutoff+" Hz");
    }
  }
  
  void fade_out(float slope_time)
  {
    this.envelope(0, 0.01, this.amp, slope_time);
  }
  
  void set_type(String type)
  {
    
    List<String> types_available = Arrays.asList("tri", "saw", "pulse");
    
    if(types_available.contains(type))
    {
      this.osc.type_selected = type;
    }
    else
    {
      String msg = type + " is not available";
      throw new IllegalArgumentException(msg);
    }
  }
  
  String get_type()
  {
    return osc.type_selected;
  }
  
  Boolean is_lfo_active()
  {
    return this.lfo.lfo_status;
  }
  
  void on_off_lfo(float hand_angle){
    this.lfo.on_off_lfo(hand_angle);
  }
  
  float modulate_parameter(float param)
  {
    return this.lfo.modulate_parameter(param);
  }

}
