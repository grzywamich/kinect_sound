int LFO_SPEED_INIT = 15;
float LFO_DEPTH_INIT = 0.02;

public class LFO{

  Boolean already_switched;
  Boolean lfo_status;
  
  int lfo_idx;
  
  float[] lfo_sin;

  float lfo_range;
  
  float lfo_trigger_angle = 170.0;
  
  public LFO()
  {
    this.already_switched = false;
    this.lfo_status = false;
    this.lfo_range = LFO_DEPTH_INIT;
    this.lfo_trigger_angle = 175.0;
    
    this.prepare_lfo_sin(LFO_SPEED_INIT);
    this.lfo_idx = 0;

  }
  
  void set_lfo_frequency(int lfo_steps)
  {
    if(lfo_steps==this.lfo_sin.length){
      return;
    }else
    {
      prepare_lfo_sin(lfo_steps);
      this.lfo_idx = 0;
    }
  }
  
  void set_lfo_depth(float lfo_depth)
  {
    if(lfo_depth == this.lfo_range)
    {
      return;
    }
    else{
    this.lfo_range = lfo_depth;
    }
  }
 
  void prepare_lfo_sin(int lfo_steps)
  {
        
    this.lfo_sin = new float[lfo_steps];

    float angl = 0.0;
    float angl_inc = TWO_PI/(lfo_steps-1.0);
  
    for (int i = 0; i < this.lfo_sin.length; i++) {
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

    if(this.lfo_idx==this.lfo_sin.length)
      {
        this.lfo_idx = 0;
      }

     add = this.lfo_sin[this.lfo_idx]*(parameter*this.lfo_range);

     this.lfo_idx++;
     return parameter+add;
  }
}
