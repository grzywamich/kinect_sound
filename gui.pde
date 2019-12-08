/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void restart_click1(GButton source, GEvent event) { //_CODE_:restart:536311:
  println("restart - GButton >> GEvent." + event + " @ " + millis());
  MAX_LEFT_HAND_MAG_ARR = new float[5];
  MAX_RIGHT_HAND_MAG_ARR = new float[5];
  
  MIN_Z = Float.MAX_VALUE;
  MAX_Z = Float.MIN_VALUE;
  
  MAX_LEFT_FOOT_MAG = Float.MIN_VALUE;
  MAX_RIGHT_FOOT_MAG = Float.MIN_VALUE;
  
  
  leftPulse_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  rightPulse_select.setLocalColorScheme(GCScheme.RED_SCHEME);

  leftTri_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  leftSaw_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  
  rightTri_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  rightSaw_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  
  leftOsc.stop();
  leftOsc.set_type("pulse");

  rightOsc.stop();
  rightOsc.set_type("pulse");

  calibration_finished = false;
  
} //_CODE_:restart:536311:

  //===========================LEFT=================================//
public void leftPulse_click(GButton source, GEvent event) { //_CODE_:leftPulse_select:819994:
  println("leftPulse_select - GButton >> GEvent." + event + " @ " + millis());

  if(!calibration_finished){return;}
  if(leftOsc.get_type()=="pulse"){return;}
  leftPulse_select.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  leftTri_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  leftSaw_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  
  leftOsc.stop();
  leftOsc.set_type("pulse");

} //_CODE_:leftPulse_select:819994:

public void leftTri_click(GButton source, GEvent event) { //_CODE_:leftTri_select:229900:
  println("button2 - GButton >> GEvent." + event + " @ " + millis());
  if(!calibration_finished){return;}
  if(leftOsc.get_type()=="tri"){return;}
  leftPulse_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  leftTri_select.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  leftSaw_select.setLocalColorScheme(GCScheme.RED_SCHEME);

  leftOsc.stop();
  leftOsc.set_type("tri");

} //_CODE_:leftTri_select:229900:

public void leftSaw_click(GButton source, GEvent event) { //_CODE_:leftSaw_select:548797:
  println("button3 - GButton >> GEvent." + event + " @ " + millis());
  if(!calibration_finished){return;}
  if(leftOsc.get_type()=="saw"){return;}
  leftPulse_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  leftTri_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  leftSaw_select.setLocalColorScheme(GCScheme.GREEN_SCHEME);

  leftOsc.stop();
  leftOsc.set_type("saw");
} //_CODE_:leftSaw_select:548797:

  //=================================================================//
  //===========================RIGHT=================================//
public void rightPulse_click(GButton source, GEvent event) { //_CODE_:rightPulse_select:321313:
  println("rightPulse_select - GButton >> GEvent." + event + " @ " + millis());
  if(!calibration_finished){return;}
  if(rightOsc.get_type()=="pulse"){return;}
  rightPulse_select.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  rightTri_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  rightSaw_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  
  rightOsc.stop();
  rightOsc.set_type("pulse");
  //rightOsc.play();
} //_CODE_:rightPulse_select:321313:

public void rightTri_click(GButton source, GEvent event) { //_CODE_:rightTri_select:821419:
  println("rightTri_select - GButton >> GEvent." + event + " @ " + millis());
  if(!calibration_finished){return;}
  if(rightOsc.get_type()=="tri"){return;}
  rightPulse_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  rightTri_select.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  rightSaw_select.setLocalColorScheme(GCScheme.RED_SCHEME);

  rightOsc.stop();
  rightOsc.set_type("tri");
  //rightOsc.play();

} //_CODE_:rightTri_select:821419:

public void rightSaw_click(GButton source, GEvent event) { //_CODE_:rightSaw_select:955557:
  println("rightSaw_select - GButton >> GEvent." + event + " @ " + millis());
  if(!calibration_finished){return;}
  if(rightOsc.get_type()=="saw"){return;}
  rightPulse_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  rightTri_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  rightSaw_select.setLocalColorScheme(GCScheme.GREEN_SCHEME);

  rightOsc.stop();
  rightOsc.set_type("saw");
  //rightOsc.play();
  
} //_CODE_:rightSaw_select:955557:
  //================================================================//


// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");

  restart = new GButton(this, 0.94*width, 0.01*height, 0.05*width, 0.05*height);
  restart.setText("RESTART");
  restart.setTextBold();
  restart.setLocalColorScheme(GCScheme.RED_SCHEME);
  restart.addEventHandler(this, "restart_click1");
 
  float x = 0.85;
  float y = 0.01;
  float incr = 0.02;
  float y_bckp = y;
  //===========================LEFT=================================//
  label1 = new GLabel(this, x*width, y*height, 0.03*width, 0.05*height);
  y += 2*incr;
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("LEFT OSC");
  label1.setTextBold();
  label1.setLocalColorScheme(GCScheme.SCHEME_8);
  label1.setOpaque(false);
  
  leftPulse_select = new GButton(this, x*width, y*height, 0.03*width, 0.02*height);
  y+= incr;
  leftPulse_select.setText("Pulse");
  leftPulse_select.addEventHandler(this, "leftPulse_click");
  
  leftTri_select = new GButton(this, x*width, y*height, 0.03*width, 0.02*height);
  y+= incr;
  leftTri_select.setText("Tri");
  leftTri_select.addEventHandler(this, "leftTri_click");
  
  leftSaw_select = new GButton(this, x*width, y*height, 0.03*width, 0.02*height);
  leftSaw_select.setText("Saw");
  leftSaw_select.addEventHandler(this, "leftSaw_click");

  //===================================================================//
  //===========================RIGHT===================================//
  x+=2*incr;
  y=y_bckp;
  label2 = new GLabel(this, x*width, y*height, 0.03*width, 0.05*height);
  y += 2*incr;
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("RIGHT OSC");
  label2.setTextBold();
  label2.setLocalColorScheme(GCScheme.SCHEME_8);
  label2.setOpaque(false);
  
  rightPulse_select = new GButton(this, x*width, y*height, 0.03*width, 0.02*height);
  y+= incr;
  rightPulse_select.setText("Pulse");
  rightPulse_select.addEventHandler(this, "rightPulse_click");
  
  rightTri_select = new GButton(this, x*width, y*height, 0.03*width, 0.02*height);
  y+= incr;
  rightTri_select.setText("Tri");
  rightTri_select.addEventHandler(this, "rightTri_click");
  
  rightSaw_select = new GButton(this, x*width, y*height, 0.03*width, 0.02*height);
  y+= incr;
  rightSaw_select.setText("Saw");
  rightSaw_select.addEventHandler(this, "rightSaw_click");
  //===================================================================//  
  

  leftPulse_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  rightPulse_select.setLocalColorScheme(GCScheme.RED_SCHEME);

  leftTri_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  leftSaw_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  
  rightTri_select.setLocalColorScheme(GCScheme.RED_SCHEME);
  rightSaw_select.setLocalColorScheme(GCScheme.RED_SCHEME);

}

// Variable declarations 
// autogenerated do not edit
GButton restart; 
GLabel label1; 
GButton leftPulse_select; 
GButton leftTri_select; 
GButton leftSaw_select; 
GLabel label2; 
GButton rightPulse_select; 
GButton rightTri_select; 
GButton rightSaw_select; 
