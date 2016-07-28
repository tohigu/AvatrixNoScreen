class GUIView extends BasicView {

	PGraphics canvas;
	
	PShape[] weaponIcons;

	String[] console;

	final PFont BIG_FONT;
	final PFont SMALL_FONT;

	final color[] playerColors = {
		color(218, 100, 247),
		color(200, 255, 91)};

	// Constants
	int Y_AXIS = 1;
	int X_AXIS = 2;
	int ENERGY_BALLS = 12;

	// Variables
	color b1, b2, c1, c2;
	int timerSize = BIG_FONT_SIZE;
	int timerAlpha = 255;

	int timerCounter = 0;
	Ani timerSzAni;
	Ani timerAlAni;

	PImage energySprite;



	

	/******** WEAPONS ********/
	final color LOADED_COLOR = color(0, 200, 0);
	final color LOADING_COLOR = color(255, 50, 0);
	final color UNAVAILABLE_COLOR = color(100,100,100);


	public GUIView(){
		// init the canvas on which to draw
		canvas = createGraphics(width, height);
		BIG_FONT = loadFont("SourceCodePro-Regular-48.vlw");
		SMALL_FONT = loadFont("Sudo-48.vlw");

		// init the players
		initPlayers();
		// load svg icons of weapons
		//loadWeaponIcons();
		console = new String[3];
		energySprite = loadImage(SPRITE_ENERGY_PATH);

	}

	public void injectBattleSystem(BattleSystem _bs){
		battleSystem = _bs;
	}

	public void display(){
		canvas.beginDraw();
		canvas.clear();

		//DEBUG
		// canvas.stroke(255);
		// canvas.fill(255);
		// canvas.textAlign(CENTER);
		// canvas.textFont(BIG_FONT);
		// canvas.textSize(BIG_FONT_SIZE);
		// canvas.text(battleSystem.getState(), 200, 200);


		displayGUI();

		canvas.pushMatrix();
		canvas.translate(EDGE_PADDING*2.2, EDGE_PADDING * 2);
		displayPlayer(battleSystem.getPlayer(0),false);
		canvas.popMatrix();

		canvas.pushMatrix();
		canvas.translate(width-(EDGE_PADDING*2.2), EDGE_PADDING * 2);
		displayPlayer(battleSystem.getPlayer(1),true);
		canvas.popMatrix();

		//Display Effects
		displayEffects();

		color fadeColor = color(0,0,0);
		canvas.fill(fadeColor,battleSystem.fadeLvl);
		canvas.noStroke();
		canvas.rect(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);

		color flashColor = color(255,255,255);
		canvas.fill(flashColor,battleSystem.flashLvl);
		if(battleSystem.getState() == BATTLE) canvas.fill(flashColor,255);
		canvas.rect(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
		canvas.endDraw();
	
}

	public void displayGUI(){
		title();
		console();

		if(battleSystem.getState() == WPSEL) timer();
		if(battleSystem.getState() == SKILLTEST) {timer();skillBar();}
		if(battleSystem.getState() == PRE_WPSEL) {skillBar();}
		

	}

	private void skillBar(){
		int SKILL_BAR_WIDTH = 150;
		int SKILL_BAR_HEIGHT = 30;
		color p1c,p2c;
		canvas.pushStyle();
		canvas.pushMatrix();
		canvas.translate(width/2,EDGE_PADDING * 4);
		float sk_1 = battleSystem.getPlayer(0).getSkill();
		float sk_2 = battleSystem.getPlayer(1).getSkill();
		// if (sk_1 > sk_2) {
		// 	p1c = color(255,0,0);
		// 	p2c = color(0,0,255);
		// }else if(sk_1 < sk_2){
		// 	p1c = color(0,0,255);
		// 	p2c = color(255,0,0);
		// }else{
		// 	p1c = color(255,255,255);
		// 	p2c = color(255,255,255);
		// }
		p1c = color(255,0,0);
		p2c = color(0,0,255);
		canvas.noStroke();
		canvas.fill(p1c);
		int p1w = ceil(sk_1 * SKILL_BAR_WIDTH);
		canvas.rect(0,0, -p1w, SKILL_BAR_HEIGHT);
		canvas.fill(p2c);
		int p2w = ceil(sk_2 * SKILL_BAR_WIDTH);
		canvas.rect(0,0, p2w, SKILL_BAR_HEIGHT);
		canvas.popMatrix();
		canvas.popStyle();

	}



	private void title(){
		// canvas.stroke(255);
		// canvas.fill(255);
		// canvas.textAlign(CENTER);
		// canvas.textFont(BIG_FONT);
		// canvas.textSize(BIG_FONT_SIZE);
		// canvas.text("!-BattleSystem-!", width/2 , BIG_FONT_SIZE + EDGE_PADDING);
	}

	private void console(){
		canvas.stroke(255);
		canvas.fill(255);
		canvas.textAlign(CENTER);
		canvas.textFont(SMALL_FONT);
		canvas.textSize(SMALL_FONT_SIZE);
		// canvas.text(battleSystem.getText(), width/2 , EDGE_PADDING * 4);
		canvas.text(battleSystem.getText(), width/2 , height/2);
	}

	private void timer(){
		int timerUpdate = ceil(battleSystem.timer / 1000)+1;
		if (timerUpdate != timerCounter){
			timerCounter = timerUpdate;
			timerSize = BIG_FONT_SIZE;
			timerAlpha = 255;
			timerSzAni = new Ani(this, 0.5, "timerSize", 500, Ani.EXPO_IN);
			timerAlAni = new Ani(this, 0.5, "timerAlpha", 0, Ani.EXPO_IN);
			
			// println("second");
		}
		canvas.pushMatrix();
		canvas.pushStyle();
		canvas.noStroke();
		canvas.textAlign(CENTER,CENTER);
		canvas.textFont(BIG_FONT);
		canvas.fill(255,0);
		canvas.fill(255,timerAlpha);
		canvas.textSize(timerSize);
		canvas.text(timerCounter, width/2 , -40 + EDGE_PADDING * 4);
		canvas.fill(255);
		canvas.textSize(BIG_FONT_SIZE);
		canvas.text(timerCounter, width/2 , -40 + EDGE_PADDING * 4);
		canvas.popMatrix();
		canvas.popStyle();
	}


	public void displayPlayer(BasicPlayer _player,boolean reverse){
		canvas.pushMatrix();
		canvas.pushStyle();
		
		//if ( battleSystem.getState() == BATTLE_RESULT ) {
			int g1 = color(255,0,0);
			int gr = floor(map(_player.getHitPoints(), 0, FULL_HEALTH, 0, 255));
			int g2 = color(255,gr,0);

			canvas.stroke(255);
			canvas.textFont(SMALL_FONT);
			canvas.textSize(SMALL_FONT_SIZE);
			canvas.fill(255);
			canvas.text(_player.getName(), 0,0);
			canvas.translate(0,10);
			canvas.fill(255);
			int posXHBar = reverse ? 50-HEALTHBAR_WIDTH : -50;
			canvas.rect(posXHBar-1, -1, FULL_HEALTH*(HEALTHBAR_RATIO)+2,HEALTHBAR_HEIGHT+2);
			if (reverse) {
				setGradient(floor(posXHBar+(HEALTHBAR_WIDTH-(_player.getHitPoints()*HEALTHBAR_RATIO))), 0, _player.getHitPoints()*(HEALTHBAR_RATIO),HEALTHBAR_HEIGHT, g2, g1, X_AXIS, canvas);
			}else{
				setGradient(posXHBar, 0, _player.getHitPoints()*(HEALTHBAR_RATIO),HEALTHBAR_HEIGHT, g1, g2, X_AXIS, canvas);
			}
			canvas.translate(0,-5);
		//}
		canvas.translate(0,SMALL_FONT_SIZE);
		if (_player.spCount>0) {
			canvas.textSize(BIG_FONT_SIZE);
			canvas.text("S",0,HEALTHBAR_HEIGHT*2);	
		}
		// canvas.text(str(_player.getHitPoints())+" HP", 0,0);
		canvas.fill(0);

		canvas.translate(0,EDGE_PADDING * 2);

		if(battleSystem.getState()==WPSEL){
			ArrayList<BasicWeapon> _weapons = _player.getWeapons();
			for(BasicWeapon _w : _weapons){
					displayWeapon(_w, _player.getSelectedWeapon() == _w, reverse);
					canvas.translate(0, ICON_SIZE+20);
			}
		}

		canvas.popStyle();
		canvas.popMatrix();
		

	}

	public void displayWeapon(BasicWeapon _weapon, boolean _sel, boolean reverse){

		canvas.noStroke();
		if(!_weapon.isUseable()) canvas.fill(UNAVAILABLE_COLOR);
		else if(!_weapon.isLoaded()) canvas.fill(LOADING_COLOR);
		else canvas.fill(LOADED_COLOR);
		int iconPosX,posX;

		if (reverse) {
			if(_sel){
				iconPosX = -20-floor(ICON_SIZE*1.5);
				posX = -5-(ICON_SIZE/2);
			}else{
				iconPosX = 200;
				posX = 200;
			}
		}else{
			if (_sel) {
				iconPosX =  20+(ICON_SIZE/2);
				posX = 5+(ICON_SIZE/2);
			}else{
				iconPosX = -200;
				posX = -200;
			}
		}


		float dIconPosX = iconPosX-_weapon.iconPosX;
		_weapon.iconPosX += floor(dIconPosX*0.2);
		float dPosX = posX-_weapon.posX;
		_weapon.posX += floor(dPosX*0.2);
		// canvas.rect(_weapon.iconPosX, -ICON_SIZE/2, ICON_SIZE, (float)ICON_SIZE * _weapon.getLoadingProgress());
		canvas.noFill();
		canvas.strokeWeight(4);
		canvas.stroke(_sel ? color(100,10, 50) : color(100,0, 50));
		// canvas.rect(_weapon.iconPosX, -ICON_SIZE/2, ICON_SIZE, ICON_SIZE);
		// canvas.shape(_weapon.getIcon(),_weapon.iconPosX , -ICON_SIZE/2);
		canvas.textFont(SMALL_FONT);
		canvas.textSize(SMALL_FONT_SIZE);
		if(reverse){
			canvas.textAlign(LEFT);
		}else{
			canvas.textAlign(RIGHT);
		}
		canvas.fill(_sel ? color(255,255, 0) : color(255,255,255));
		if(!_weapon.isUseable()) canvas.fill(color(100,100,100));
		canvas.text(_weapon.name, reverse ? _weapon.posX-10:_weapon.posX, 10);
		canvas.fill(255,150,150);
		canvas.text("Att: "+_weapon.getAttackStrengthString(), reverse ? _weapon.posX-10:_weapon.posX, 30);
		canvas.fill(150,150,255);
		canvas.text("Def: "+_weapon.getDefenseStrengthString(), reverse ? _weapon.posX-10:_weapon.posX, 50);

	}

	public void	displayEffects (){
		if(battleSystem.getState() == PRE_WPSEL){
			boolean attackerP1 = battleSystem.attackingPlayer == battleSystem.players[0] ? true : false;
			float offsetX = attackerP1 ? (width/2)-(EDGE_PADDING*2.5) : (width/2)+(EDGE_PADDING*2);
			float offsetY = (height/2)-(EDGE_PADDING*2);
			float energyRadius = map(battleSystem.timer, 0, START_BATTLE_TIMER, 0, 1024);
			int energyAlpha = floor(map(battleSystem.timer, START_BATTLE_TIMER, 0, 0, 255));
			float a = 0.0;
			float inc = TWO_PI/ENERGY_BALLS;
			float spiralOffset = frameCount*0.1;
			//Show particles for attacking player
			for (int i = 0; i < ENERGY_BALLS; ++i) {
				int xPos = floor(offsetX+cos(a+spiralOffset)*energyRadius);
				int yPos = floor(offsetY+sin(a+spiralOffset)*energyRadius);
				image(energySprite,xPos,yPos);
				a = a + inc;
			}
			energyRadius = map(battleSystem.timer, 0, START_BATTLE_TIMER, 0, 800);
			spiralOffset = frameCount*0.2;
			if(attackerP1) tint(255,0,0,energyAlpha);
			else  tint(0,0,255,energyAlpha);
			for (int i = 0; i < ENERGY_BALLS; ++i) {
				int xPos = floor(offsetX+cos(a+spiralOffset)*energyRadius);
				int yPos = floor(offsetY+sin(a+spiralOffset)*energyRadius);
				image(energySprite,xPos,yPos);
				a = a + inc;
			}
			tint(255,255,255,255);
		}else if(battleSystem.getState() == BATTLE_ANIMATION){
			boolean attackerP1 = battleSystem.attackingPlayer == battleSystem.players[0] ? true : false;
			float offsetX = attackerP1 ? (width/2)-(EDGE_PADDING*2.5) : (width/2)+(EDGE_PADDING*2);
			float offsetY = (height/2)-(EDGE_PADDING*2);
			float energyRadius = map(battleSystem.timer, BATTLE_ANIM_TIMER, 0, 0, 1024);
			int energyAlpha = floor(map(battleSystem.timer, BATTLE_ANIM_TIMER, 0, 0, 255));
			float a = 0.0;
			float inc = TWO_PI/ENERGY_BALLS;
			float spiralOffset = frameCount*0.1;
			//Show particles for attacking player
			for (int i = 0; i < ENERGY_BALLS; ++i) {
				int xPos = floor(offsetX+cos(a+spiralOffset)*energyRadius);
				int yPos = floor(offsetY+sin(a+spiralOffset)*energyRadius);
				image(energySprite,xPos,yPos);
				a = a + inc;
			}
			energyRadius = map(battleSystem.timer, BATTLE_ANIM_TIMER, 0, 0, 2000);
			spiralOffset = frameCount*0.2;
			if(attackerP1) tint(255,0,0,energyAlpha);
			else  tint(0,0,255,energyAlpha);
			for (int i = 0; i < ENERGY_BALLS; ++i) {
				int xPos = floor(offsetX+cos(a+spiralOffset)*energyRadius);
				int yPos = floor(offsetY+sin(a+spiralOffset)*energyRadius);
				image(energySprite,xPos,yPos);
				a = a + inc;
			}
			tint(255,255,255,255);
		}
	}

	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    GUI Utils
	///////
	////////////////////////////////////////////////////////////////////////////////////

	private void progressBar(int _width, int _height, float _value){
		pushStyle();
		//rect(0,0);
	}

	public PGraphics getCanvas(){
		return canvas;
	}

	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    Initialisations
	///////
	////////////////////////////////////////////////////////////////////////////////////

	private void initPlayers(){

	}

	// private void loadWeaponIcons(){
	// 	weaponIcons = new PShape[WEAPON_COUNT];
	// 	weaponIcons[0] = loadShape("data/graphics/shoulderpad_icon.svg");
	// 	weaponIcons[1] = loadShape("data/graphics/foxmask_icon.svg");
	// 	weaponIcons[2] = loadShape("data/graphics/pendant_icon.svg");
	// 	weaponIcons[3] = loadShape("data/graphics/claws_icon.svg");
	// 	weaponIcons[4] = loadShape("data/graphics/ramhorns_icon.svg");
	// 	weaponIcons[5] = loadShape("data/graphics/tail_icon.svg");
	// 	weaponIcons[6] = loadShape("data/graphics/collar_icon.svg");
	// 	weaponIcons[7] = loadShape("data/graphics/cap_icon.svg");
	// 	weaponIcons[8] = loadShape("data/graphics/wings_icon.svg");
	// 	weaponIcons[9] = loadShape("data/graphics/antlers_icon.svg");

	// 	for(int i = 0; i < WEAPON_COUNT; i++){
	// 		weaponIcons[i].disableStyle();
	// 	}
	// }

	private void setGradient(int x, int y, float w, float h, color co1, color co2, int axis, PGraphics cv ) {

	  cv.noFill();

	  if (axis == Y_AXIS) {  // Top to bottom gradient
	    for (int i = y; i <= y+h; i++) {
	      float inter = map(i, y, y+h, 0, 1);
	      color c = lerpColor(co1, co2, inter);
	      cv.stroke(c);
	      cv.line(x, i, x+w, i);
	    }
	  }  
	  else if (axis == X_AXIS) {  // Left to right gradient
	    for (int i = x; i <= x+w; i++) {
	      float inter = map(i, x, x+w, 0, 1);
	      color c = lerpColor(co1, co2, inter);
	      cv.stroke(c);
	      cv.line(i, y, i, y+h);
	    }
	  }
	}

	private void resetTimerAni(){
		println("hit reset");
		timerSize = BIG_FONT_SIZE;
		timerAlpha = 255;
	}

}

class WeaponView {
	public WeaponView(){

	}

	public void displayWeapon(BasicWeapon _bw){

	}
}


// This class displays a weapon icon on screen with various information
class GUIWeaponView extends WeaponView{
	final color LOADED_COLOR = color(0, 255, 0);
	final color LOADING_COLOR = color(255, 255, 0);
	final color UNAVAILABLE_COLOR = color(100,100,100);
	final int ICON_SIZE = 64;

	
	final int WEAPON_COUNT = 10;
	PShape[] weaponIcons;

	public GUIWeaponView(){
		super();
		loadIcons();
	}

	// takes a PGraphics
	public void display(PGraphics _pg, PVector _loc, BasicWeapon _wp){

	}

	private void loadIcons(){
		weaponIcons = new PShape[WEAPON_COUNT];
		weaponIcons[0] = loadShape("/data/graphics/shoulderpad_icon.svg");
		weaponIcons[1] = loadShape("/data/graphics/foxmask_icon.svg");
		weaponIcons[2] = loadShape("/data/graphics/pendant_icon.svg");
		weaponIcons[3] = loadShape("/data/graphics/claws_icon.svg");
		weaponIcons[4] = loadShape("/data/graphics/ramhorns_icon.svg");
		weaponIcons[5] = loadShape("/data/graphics/tail_icon.svg");
		weaponIcons[6] = loadShape("/data/graphics/collar_icon.svg");
		weaponIcons[7] = loadShape("/data/graphics/cap_icon.svg");
		weaponIcons[8] = loadShape("/data/graphics/wings_icon.svg");
		weaponIcons[9] = loadShape("/data/graphics/antlers_icon.svg");

		for(int i = 0; i < WEAPON_COUNT; i++){
			weaponIcons[i].disableStyle();
		}
	}

}