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
  AudioSample vo_SPT_Ludic;
  AudioSample vo_SPT_Fierce;
  AudioSample vo_SPF_Ludic;
  AudioSample vo_SPBoth;
  AudioSample vo_SPS_Fierce;
  AudioSample vo_SPS_Ludic;
  AudioSample vo_ST_Fierce;
  AudioSample vo_ST_Ludic;
  AudioSample vo_WS_First;
  AudioSample vo_WS_Then;
  AudioSample vo_AF_Ludic;
  AudioSample vo_AF_Fierce;
  AudioSample vo_AS_Ludic;
  AudioSample vo_AS_Fierce;
  AudioSample vo_FRR_Ludic;
  AudioSample vo_FRR_Fierce;
  AudioSample vo_Intro_04;
  AudioSample vo_Intro_01;
  
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
      vo_SPT_Ludic = minim.loadSample("sounds/Vo_SPT_01.mp3", 512);
      vo_SPT_Fierce = minim.loadSample("sounds/Vo_SPT_02.mp3", 512);
      vo_SPF_Ludic = minim.loadSample("sounds/Vo_SPF_01.mp3", 512);
      vo_SPBoth = minim.loadSample("sounds/Vo_SPBoth_01.mp3", 512);
      vo_SPS_Fierce = minim.loadSample("sounds/Vo_SPS_02.mp3", 512);
      vo_SPS_Ludic = minim.loadSample("sounds/Vo_SPS_01.mp3", 512);
      vo_ST_Ludic = minim.loadSample("sounds/Vo_ST_01.mp3", 512);
      vo_ST_Fierce = minim.loadSample("sounds/Vo_ST_02.mp3", 512);
      vo_WS_First = minim.loadSample("sounds/Vo_WS_01.mp3", 512);
      vo_WS_Then = minim.loadSample("sounds/Vo_WS_02.mp3", 512);
      vo_AF_Ludic = minim.loadSample("sounds/Vo_AF_01.mp3", 512);
      vo_AF_Fierce = minim.loadSample("sounds/Vo_AF_02.mp3", 512);
      vo_AS_Ludic = minim.loadSample("sounds/Vo_AS_01.mp3", 512);
      vo_AS_Fierce = minim.loadSample("sounds/Vo_AS_02.mp3", 512);
      vo_FRR_Ludic = minim.loadSample("sounds/Vo_FRR_01.mp3", 512);
      vo_FRR_Fierce = minim.loadSample("sounds/Vo_FRR_02.mp3", 512);
      vo_Intro_04 = minim.loadSample("sounds/Vo_Intro_04.mp3", 512);
      vo_Intro_01 = minim.loadSample("sounds/Vo_Intro_01.mp3", 512);
       
    	preskillPlayer.setGain(-10.0);
    	wpselPlayer.setGain(-10.0);
    	battleresultPlayer.setGain(10.0);
    	skilltestSound.setGain(10.0);
    	toggleOKSound.setGain(-30.0);
    	spAniSound.setGain(0.0);
	}
	
	public void playAudio() {
    if(battleSystem.triggerFRRLudicSound == true) {
        battleSystem.triggerFRRLudicSound = false;
        vo_FRR_Ludic.trigger();
    }
     if(battleSystem.triggerFRRFierceSound == true) {
        battleSystem.triggerFRRFierceSound = false;
        vo_FRR_Fierce.trigger();
    }    
     if(battleSystem.triggerASLudicSound == true) {
        battleSystem.triggerASLudicSound = false;
        vo_AS_Ludic.trigger();
    }
     if(battleSystem.triggerASFierceSound == true) {
        battleSystem.triggerASFierceSound = false;
        vo_AS_Fierce.trigger();
    }
    if(battleSystem.triggerWS_ == true) {
        if (battleSystem.triggerFirstTime){
        battleSystem.triggerWS_ = false;
        vo_WS_First.trigger();
      } else {
        battleSystem.triggerWS_ = false;
        vo_WS_Then.trigger();
      }
    }
    if(battleSystem.triggerAFLudicSound == true) {
        battleSystem.triggerAFLudicSound = false;
        vo_AF_Ludic.trigger();
    }
    if(battleSystem.triggerAFFierceSound == true) {
        battleSystem.triggerAFFierceSound = false;
        vo_AF_Fierce.trigger();
    }
    if(battleSystem.triggerSTFierceSound == true) {
        battleSystem.triggerSTFierceSound = false;
        vo_ST_Fierce.trigger();
    }
    if(battleSystem.triggerSTLudicSound == true) {
        battleSystem.triggerSTLudicSound = false;
        vo_ST_Ludic.trigger();
    }
    if(battleSystem.triggerSPF_LudicSound == true) {
        battleSystem.triggerSPF_LudicSound = false;
        vo_SPF_Ludic.trigger();
    }
    if(battleSystem.triggerSPBothSound == true) {
        battleSystem.triggerSPBothSound = false;
        vo_SPBoth.trigger();
    }
    if(battleSystem.triggerSPSLudicSound == true) {
        battleSystem.triggerSPSLudicSound = false;
        vo_SPS_Ludic.trigger();
    }
    if(battleSystem.triggerSPSFierceSound == true) {
        battleSystem.triggerSPSFierceSound = false;
        vo_SPS_Fierce.trigger();
    }
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
      if(battleSystem.triggerIntro4Sound == true) {
         battleSystem.triggerIntro4Sound = false;
         if (battleSystem.triggerFirstTime) {
             vo_Intro_01.trigger();
         } else { vo_Intro_04.trigger();
                }
       }
		}
		if(battleSystem.getState() == WPSEL)
		{
			wpselPlayer.play();
//
    if(battleSystem.triggerSPT_LudicSound == true) {
        battleSystem.triggerSPT_LudicSound = false;
        vo_SPT_Ludic.trigger();
      }
    if(battleSystem.triggerSPT_FierceSound == true) {
        battleSystem.triggerSPT_FierceSound = false;
        vo_SPT_Fierce.trigger();
      }
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
/* test son speciql power
    if(battleSystem.triggerSPT_LudicSound == true) {
        battleSystem.triggerSPT_LudicSound = false;
        vo_SPT_Ludic.trigger();
      }
    if(battleSystem.triggerSPT_FierceSound == true) {
        battleSystem.triggerSPT_FierceSound = false;
        vo_SPT_Fierce.trigger();
      }
      */
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