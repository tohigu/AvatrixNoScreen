class BattleSystem implements BattleSystemConstants {

	// array of players (2)
	BasicPlayer[] players;
	final int PLAYER_COUNT = 2;
	// references of players
	BasicPlayer selectedPlayer;
	BasicPlayer attackingPlayer;
	BasicPlayer defendingPlayer;
	Ani sceneAni;

	// what state the game is in
	int gameState;

	// the text that will appear on screen, use it to communicate things
	String textConsole = "";
	String gameOverText = "";

	// x-osc stuffs
	boolean oscPaired = false;
	

	boolean roundEndsGame = false;
	int timer = 0;
	int frameTime = 0;
	int timeDelta = 0;
	boolean statelock = false;
	int fadeLvl = 0;
	int flashLvl = 0;
	String bufferText;
	boolean newGame = false;
	boolean triggerSkill = false;
	boolean triggerSkillE = false;
	boolean toggleOKSound = false;
	boolean triggerSpSound = false;
	boolean triggerSpAniSound = false;
	boolean triggerAttackSound = false;
	boolean triggerDamageSound = false;
	boolean triggerDefenseSound = false;
	boolean triggerGameOverSound = false;
  //
  boolean triggerSPT_LudicSound = false;
  boolean triggerSPT_FierceSound = false;
  boolean triggerSPF_LudicSound = false;
  boolean triggerSPFLudicOK = false;
  boolean triggerSPLudic = false;
  boolean triggerSPFierce = false;
  boolean triggerSPBothSound = false;
  boolean triggerSPSFierceSound = false;
  boolean triggerSPSLudicSound = false;
  boolean triggerSTFierceSound = false;
  boolean triggerSTLudicSound = false;
  boolean triggerWS_ = false;
  boolean triggerAFFierceSound = false;
  boolean triggerAFLudicSound = false;
  boolean triggerAFFierceOK= false;
  boolean triggerAFLudicOK = false;
  boolean triggerFRRFierceSound = false;
  boolean triggerFRRLudicSound = false;
  boolean triggerASFierceSound = false;
  boolean triggerASLudicSound = false;
  boolean triggerASFierceOK= false;
  boolean triggerASLudicOK = false;
  boolean triggerIntroOK = true;
  boolean triggerIntro4Sound = false;
  //
  boolean triggerSkillResultSound = false;
  boolean triggerWeapSelSound = false;
  boolean triggerFirstTime = false;
  boolean triggerResultSound = true;
	//
  int winner = 0;

	int[] battleResult = {0, 0, 0, 0, 0, 0}; //[attackingPlayer(0-1),weaponP1(1-4),weaponP2(1-4),specialP1(0-1),specialP2(0-1),success(0-1)]



	public BattleSystem() {
		initPlayers();
		gameState = SETUP_STATE;//INTRO_STATE;// BATTLE_STATE;
		frameTime = millis();
	}

	private void initPlayers() {
		players    = new BasicPlayer[PLAYER_COUNT];
		players[0] = new MajesticPlayer();
		players[0].playerIndex = 0;
		players[1] = new DefensivePlayer();
		players[1].playerIndex = 1;
		players[0].setOpponent(players[1]);
		players[1].setOpponent(players[0]);
    triggerFirstTime = true;
	}

	public void update() {
		int now = millis();
		timeDelta = now - frameTime;
		frameTime = now;
		switch (gameState) {
		case SETUP_STATE:
			setup();
			break;
		case PRE_SKILLTEST:
			preSkill();
			break;
		// case SKILLTEST_INTRO:
		// 	skillIntro();
		// 	break;
		case SKILLTEST:
			skillTest();
			break;
		case PRE_WPSEL:
			startBattle();
			break;
		case WPSEL:
			weaponSelect();
			break;
		case BATTLE:
			battle();
			break;
		case SP_ANIMATION:
			spAnim();
			break;
		case BATTLE_ANIMATION:
			battleAnim();
			break;
		case BATTLE_RESULT:
			battleResult();
			break;
		default:
			break;
		}

	}


	/////////////////////////////////////////////////////////////
	//////  Game states
	/////////////////////////////////////////////////////////////



	private void setup() {

		if (!pairXOSC() && USE_XOSC) {
			pairXOSC();
		} else {
			gameState = PRE_SKILLTEST;
		};
	}

	private boolean pairXOSC() {
		players[0].setIPaddr(XOSC_P1_IP, XOSC_P1_PORT);
		players[1].setIPaddr(XOSC_P2_IP, XOSC_P2_PORT);


		if (!players[0].isPaired()) {
			selectedPlayer = players[0];
			textConsole = "Pair XOSC for player 0";
			return false;
		} else if (!players[1].isPaired()) {
			selectedPlayer = players[1];
			textConsole = "Pair XOSC for player 1";
			return false;
		} else {
			textConsole = "Players paired!";
			oscPaired = true;
			return true;
		}
	}

	private void preSkill() {

		textConsole = gameOverText + "\nPress X to start the Skill Test";
		gameState = PRE_SKILLTEST;
    if (triggerIntroOK) {
        triggerIntroOK = false;
        triggerIntro4Sound = true;
    }
		statelock = false;

	}

	private void startSkillTest() {
		statelock = true;
		gameState = SKILLTEST;
		statelock = false;
		gameOverText = "";
		timer = SKILLTEST_TIMER;
		players[0].setSkill(0.00);
		players[1].setSkill(0.00);
		triggerSkill = true;
    triggerSkillResultSound = true;
	}

	private void skillTest() {
		textConsole = "TAP X!";
    triggerResultSound=true;
		if (timer > 0) {
			players[0].setSkill(players[0].getSkill() - 0.01);
			players[1].setSkill(players[1].getSkill() - 0.01);
			timer -= timeDelta;
			return;
		} else {
			triggerSkillE = true;
			statelock = true;
			gameState = NULL_STATE;
			sceneAni = new Ani(this, 0.25, "flashLvl", 255, Ani.EXPO_IN_OUT, "onEnd:fadeInWpSel");
		}
	}

	private void startBattle() {
		if (timer > 0) {
			gameState = PRE_WPSEL;
			if (players[0].getSkill() < players[1].getSkill()) {
				attackingPlayer = players[1];
				defendingPlayer = players[0];
				battleResult[0] = 1;
			} else {
				attackingPlayer = players[0];
				defendingPlayer = players[1];
				battleResult[0] = 0;

			}
			textConsole = attackingPlayer.getName() + "  will attack  " + defendingPlayer.getName() + "\nGet ready!";
      //SOUND : ludic or fierce win skill test
      if (triggerSkillResultSound){
          if (attackingPlayer.getName()=="Ludic"){
            triggerSTLudicSound = true;
              }
          if (attackingPlayer.getName()=="Fierce"){
            triggerSTFierceSound = true;
              }
        triggerSkillResultSound= false;
        }
			timer -= timeDelta;

		} else {
			//Select Default weapon, first available in order
			int p1WpCount = players[0].weapons.size();
			int p2WpCount = players[1].weapons.size();
			ArrayList<Integer> checkedwp1 = new ArrayList<Integer>();
			ArrayList<Integer> checkedwp2 = new ArrayList<Integer>();
			players[0].selectWeapon(-1);
			players[1].selectWeapon(-1);
			int i = 0;
			int j = 0;
			while (players[0].getSelectedWeapon() == null) {
				int rndWpId = i;
				if (! checkedwp1.contains(rndWpId) && players[0].weapons.get(rndWpId).isUseable()) {
					players[0].selectWeapon(rndWpId + 1);
				} else {
					checkedwp1.add(rndWpId);
				}
				i++;
			}
			while (players[1].getSelectedWeapon() == null) {
				int rndWpId = j;
				if (! checkedwp1.contains(rndWpId) && players[1].weapons.get(rndWpId).isUseable()) {
					players[1].selectWeapon(rndWpId + 1);
				} else {
					checkedwp1.add(rndWpId);
				}
				j++;
			}
			timer = WPSEL_TIMER;
			gameState = WPSEL;
			statelock = false;
      triggerWeapSelSound = true;
		}
	}
	void weaponSelect() {
		textConsole = "Choose your weapons!";
   if (triggerWeapSelSound){
        triggerWeapSelSound= false;
        triggerWS_ = true;
        //triggerFirstTime= false;
        }

		if (timer > 0) {
			timer -= timeDelta;
			return;

		} else {
			statelock = true;
			triggerSkillE = true;
			gameState = BATTLE;
		}
	}

	private void battle() {
		/////
		//
		// Damage calculation based on attack power defense power and special powers active
		//
		/////
		textConsole = "";
		int p1WpCount = players[0].weapons.size();
		int p2WpCount = players[1].weapons.size();
		ArrayList<Integer> checkedwp1 = new ArrayList<Integer>();
		ArrayList<Integer> checkedwp2 = new ArrayList<Integer>();
		roundEndsGame = false;
		battleResult[1] = players[0].getSelectedWeapon().address;
		battleResult[2] = players[1].getSelectedWeapon().address;
		battleResult[3] = players[0].usingSp ? 1 : 0;
		battleResult[4] = players[1].usingSp ? 1 : 0;


		// Shouldn't be needing this anymore: random weapon selection on no selected
		// if(players[0].getSelectedWeapon() == null || players[1].getSelectedWeapon() == null){

		// 	if (players[0].getSelectedWeapon() == null) {
		// 		println("Getting unselected weapon for "+players[0].name);
		// 		while(players[0].getSelectedWeapon() == null){
		// 			int rndWpId = int(random(p1WpCount));
		// 			if(! checkedwp1.contains(rndWpId) && players[0].weapons.get(rndWpId).isUseable()){
		// 				players[0].selectWeapon(rndWpId+1);
		// 			}else{
		// 				checkedwp1.add(rndWpId);
		// 			}
		// 		}
		// 	}
		// 	if (players[1].getSelectedWeapon() == null){
		// 		println("Getting unselected weapon for "+players[1].name);
		// 		while(players[1].getSelectedWeapon() == null){
		// 			int rndWpId = int(random(p2WpCount));
		// 			if(! checkedwp2.contains(rndWpId) && players[1].weapons.get(rndWpId).isUseable()){
		// 				players[1].selectWeapon(rndWpId+1);
		// 			}else{
		// 				checkedwp2.add(rndWpId);
		// 			}
		// 		}
		// 	}
		// }

		//Calculate damage based on super powers
		//Basic Damage Calculation
		int dammage = attackingPlayer.getAttackStrength();
		int defense = defendingPlayer.getDefenseStrength();
		players[0].useWeapon();
		players[1].useWeapon();
		boolean switchPlayers = false;
		bufferText = "";
		if (attackingPlayer.usingSp) {
			//Apply sP on priority
			switch (attackingPlayer.name) {
			case "Fierce" :
				dammage += 4;
				bufferText += ("Fierce casts Rage!\n");
        triggerSPFierce = true;
        break;
			case "Ludic" :
				switchPlayers = true;
				bufferText += ("Ludic casted Mirror Spell on themselves!\n");
        triggerSPFLudicOK = true;
				break;
			default:
				break;
			}
			attackingPlayer.usingSp = false;
		}
		if (defendingPlayer.usingSp) {
			//Apply sP on priority
			switch (defendingPlayer.name) {
			case "Fierce" :
				bufferText += ("Fierce's Rage Spell Missed!\n");
				break;
			case "Ludic" :
				switchPlayers = true;
				bufferText += ("Ludic casts Mirror Spell!\n");
        triggerSPLudic = true;
        break;
			default:
				break;
			}
			defendingPlayer.usingSp = false;
		}

		int attackRes = dammage - defense;
    triggerFirstTime= false;
		battleResult[5] = attackRes > 0 ? 1 : 0;
		triggerAttackSound = true;
		if(battleResult[5] == 1){
			triggerDamageSound = true;
		}else{
			triggerDefenseSound = true;
      if (attackingPlayer.getName()=="Fierce"){
      triggerAFFierceOK=true;}
      if (attackingPlayer.getName()=="Ludic"){
      triggerAFLudicOK=true;  
      }
		}

		if (switchPlayers) attackingPlayer.receiveAttack(attackRes);
		else defendingPlayer.receiveAttack(attackRes);

		if (attackRes > 0) {
      if (attackingPlayer.getName()=="Fierce"){
          triggerASFierceOK=true;}
      if (attackingPlayer.getName()=="Ludic"){
          triggerASLudicOK=true;}
			if (switchPlayers) {
				bufferText += defendingPlayer.getName() + "  attacked  " + attackingPlayer.getName() + " for " + attackRes + " HP";
			} else {
				bufferText += attackingPlayer.getName() + "  attacked  " + defendingPlayer.getName() + " for " + attackRes + " HP";
			}
		} else if (attackRes <= 0) {
			if (!switchPlayers) {
				bufferText += defendingPlayer.getName() + "  defended  " + attackingPlayer.getName() + "'s attack";
			} else {
				bufferText += attackingPlayer.getName() + "  defended  " + defendingPlayer.getName() + "'s attack";
			}
		}

		if (battleResult[3] == 1 || battleResult[4] == 1) {
			timer = SP_ANIM_TIMER;
			gameState = SP_ANIMATION;
		} else {
			timer = BATTLE_ANIM_TIMER;
			gameState = BATTLE_ANIMATION;
		}

		// unselect weapons
		players[0].selectWeapon(-1);
		players[1].selectWeapon(-1);

		//Check if players are alive
		for (BasicPlayer player : players) {
			if (!player.isAlive()) {
				roundEndsGame = true;
				bufferText += ("\n" + player.name + " has been defeated!");
        //
				winner = players[0].name == player.name ? 1 : 0; 
				return;
			}
		}
		boolean noWp = false;
		//Check if there are still more weapons to use
		for (BasicPlayer player : players) {
			if (!player.hasWeapons()) {
				roundEndsGame = true;
				bufferText += ("\n" + player.name + "'s Avatar is consumed");
				noWp = true;
			}
		}
		if (noWp) {
			if(players[0].getHitPoints()>players[1].getHitPoints()){
				bufferText += ("\n" + players[0].name + " Wins!");
        triggerFRRLudicSound = true;
				winner = 0;
			} else if(players[0].getHitPoints()<players[1].getHitPoints()){
				bufferText += ("\n" + players[1].name + " Wins!");
				winner = 1;
			} else {
				bufferText += ("\n Draw!");
				winner = 2;
			}
		}

		// sceneAni = new Ani(this, 0.25, "timer", 100, Ani.EXPO_IN_OUT, "onEnd:fadeInResult");
	}
	public void spAnim() {
		//Special Power in effect
		if (battleResult[3] == 1 || battleResult[4] == 1) {
			if (timer > 0) {
				timer -= timeDelta;
      	} else {
				timer = BATTLE_ANIM_TIMER;
				gameState = BATTLE_ANIMATION;
				println(battleResult);
             	}
		} else {
			if (timer > 0) {
				timer -= timeDelta;
         triggerSPF_LudicSound = true;
			} else {
				timer = BATTLE_ANIM_TIMER;
				gameState = BATTLE_ANIMATION;
				println(battleResult);
         
			}
		}
	}

	public void battleAnim() {
		//Special Power in effect
		if (timer > 0) {
				timer -= timeDelta;
		} else {
				timer = BATTLE_RESULT_TIMER;
				gameState = BATTLE_RESULT;
				if(roundEndsGame) {
           triggerGameOverSound = true;
           if(players[0].getHitPoints()<players[1].getHitPoints())
              triggerFRRLudicSound = true;
           if(players[0].getHitPoints()>players[1].getHitPoints())
              triggerFRRFierceSound = true;}
				println(battleResult);

		}
	}

	public void battleResult() {
  		if (timer > 0) {
			if (roundEndsGame) {
				// println(players[0].getHitPoints() + " " + players[1].getHitPoints() );
				// if(players[0].getHitPoints() > players[1].getHitPoints()){
				// 	gameOverText = players[0].name + " defeats " + players[1].name + "!\nGame Over";
				// }else if(players[0].getHitPoints() > players[1].getHitPoints()){
				// 	gameOverText = players[1].name + " defeats " + players[0].name + "!\nGame Over";
				// }else if(players[0].getHitPoints() == players[1].getHitPoints()){
				// 	gameOverText = "It's a Draw!\nGame Over";
				// }

				newGame = true;
			}
			textConsole = bufferText;

          //I know it's the worst way ... sorry
 if (triggerResultSound){
   triggerResultSound=false;
   if((players[0].getHitPoints()>0) && (players[1].getHitPoints()>0)) {
     if(players[0].getHitPoints()>players[1].getHitPoints()){
        triggerIntroOK = true;
        if (triggerSPFLudicOK) {
            triggerSPFLudicOK=false;
            triggerSPF_LudicSound =true;           
          }
        if (triggerSPLudic) {
           if (triggerSPFierce) {
               triggerSPFierce=false;
               triggerSPLudic=false;
               triggerSPBothSound =true;           
           } else {
               triggerSPLudic=false;
               triggerSPSLudicSound=true;  }          
        } else {
            if (triggerSPFierce) {
              triggerSPFierce=false;
              triggerSPSFierceSound =true;           
           } else { 
               if (triggerAFLudicOK) {
                   triggerAFLudicOK=false;
                   triggerAFLudicSound =true;  
              } else {
                  if (triggerAFFierceOK) {
                      triggerAFFierceOK=false;
                      triggerAFFierceSound =true;  
                 } else {
                     if (triggerASFierceOK) {
                         triggerASFierceOK=false;
                         triggerASFierceSound =true;  
                   } else {
                       if (triggerASLudicOK) {
                           triggerASLudicOK=false;
                           triggerASLudicSound =true; }
                                           }
                                }
                      }

                }
             } 
    }
   }
 }
          //
			timer -= timeDelta;
		} else {
			//Then go to PreSkill Screen
			sceneAni = new Ani(this, 1, "fadeLvl", 255, Ani.EXPO_IN_OUT, "onEnd:fadeInPreskill");
			gameState = NULL_STATE;
			if (newGame) {
				gameOverText = "Game Over";
				// textConsole = gameOverText;
				for (BasicPlayer player : players) {
					player.init();
				}
				newGame = false;
			} else {
				gameOverText = "";
			}
		}
	}

	public void reset() {
		timer = 0;
		newGame = true;
		battleResult();
	}
	// public void gameOver(){
	// 	textConsole = "Game Over\n";
	// 	if(players[0].hitPoints > players[1].hitPoints){
	// 		textConsole += players[0].name + " defeats " + players[1].name + "!\n";
	// 	}else if(players[0].hitPoints == players[1].hitPoints){
	// 		textConsole += "It's a Draw!\n";
	// 	}else{
	// 		textConsole += players[1].name + " defeats " + players[0].name + "!\n";
	// 	}
	// 	textConsole += "Press ENTER to restart.\n";
	// 	if (key == ENTER) {
	// 		for (BasicPlayer player : players) {
	// 			player.init();
	// 		}
	// 		startSkillTest();
	// 	}

	// }

	// Fades
	public void fadeInSKill() {
		sceneAni = new Ani(this, 1, "fadeLvl", 0, Ani.EXPO_IN_OUT, "onStart:startSkillTest");
	}
	public void fadeInWpSel() {
		timer = START_BATTLE_TIMER;
		textConsole = "";
		sceneAni = new Ani(this, 0.25, "flashLvl", 0, Ani.EXPO_OUT, "onEnd:startBattle");
		// delay(1000);
		// gameState = PRE_WPSEL;

	}
	public void fadeInBattle() {
		sceneAni = new Ani(this, 0.25, "flashLvl", 0, Ani.EXPO_OUT);
	}

	public void fadeInResult() {
		textConsole = bufferText;
		sceneAni = new Ani(this, 1, "fadeLvl", 0, Ani.EXPO_IN_OUT, "onEnd:battleResult");
		timer = WPSEL_TIMER;
	}
	public void fadeInPreskill() {
		// textConsole = "";
		sceneAni = new Ani(this, 1, "fadeLvl", 0, Ani.EXPO_IN_OUT, "onStart:preSkill");
	}

	/////////////////////////////////////////////////////////////
	//////  Player input
	/////////////////////////////////////////////////////////////

	/**
	 * Simple input system
	 * @param player number
	 * @param button number
	 */
	public void playerInput(int _p, int _i) {
		if (!statelock) {
			BasicPlayer _player = getPlayer(_p);
			if (_player == null) {

				println("Error: Player not found!");

				return;
			} else if (gameState == WPSEL) {
				if (_i == 5) {

					if (_player.specialPower()) {
						triggerSpSound = true;
            if (_p == 1) { 
                triggerSPT_LudicSound = true;
            }
            if (_p == 0) { 
                triggerSPT_FierceSound = true;
            }
						triggerSpAniSound = true;
					}
				} else if (_i == 1) {

					_player.selectWeaponUp();
					toggleOKSound = true;
				} else if (_i == 2) {

					_player.selectWeaponDown();
					toggleOKSound = true;
				}

			} else if (gameState == SKILLTEST && _i == 3) {

				 _player.setSkill(_player.getSkill() + 0.07);

			} else if (gameState == PRE_SKILLTEST && _i == 3 && !statelock) {
				statelock = true;
				gameState = NULL_STATE;
				sceneAni = new Ani(this, 1, "fadeLvl", 255, Ani.EXPO_IN, "onEnd:fadeInSKill");

			} 
			// else if (gameState == BATTLE_RESULT && _i == 3 && !statelock) {
			// 	statelock = true;
			// 	gameState = NULL_STATE;
			// 	sceneAni = new Ani(this, 1, "fadeLvl", 255, Ani.EXPO_IN, "onEnd:fadeInSKill");
			// }
			// println("Got input " + _i + " from Player " + _player.name);

		}

	}

	public void oscInput(OscMessage _mess) {
		// println("OSC message " + _mess.addrPattern() + " From " + _mess.netAddress().address());
		// if in paring mode
		//println(_mess.addrPattern() == "/ping");
		// if (!oscPaired && _mess.checkAddrPattern("/ping")) {
		// 	selectedPlayer.setIPaddr(_mess.netAddress().address(),);
		// } else if (int(_mess.get(0).floatValue()) == 1) {
		// 	if (_mess.checkAddrPattern("/Player1/1")) {
		// 		battleSystem.playerInput(0, 1);
		// 	} else if (_mess.checkAddrPattern("/Player1/2")) {
		// 		battleSystem.playerInput(0, 2);
		// 	} else if (_mess.checkAddrPattern("/Player1/3")) {
		// 		battleSystem.playerInput(0, 3);
		// 	} else if (_mess.checkAddrPattern("/Player1/4")) {
		// 		battleSystem.playerInput(0, 4);
		// 	} else if (_mess.checkAddrPattern("/Player1/5")) {
		// 		battleSystem.playerInput(0, 5);
		// 	} else if (_mess.checkAddrPattern("/Player2/1")) {
		// 		battleSystem.playerInput(1, 1);
		// 	} else if (_mess.checkAddrPattern("/Player2/2")) {
		// 		battleSystem.playerInput(1, 2);
		// 	} else if (_mess.checkAddrPattern("/Player2/3")) {
		// 		battleSystem.playerInput(1, 3);
		// 	} else if (_mess.checkAddrPattern("/Player2/4")) {
		// 		battleSystem.playerInput(1, 4);
		// 	} else if (_mess.checkAddrPattern("/Player2/5")) {
		// 		battleSystem.playerInput(1, 5);
		// 	}
		// }
		if (_mess.checkAddrPattern("/p1/inputs/analogue")) {
			float gsrVal = _mess.get(0).floatValue();
			println("P1:" + gsrVal);
			players[0].updateGSR(gsrVal);
		} 
		if (_mess.checkAddrPattern("/p2/inputs/analogue")) {
			float gsrVal = _mess.get(0).floatValue();
			println("P2:" + gsrVal);
			players[1].updateGSR(gsrVal);
		} 
	}

	/////////////////////////////////////////////////////////////
	//////  Accessors
	/////////////////////////////////////////////////////////////

	public void getSkillFloat() {
		// println("Here");
		return;
	}

	public BasicPlayer getPlayer(int _p) {
		if (_p >= PLAYER_COUNT && _p < 0) return null;
		else return players[_p];
	}

	public String getText() {
		return textConsole;
	}

	public int getState() {
		return gameState;
	}
}