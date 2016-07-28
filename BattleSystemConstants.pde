
/******************************************/
/*										  */
/* A place to store all of our constants! */
/*										  */
/******************************************/

public interface BattleSystemConstants {
	// public final float VERSION = 0.1;

	// public final HashMap<String, Interger> WEAPON_HASHMAP;

	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    GENERAL DATA
	///////
	////////////////////////////////////////////////////////////////////////////////////
	

	//Gamestates

	final int NULL_STATE      = 0;
	final int SETUP_STATE     = 1;
	final int PRE_SKILLTEST   = 2;
	final int SKILLTEST_INTRO = 3;
	final int SKILLTEST       = 4;
	final int PRE_WPSEL       = 5;
	final int WPSEL           = 6;
	final int BATTLE          = 7;
	final int BATTLE_RESULT   = 8;
	final int BATTLE_ANIMATION   = 9;
	final int SP_ANIMATION = 10;

	final int UNUSED_POWER    = 0;
	final int ACTIVE_POWER    = 1;
	final int USED_POWER      = 2;

	//Puredata Monitor

	final String PD_MON_IP = "127.0.0.1";
	final int PD_MON_PORT = 5555;
	final boolean USE_PD_MON = false;
	final boolean USE_COSTUMES = true;
	final boolean USE_SCREEN = true;

	// XOSC

	final boolean USE_XOSC = true;
	final String XOSC_P1_IP = "172.30.130.16";
	final int XOSC_P1_PORT = 9000;
	final String XOSC_P2_IP = "172.30.130.15";
	final int XOSC_P2_PORT = 9000;


	// VARS

	final float F_SKILL_ENERGY = 0.07;
	final float F_SPECIAL_INC_EXTRA = 0.001;
	final float F_SPECIAL_INC = 0.00001;

	final int  MAX_ATT_PW = 63;
	final int  MAX_DEF_PW = 63;


/*
    GUI
*/


	/******** GENERAL ********/

	final int SCREEN_WIDTH = 1280;
	final int SCREEN_HEIGHT = 720;

	final int BIG_FONT_SIZE = 48;
	final int SMALL_FONT_SIZE = 24;

	final int EDGE_PADDING = 52;
	final int ICON_SIZE = 64;

	/******** PLAYERS ********/
	// final color[] playerColors = {
	// 	color(218, 100, 247),
	// 	color(200, 255, 91)};

	/******** WEAPONS ********/
	// final color LOADED_COLOR = color(0, 200, 0);
	// final color LOADING_COLOR = color(255, 50, 0);
	// final color UNAVAILABLE_COLOR = color(100,100,100);
	final int WEAPON_ICON_SIZE = 64;
	final int WEAPON_COUNT = 10;

	/****** TIMER ******/
	final int SKILLTEST_TIMER = 3000;
	final int START_BATTLE_TIMER = 4000;
	final int WPSEL_TIMER = 15000;
	final int SP_ANIM_TIMER = 2000;
	final int BATTLE_ANIM_TIMER = 2000;
	final int BATTLE_RESULT_TIMER = 8000;


	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    PLAYER DATA
	///////
	////////////////////////////////////////////////////////////////////////////////////

	// final color[] PLAYER_COLORS = {
	// 	color(233, 45, 12),
	// 	color(22, 233, 12)};
	
	// full health value
	final int FULL_HEALTH = 100;
	final int HEALTHBAR_WIDTH = 400;
	final int HEALTHBAR_HEIGHT = SMALL_FONT_SIZE + 4;
	final float HEALTHBAR_RATIO = HEALTHBAR_WIDTH / FULL_HEALTH;

	//Weapon Colors
	final int WEAPON_FULL_R = 0;
	final int WEAPON_FULL_G = 255;
	final int WEAPON_FULL_B = 127;
	final int WEAPON_USED_R = 255;
	final int WEAPON_USED_G = 0;
	final int WEAPON_USED_B = 255;
	final int WEAPON_EMPTY_R = 255;
	final int WEAPON_EMPTY_G = 0;
	final int WEAPON_EMPTY_B = 0;



	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    WEAPON DATA
	///////
	////////////////////////////////////////////////////////////////////////////////////
	// final String SHOULDERPAD_ICON = "data/graphics/shoulderpad_icon.svg";
	final String SHOULDERPAD_ICON = "data/graphics/placeholder.svg";
	final int SHOULDERPAD_LOADING_TIME = 2000;
	final int SHOULDERPAD_DEFENSE_STRENGTH = 12;
	final int SHOULDERPAD_ATTACK_STRENGTH = 38;
	final int SHOULDERPAD_MAXUSE = 2;

	// final String FOXMASK_ICON = "data/graphics/foxmask_icon.svg";
	final String FOXMASK_ICON = "data/graphics/placeholder.svg";
	final int FOXMASK_LOADING_TIME = 2000;
	final int FOXMASK_DEFENSE_STRENGTH = 40;
	final int FOXMASK_ATTACK_STRENGTH = 35;
	final int FOXMASK_MAXUSE = 2;

	// final String PENDANT_ICON = "data/graphics/pendant_icon.svg";
	final String PENDANT_ICON = "data/graphics/placeholder.svg";
	final int PENDANT_LOADING_TIME = 2000;
	final int PENDANT_DEFENSE_STRENGTH = 28;
	final int PENDANT_ATTACK_STRENGTH = 9;
	final int PENDANT_MAXUSE = 2;

	// final String CLAWS_ICON = "data/graphics/claws_icon.svg";
	final String CLAWS_ICON = "data/graphics/placeholder.svg";
	final int CLAWS_LOADING_TIME = 2000;
	final int CLAWS_DEFENSE_STRENGTH = 16;
	final int CLAWS_ATTACK_STRENGTH = 19;
	final int CLAWS_MAXUSE = 2;
//---------
	// final String RAMHORNS_ICON = "data/graphics/ramhorns_icon.svg";
	final String RAMHORNS_ICON = "data/graphics/placeholder.svg";
	final int RAMHORNS_LOADING_TIME = 2000;
	final int RAMHORNS_DEFENSE_STRENGTH = 16;
	final int RAMHORNS_ATTACK_STRENGTH = 3;
	final int RAMHORNS_MAXUSE = 2;

	// final String TAIL_ICON = "data/graphics/tail_icon.svg";
	final String TAIL_ICON = "data/graphics/placeholder.svg";
	final int TAIL_LOADING_TIME = 2000;
	final int TAIL_DEFENSE_STRENGTH = 8;
	final int TAIL_ATTACK_STRENGTH = 58;
	final int TAIL_MAXUSE = 2;

	// final String COLLAR_ICON = "data/graphics/collar_icon.svg";
	final String COLLAR_ICON = "data/graphics/placeholder.svg";
	final int COLLAR_LOADING_TIME = 2000;
	final int COLLAR_DEFENSE_STRENGTH = 16;
	final int COLLAR_ATTACK_STRENGTH = 53;
	final int COLLAR_MAXUSE = 2;

	// final String CAP_ICON = "data/graphics/cap_icon.svg";
	final String CAP_ICON = "data/graphics/placeholder.svg";
	final int CAP_LOADING_TIME = 2000;
	final int CAP_DEFENSE_STRENGTH = 12;
	final int CAP_ATTACK_STRENGTH = 38;
	final int CAP_MAXUSE = 2;
//-----------------
	// final String WINGS_ICON = "data/graphics/wings_icon.svg";
	final String WINGS_ICON = "data/graphics/placeholder.svg";
	final int WINGS_LOADING_TIME = 2000;
	final int WINGS_DEFENSE_STRENGTH = 12;
	final int WINGS_ATTACK_STRENGTH = 13;
	final int WINGS_MAXUSE = 2;
	
	// final String ANTLERS_ICON = "data/graphics/antlers_icon.svg";
	final String ANTLERS_ICON = "data/graphics/placeholder.svg";
	final int ANTLERS_LOADING_TIME = 2000;
	final int ANTLERS_DEFENSE_STRENGTH = 12;
	final int ANTLERS_ATTACK_STRENGTH = 34;
	final int ANTLERS_MAXUSE = 2;


	//Sprites
	final String SPRITE_ENERGY_PATH = "data/graphics/energyBall.png";

}
