float[] RANGE = linspace(0, width, midiSequence.length);
int ANGLE_RANGE = 75;

public static float[] linspace(float start, float stop, int n)
{
   float[] result = new float[n];

   float step = (stop-start)/(n-1);

   for(int i = 0; i <= n-2; i++)
   {
       result[i] = start + (i * step);
   }
   result[result.length-1] = stop;

   return result;
}

int map_angle_to_scale_idx(float angle, int seq_length){
  angle = Math.abs(angle);
  float idx = -1;

  float start = 90-ANGLE_RANGE;
  float end = 90+ANGLE_RANGE;
  
  if(angle >= start && angle <= end){
    idx = map(angle, start, end, 0, seq_length);
  }
  return (int)Math.floor(idx);
}

float _round(float value, int decimal)
{
  double result = Math.round(value * Math.pow(10,decimal)) / Math.pow(10,decimal);
  return (float)result;
}

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  if(note==0){
    return 0;
  }
  else{
  return (pow(2, ((note-69)/12.0)))*440;
  }
}

int[] set_octave(int octave_num)
{
  //                    d1, f1, g1, a1, c2
  int[] midi_sequence = {26, 29, 31, 33, 36};
  
  for(int i = 0; i < midi_sequence.length; i++)
  {
    midi_sequence[i] += 12*(octave_num-1);
  }

  return midi_sequence;
}


void print_data(int r, int g, int b, float text_width, float text_height, String text)
{
  pushMatrix();
  fill(r, g, b);
  text(text, width*text_width,height*text_height);
  popMatrix();
}
