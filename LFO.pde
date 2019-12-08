public class LFO{
  Boolean already_switched;
  Boolean lfo_status;
  
  int lfo_steps;
  int lfo_idx;
  
  float lfo_time_in_milis;
  float lfo_step_time;
  
  float[] lfo_sin;
  float lfo_trigger_time;;
  float lfo_freq_range;
  
  float lfo_trigger_angle = 170.0;
  
  public LFO()
  {
    this.already_switched = false;
    this.lfo_status = false;
    this.lfo_steps = 10;
    this.lfo_idx = 0;
    
    this.lfo_time_in_milis = 300;
    this.lfo_step_time = lfo_time_in_milis/lfo_steps;
    
    this.lfo_sin = new float[this.lfo_steps];
    this.lfo_trigger_time = 0.0;
    this.lfo_freq_range = 6.0;
    
    this.lfo_trigger_angle = 170.0;
    
    this.prepare_lfo_sin();
  }
  
  void prepare_lfo_sin()
  {
    float angl = 0.0;
    float angl_inc = TWO_PI/(this.lfo_steps-1.0);
  
    for (int i = 0; i < this.lfo_steps; i++) {
      this.lfo_sin[i] = sin(angl);
      angl = angl + angl_inc;
    }
  }
  
  void on_off_lfo(float hand_angle)
  {
    if(Math.abs(hand_angle)>this.lfo_trigger_angle)
    {
      if(!this.already_switched)
      {
        this.already_switched = true;
        this.lfo_status = !this.lfo_status;
      }
      
    }else
    {
      if(this.already_switched)
      {
        this.already_switched = false;
        this.lfo_idx = 0;
      }
    }
  }
  
  float modulate_parameter(float parameter)
  {
    float add = 0;
    if(millis() > this.lfo_trigger_time)
    {
      if(this.lfo_idx==this.lfo_steps)
        {
          this.lfo_idx = 0;
        }
            
        add = this.lfo_sin[this.lfo_idx]*this.lfo_freq_range;
        lfo_trigger_time = millis()+lfo_step_time;
        lfo_idx++;
     }
     
     return parameter+add;
  }
}
