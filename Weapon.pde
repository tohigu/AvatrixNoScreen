
/**
 * Basic weapon template class
 */
class BasicWeapon implements BattleSystemConstants {
	// WeaponName
	String name;

	// how much defense
	int defenseStrength;
	// how much attack
	int attackStrength;

	// milliseconds for weapon to be functional after a use.
	int loadingTime;
	// timestamp from millis() of when weapon was last used.
	int lastUse;
	// maximum times the weapon can be used.
	int maxUse;
	// count everytime the weapon is used.
	int useCount;

	int bonus;

	int ledCount;

	int address;

	PShape icon;

	float iconPosX;
	float posX;


	public BasicWeapon(){
		// set the parameters such as name and stats in the constructor
	}

	/**
	 * Function to call at the begining of a match
	 */
	public void init(){
		println(name + " initialized!");
		useCount = 0;
		lastUse = 0;
		bonus = 0;
		iconPosX = 0;
		posX = 0;
	}


	public void setBonus(int _i){
		bonus += _i;
	}
	/**
	 * Attack function, move to attackWeapon subclass?
	 * this is where we process an attack, 
	 * special weapons could override to do special things to the player, like disable weapons or something
	 * @param player to attack
	 */
	public void use(){
		useCount++;
		lastUse = millis();
	}

	/**
	 * Returns if the weapon's loading process is complete.
	 * @return boolean is the weapon loaded
	 */
	public boolean isLoaded(){
		return millis()-lastUse >= loadingTime;
	}

	/**
	 * Returns if the weapon has been used too many times.
	 * @return boolean under maxUse
	 */
	public boolean isUseable(){
		return useCount < maxUse && isLoaded();
	}

	/**
	 * Returns if the weapon's loading process is complete.
	 * @return float a unit interval representing the progress of loading.
	 */
	public float getLoadingProgress(){
		float progress = float(millis()-lastUse) / float(loadingTime);
		return constrain(progress, 0.0, 1.0);
	}

	/**
	 * Returns the weapons defense strenght, perhaps this should be in a subclass of Defense weapons.
	 * @return int defense strength of weapon
	 */
	public int getDefenseStrength(){
		return defenseStrength;
	}
	
	public String getDefenseStrengthString(){
		String defenseStrengthStr = "";
		if (defenseStrength < 5){
			defenseStrengthStr = "LOW";
		}else if(defenseStrength >= 5 && defenseStrength < 10){
			defenseStrengthStr = "MEDIUM";
		}else if(defenseStrength >= 10){
			defenseStrengthStr = "HIGH";
		}

		return defenseStrengthStr;
	}

	/**
	 * Returns the weapons attack strenght, perhaps this should be in a subclass of attack weapons.
	 * @return int attack strength of weapon
	 */
	public int getAttackStrength(){
		return attackStrength + bonus;
	}

	public String getAttackStrengthString(){
		String attackStrengthStr = "";
		if (attackStrength < 5){
			attackStrengthStr = "LOW";
		}else if(attackStrength >= 5 && attackStrength < 10){
			attackStrengthStr = "MEDIUM";
		}else if(attackStrength >= 10){
			attackStrengthStr = "HIGH";
		}

		return attackStrengthStr;
	}

	public String getName(){
		return name;
	}

	public PShape getIcon(){
		return icon;
	}

}




	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    Weapone subclasses!
	///////
	////////////////////////////////////////////////////////////////////////////////////


class Corset extends BasicWeapon {

	public Corset(){
		name = "Tunic";
		loadingTime = SHOULDERPAD_LOADING_TIME;
		defenseStrength = SHOULDERPAD_DEFENSE_STRENGTH;
		attackStrength = SHOULDERPAD_ATTACK_STRENGTH;
		maxUse = SHOULDERPAD_MAXUSE;
		icon = loadShape(SHOULDERPAD_ICON);
		ledCount = 17;
		address = 4;

	}

}

class HeadPiece extends BasicWeapon {

	public HeadPiece(){
		name = "Head Piece";
		loadingTime = FOXMASK_LOADING_TIME;
		defenseStrength = FOXMASK_DEFENSE_STRENGTH;
		attackStrength = FOXMASK_ATTACK_STRENGTH;
		maxUse = FOXMASK_MAXUSE;
		icon = loadShape(FOXMASK_ICON);
		ledCount = 9;
		address = 1;

	}

}

class Collar extends BasicWeapon {

	public Collar(){
		name = "Collar";
		loadingTime = PENDANT_LOADING_TIME;
		defenseStrength = PENDANT_DEFENSE_STRENGTH;
		attackStrength = PENDANT_ATTACK_STRENGTH;
		maxUse = PENDANT_MAXUSE;
		icon = loadShape(PENDANT_ICON);
		ledCount = 22;
		address = 2;

	}

}
class Bracelet extends BasicWeapon {

	public Bracelet(){
		name = "Bracelet";
		loadingTime = CLAWS_LOADING_TIME;
		defenseStrength = CLAWS_DEFENSE_STRENGTH;
		attackStrength = CLAWS_ATTACK_STRENGTH;
		maxUse = CLAWS_MAXUSE;
		icon = loadShape(CLAWS_ICON);
		ledCount = 11;
		address = 3;

	}

}

//------

class ShoulderPad extends BasicWeapon {

	public ShoulderPad(){
		name = "Shoulder Pad";
		loadingTime = RAMHORNS_LOADING_TIME;
		defenseStrength = RAMHORNS_DEFENSE_STRENGTH;
		attackStrength = RAMHORNS_ATTACK_STRENGTH;
		maxUse = RAMHORNS_MAXUSE;
		icon = loadShape(RAMHORNS_ICON);
		ledCount = 16;
		address = 1;

	}

}

class SpikeCollar extends BasicWeapon {

	public SpikeCollar(){
		name = "Spike Collar";
		loadingTime = TAIL_LOADING_TIME;
		defenseStrength = TAIL_DEFENSE_STRENGTH;
		attackStrength = TAIL_ATTACK_STRENGTH;
		maxUse = TAIL_MAXUSE;
		icon = loadShape(TAIL_ICON);
		ledCount = 5;
		address = 3;

	}

}


class Helmet extends BasicWeapon {//Bracelet

	public Helmet(){
		name = "Bracelet";
		loadingTime = COLLAR_LOADING_TIME;
		defenseStrength = COLLAR_DEFENSE_STRENGTH;
		attackStrength = COLLAR_ATTACK_STRENGTH;
		maxUse = COLLAR_MAXUSE;
		icon = loadShape(COLLAR_ICON);
		ledCount = 3;
		address = 4;
	}

}

class Hammer extends BasicWeapon {//Knuckle spikes

	public Hammer(){
		name = "Knuckle Spikes";
		loadingTime = CAP_LOADING_TIME;
		defenseStrength = CAP_DEFENSE_STRENGTH;
		attackStrength = CAP_ATTACK_STRENGTH;
		maxUse = CAP_MAXUSE;
		icon = loadShape(CAP_ICON);
		ledCount = 3;
		address = 2;
	}

}


// /**
//  * MajesticWings
//  */
// class Wings extends BasicWeapon {

// 	public Wings(){
// 		name = "Wings";
// 		loadingTime = WINGS_LOADING_TIME;
// 		defenseStrength = WINGS_DEFENSE_STRENGTH;
// 		attackStrength = WINGS_ATTACK_STRENGTH;
// 		maxUse = WINGS_MAXUSE;
// 		icon = loadShape(WINGS_ICON);
// 	}

// }

// *
//  * Antlers
 
// class Antlers extends BasicWeapon {

// 	public Antlers(){
// 		name = "Antlers";
// 		loadingTime = ANTLERS_LOADING_TIME;
// 		defenseStrength = ANTLERS_DEFENSE_STRENGTH;
// 		attackStrength = ANTLERS_ATTACK_STRENGTH;
// 		maxUse = ANTLERS_MAXUSE;
// 		icon = loadShape(ANTLERS_ICON);
// 	}

// }
