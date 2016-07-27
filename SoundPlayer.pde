import ddf.minim.*;

class SoundPlayer implements BattleSystemConstants {

	BattleSystem battleSystem;
	AudioPlayer preskillPlayer;
	AudioPlayer wpselPlayer;	
	AudioPlayer battleresultPlayer;
	AudioSample skilltestSound;
	AudioSample skilltestSoundE;
	AudioSample toggleOKSound;
	AudioSample spSelectSound;
	AudioSample spAniSound;
	AudioSample attackSound;
	AudioSample damageSound;
	AudioSample defenseSound;
	AudioSample gameOverSound;

	public SoundPlayer(Minim minim) {
    	preskillPlayer = minim.loadFile("sounds/272038__setuniman__expecting-1l52.wav");
    	wpselPlayer = minim.loadFile("sounds/battle.wav");
    	battleresultPlayer = minim.loadFile("sounds/wpselect.wav");
    	skilltestSound = minim.loadSample("sounds/skilltest.wav", 512);
    	skilltestSoundE = minim.loadSample("sounds/AvatrixSkilltestE.wav", 512);
    	toggleOKSound = minim.loadSample("sounds/a_5_.wav", 512);
    	spSelectSound = minim.loadSample("sounds/manger.wav", 512);
    	spAniSound = minim.loadSample("sounds/sp_ani.wav", 512);
    	attackSound = minim.loadSample("sounds/attack.wav", 512);
    	damageSound = minim.loadSample("sounds/damage.wav", 512);
    	defenseSound = minim.loadSample("sounds/defense.wav", 512);
    	gameOverSound = minim.loadSample("sounds/gameover.wav", 512);
    	preskillPlayer.setGain(-10.0);
    	wpselPlayer.setGain(-10.0);
    	battleresultPlayer.setGain(10.0);
    	skilltestSound.setGain(10.0);
    	toggleOKSound.setGain(-30.0);
    	spAniSound.setGain(0.0);
	}
	
	public void playAudio() {
		if ( preskillPlayer.position() == preskillPlayer.length() )
		{
			preskillPlayer.rewind();
		}
		if ( wpselPlayer.position() == wpselPlayer.length() )
		{
			wpselPlayer.rewind();
		}
		if ( battleresultPlayer.position() == battleresultPlayer.length() )
		{
			battleresultPlayer.rewind();
		}
		if(battleSystem.getState() == PRE_SKILLTEST)
		{
			battleresultPlayer.pause();
			preskillPlayer.play();
		}
		if(battleSystem.getState() == WPSEL)
		{
			wpselPlayer.play();
		}
		if(battleSystem.getState() == BATTLE_ANIMATION || battleSystem.getState() == BATTLE_RESULT )
		{
			wpselPlayer.pause();
			battleresultPlayer.play();
			if(battleSystem.triggerAttackSound == true) {
				battleSystem.triggerAttackSound = false;
				attackSound.trigger();
			}
			if(battleSystem.triggerDamageSound == true && battleSystem.timer < 1000) {
				battleSystem.triggerDamageSound = false;
				damageSound.trigger();
			}
			if(battleSystem.triggerDefenseSound == true && battleSystem.timer < 1000) {
				battleSystem.triggerDefenseSound = false;
				defenseSound.trigger();
			}
		}
		if(battleSystem.getState() == SP_ANIMATION)
		{
			if(battleSystem.triggerSpAniSound == true) {
				battleSystem.triggerSpAniSound = false;
				spAniSound.trigger();
			}
		}
		if(battleSystem.triggerSkill == true) {
			battleSystem.triggerSkill = false;
			preskillPlayer.pause();
			preskillPlayer.rewind();
			skilltestSound.trigger();
		}
		if(battleSystem.triggerSkillE == true) {
			battleSystem.triggerSkillE = false;
			skilltestSoundE.trigger();
		}
		if(battleSystem.toggleOKSound == true) {
			battleSystem.toggleOKSound = false;
			toggleOKSound.trigger();
		}
		if(battleSystem.triggerSpSound == true) {
			battleSystem.triggerSpSound = false;
			spSelectSound.trigger();
		}
		if(battleSystem.triggerGameOverSound == true) {
			battleSystem.triggerGameOverSound = false;
			gameOverSound.trigger();
		}


	}
	public void injectBattleSystem(BattleSystem _bs){
		battleSystem = _bs;
	}

}