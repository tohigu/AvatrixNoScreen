
class SuperPower implements BattleSystemConstants{

	final String description = "describe super power with text";

	// Super powers can do anything, therefore they are given the whole battle system, use cautiously
	BattleSystem battleSystem;
	// who has the superpower
	BasicPlayer powerOwner;
	// who will be victim of it
	BasicPlayer opponent;
	// status of the power
	int status;
	
	public SuperPower(BattleSystem _bs, BasicPlayer _a, BasicPlayer _b){	
		battleSystem = _bs;
		powerOwner = _a;
		opponent = _b;
		status = UNUSED_POWER;
	}

	/**
	 * power needs to be activated
	 */
	public void activate(){
	 	status = ACTIVE_POWER;
	}

	/**
	 * apply will be called every cycle. 
	 */
	public void apply(){
		if(status != ACTIVE_POWER) return;
	}

	public boolean isActive(){
		return (status == ACTIVE_POWER);
	}
} 



class SkillTestWinPower extends SuperPower{

	public SkillTestWinPower(BattleSystem _bs, BasicPlayer _a, BasicPlayer _b){
		super(_bs, _a, _b);
	}

	public void apply(){
		if(status != ACTIVE_POWER) return;
		// example code for skilltest win power
		// if(gameState == SKILL_STATE) {
		// 	battleSystem.setWinner(powerOwner);
		// 	status = USED_POWER;
		// }
	}
}