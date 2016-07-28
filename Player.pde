class BasicPlayer implements BattleSystemConstants {
	// character name?
	String name;

	//Special power name
	String spName;

	// hitpoints
	int hitPoints;
	
	// osc pairing
	String ip;
	int port;

	// player's weapons
	ArrayList<BasicWeapon> weapons;

	// player can pick 
	BasicWeapon selectedWeapon;

	// the player's opponent
	BasicPlayer opponent;

	// Color
	String mainColor;
	String secondaryColor;
	// mental strength
	float psychi;

	// bonus can be set by doing well on skilltest
	boolean usingSp = false;
	int spCount = 0;
	float spBar = 0.0;

	// store how many skilltest they have won
	int skilltestWins;
	// skilltest float, bonus or nonus
	float skillTestValue;
	
	int playerIndex;

	//GSR
	float[] gsrRawBuffer;
	float[] gsrProcessedBuffer;
	float gsrMastered;



	//Using Super Power

	/**
	 * Constructor, init weapons
	 */
	public BasicPlayer(){
		weapons = new ArrayList();
		init();
		opponent = null;
		ip = "0";
		port = 0;
		psychi = 0.75;
		skillTestValue = 0;
		gsrRawBuffer = new float[50];
		gsrProcessedBuffer = new float[500];
	}


	/**
	 * Function to call at the begining of a match
	 */
	public void init(){
		println( name + "init");
		hitPoints = FULL_HEALTH;
		spCount = 1;
		for(BasicWeapon weapon : weapons) weapon.init();
	}


	/////////////////////////////////////////////////////////////////////////////
	/////////////////////////////PLAYER ACTIONS//////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////


	// public void attackOpponent(int _w){
	// 	// pick weapon
	// 	BasicWeapon _wp = getWeapon(_w);
	// 	if(_wp == null) return;
	// 	_wp.attack(opponent);
	// }

	/**
	 * Here goes the player's special power. Like gain health.
	 * Revive a weapon.
	 * 
	 */
	public boolean specialPower(){
		// if(selectedWeapon == null) return;
		if(spCount > 0){
			usingSp = true;
			println(name+" used SpecialPower");
			spCount--;
			return true;
		}else{
			return false;
		}
	}

	public void receiveAttack(int _damage){
		hitPoints -= constrain(_damage, 0, FULL_HEALTH);
	}

	public void useWeapon(){
		if(getSelectedWeapon() == null) return;
		getSelectedWeapon().use();
	}

	// public void attack(BasicPlayer _p){
	// 	if(getSelectedWeapon() == null) return;
	// 	getSelectedWeapon().attack(_p);
	// }

	public void updateGSR(float rawVal){
		gsrRawBuffer = arrayPush(rawVal,gsrRawBuffer);
		float gsrMaster = 1.0 - arrayAverage(gsrRawBuffer);
		gsrMaster = gsrMaster * -1;
		if(gsrMaster < 0) gsrProcessedBuffer = arrayPush(gsrMaster, gsrProcessedBuffer); //only the greater than average values matter, shove the lesser than values down quick
		else gsrProcessedBuffer = arrayPush(gsrMaster, gsrProcessedBuffer);               //array for determining an average GSR over time
		float gsrAv = arrayAverage(gsrProcessedBuffer);        
		gsrMastered = gsrMaster - gsrAv;   
	}


	
	public float getGSR() {
		float mapped = constrain(gsrMastered,-1.0,1.0);
		// println("Player " + name + " mapped gsr value is: " + mapped);
		return mapped;
	}

	public void pushSkill(float amt){
		setSkill(getSkill() + amt);
	}

	public void updateSpecial() {
		if (getGSR()>0) {
			setSpBar(spBar+F_SPECIAL_INC_EXTRA);
		}else {
			setSpBar(spBar+F_SPECIAL_INC);
		}
	}


	/////////////////////////////////////////////////////////////////////////////
	////////////////////////////////WEAPON///////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////


	public void loadWeapon(BasicWeapon _weapon){
		weapons.add(_weapon);
		println(_weapon.name + " loaded for " + name);
	}

	public void selectWeapon(int _i){
		try{
			if(_i <= 0 || !getWeapon(_i-1).isUseable()) selectedWeapon = null;
			else selectedWeapon = getWeapon(_i-1);
			if(selectedWeapon == null){
				println("No weapon selected for " + name);
			}

				println(name + " selects " + selectedWeapon.name);
		}
		catch (Exception e) {
			println("Error selecting weapon: "+_i);
		}
	}
	public void selectWeaponUp(){
		try{
			boolean found = false;
			int current = weapons.indexOf(getSelectedWeapon());
			while(!found){
				current--;
				println("checking "+current);
				if (current < 0){
					current = weapons.size();
					println("current is: " + current + " , " + "weaponssize is: " + weapons.size());
				}else if(getWeapon(current).isUseable()){
					selectWeapon(current+1);
					found = true;
				}
			}
			println(name + " selectsUp " + selectedWeapon.name);
		}
		catch (Exception e) {
			println(e);
		}
	}
	public void selectWeaponDown(){
		try{
			boolean found = false;
			int current = weapons.indexOf(getSelectedWeapon());
			while(!found){
				current++;
				println("checking "+current);
				if (current > weapons.size()-1){
					current = -1;
					println("current is: " + current + " , " + "weaponssize is: " + weapons.size());
				}else if(getWeapon(current).isUseable()){
					selectWeapon(current+1);
					found = true;
				}
			}
			println(name + " selectsDown " + selectedWeapon.name);
		}
		catch (Exception e) {
			println(e);
		}
	}

	public BasicWeapon getWeapon(int _i){
		if(_i >= weapons.size() || _i < 0) return null;
		else return weapons.get(_i);
	}

	public ArrayList<BasicWeapon> getWeapons(){
		return weapons;
	}

	public BasicWeapon getSelectedWeapon(){
		return selectedWeapon;
	}

	private void addSpUse() {
		spCount += 1;
		//TriggerSound and Lighting for SpUse
	}


	/////////////////////////////////////////////////////////////////////////////
	////////////////////////////////MODIFIERS////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////



	public void setOpponent(BasicPlayer _pl){
		opponent = _pl;
	}

	public void setSkill(float _f){
		skillTestValue = _f;
		skillTestValue = constrain(skillTestValue,0.001,1.0);
	}

	public void setSpBar(float _f){
		spBar = _f;
		spBar = constrain(spBar,0.0000000000000001,1.0);
		if (spBar == 1.0) {
			addSpUse();
			spBar = 0.0;
		}
	}

	public float getSpBar(){
		return spBar;
	}

	public void setIPaddr(String _ip, int _port){
		 ip = _ip;
		 port = _port;
		 println( name + " is paired to " + ip + ", " + port);
	}



	/////////////////////////////////////////////////////////////////////////////
	////////////////////////////////ACCESSORS////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////



	public int getDefenseStrength(){
		if(getSelectedWeapon() == null) return 0;
		return getSelectedWeapon().getDefenseStrength();
	}

	public int getAttackStrength(){
		if(getSelectedWeapon() == null) return 0;
		return getSelectedWeapon().getAttackStrength();
	}

	public float getDefenseStrengthN(){
		if(getSelectedWeapon() == null) return 0.0;
		return (float)getSelectedWeapon().getDefenseStrength() / (float)MAX_DEF_PW;
	}

	public float getAttackStrengthN(){
		if(getSelectedWeapon() == null) return 0.0;
		return (float)getSelectedWeapon().getAttackStrength() / (float)MAX_ATT_PW;
	}


	public boolean isAlive(){
		return (hitPoints > 0);
	}

	public boolean isPaired(){
		return ip != "0";
	}

	public int getHitPoints(){
		return hitPoints;
	}

	public float getSkill(){
		return skillTestValue;
	}

	public int getSkilltestWins(){
		return skilltestWins;
	}

	public float getHealth(){
		return float(getHitPoints())/float(FULL_HEALTH);
	}

	public String getColor(){
		return mainColor;
	}

	public String getName(){
		return name;
	}

	public boolean hasWeapons(){
		boolean out = false;
		for (BasicWeapon weapon : weapons) {
				if (weapon.isUseable()) out = true;

		}
		return out;
	}
}



/////////////////////////////////////////////////////////////////////////////
/////////////////////////////  Characters  //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

class DefensivePlayer extends BasicPlayer {
	public DefensivePlayer(){
		super();
		name = "Ludic";
		spName = "Mirror";
		loadWeapon(new HeadPiece());
		loadWeapon(new Collar());
		loadWeapon(new Bracelet());
		loadWeapon(new Corset());
		mainColor = "blue";
		secondaryColor= "white";
	}

	// public void attackOpponent(int _wp){
	// 	super.attackOpponent(_wp);
	// 	// special powers go here
	// }
}


class MajesticPlayer extends BasicPlayer {
	public MajesticPlayer(){
		super();
		name = "Fierce";
		spName = "Rage";
		loadWeapon(new ShoulderPad());
		loadWeapon(new Hammer());
		loadWeapon(new SpikeCollar());
		loadWeapon(new Helmet());
		mainColor = "red";
		secondaryColor= "yellow";
	}

}

// TODO: external loading