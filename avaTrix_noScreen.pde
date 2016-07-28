
/**
 * Multiplayer battle system
 */

import oscP5.*;
import netP5.*;
import ddf.minim.*;
import de.looksgood.ani.*;


OscP5 oscP5;
Minim minim;
BattleSystem battleSystem;
GUIView gui;
OSCView oscController;
SoundPlayer audioPlayer;


// set if the sketch is fullscreen by default
boolean USE_SCREEN = true;
boolean fullscreen = false;

// default window size if not fullscreen
int xres = 1280;
int yres = 720;

// a few options
final boolean USE_KEYBOARD = true;

void setup() {
  // if(!fullscreen) size(xres, yres);
  // else size(displayWidth, displayHeight);
  // noCursor();
  frameRate(30);

  // size(1280, 720, P2D);
  fullScreen(P2D,2);

  battleSystem = new BattleSystem();
  if (USE_SCREEN) {
    gui          = new GUIView();
    gui.injectBattleSystem(battleSystem);
  }
  oscController = new OSCView();
  oscController.injectBattleSystem(battleSystem);
  minim = new Minim(this);
  audioPlayer = new SoundPlayer(minim);
  audioPlayer.injectBattleSystem(battleSystem);
  Ani.init(this);

  // init all the network stuff
  initOSC();
  thread("runLED");
}

// lets processing know if we want it fullscreen
// boolean sketchFullScreen() {
//   return fullscreen;
// }

void draw() {
  background(0);
  battleSystem.update();
  if (USE_SCREEN) {
    gui.display();
    image(gui.getCanvas(), 0, 0);
  }
  audioPlayer.playAudio();
}

public void runLED(){
  oscController.display();
  
}

/////////////////////////////////////////////////////////////
//////  Input Section
/////////////////////////////////////////////////////////////

void keyPressed() {
  if (USE_KEYBOARD) keyboardEvent();
}

void keyboardEvent() {
  if      (key == 'q') battleSystem.playerInput(0, 1);
  else if (key == 'w') battleSystem.playerInput(0, 2);
  else if (key == 'e') battleSystem.playerInput(0, 3);
  else if (key == 'r') battleSystem.playerInput(0, 4);
  else if (key == 't') battleSystem.playerInput(0, 5);

  else if (key == 'z') battleSystem.playerInput(1, 1);
  else if (key == 'x') battleSystem.playerInput(1, 2);
  else if (key == 'c') battleSystem.playerInput(1, 3);
  else if (key == 'v') battleSystem.playerInput(1, 4);
  else if (key == 'b') battleSystem.playerInput(1, 5);

  else if (key == ENTER) battleSystem.reset();
}

/////////////////////////////////////////////////////////////
//////  x-OSC Section
/////////////////////////////////////////////////////////////

void initOSC() {
    oscP5 = new OscP5(this, 8000);
}

void oscEvent(OscMessage _message) {
  battleSystem.oscInput(_message);
}

/////////////////////////////////////////////////////////////
//////  Custom Functions
/////////////////////////////////////////////////////////////

static final float arrayAverage(float[] arr) {
  float sum = 0;
  for (float f: arr)  sum += f;
  return sum/arr.length;
}
static final float[] arrayPush(float val,float[] arr) {
  float[] tArr = new float[arr.length];
  for (int i = 0; i < arr.length-1; i++){
    tArr[i] = arr[i+1];
  }
  tArr[arr.length-1] = val;
  return tArr;
}