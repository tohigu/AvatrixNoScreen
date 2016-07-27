class OSCView extends BasicView {


	public OSCView() {
		LEDsetup();

	}

	public void display() {
		while (true) {
				int fc = frameCount;
				int i = 0;
				int j = 0;
				// int t1 = millis();
				BasicPlayer[] _players = battleSystem.players;
				for (BasicPlayer player : _players) {
					String playerColor = i == 1 ? "blue" : "red";
					for (BasicWeapon weapon : player.weapons) {
						switch (battleSystem.getState()) {
						case PRE_SKILLTEST :
							patterns.get("flameString").c1 = colors.get("white");
							patterns.get("flameString").c2 = colors.get("orange");
							patterns.get("flameString").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							break;
						case SKILLTEST_INTRO :
							patterns.get("fadeInOut").c1 = colors.get("white");
							patterns.get("fadeInOut").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							break;
						case SKILLTEST :
							patterns.get("skillPower").c1 = colors.get("white");
							patterns.get("skillPower").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							break;
						case PRE_WPSEL :
							patterns.get("skillPower").c1 = colors.get("white");
							patterns.get("skillPower").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							break;
						case WPSEL:
							if (!weapon.isUseable()) {
								patterns.get("solid").c1 = colors.get("red");
								patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							} else {
								String anim;
								// println(player.getSelectedWeapon());
								if ((player.getSelectedWeapon() != null) && (player.getSelectedWeapon().name == weapon.name)) {
									anim = "fadeInOut";
								} else {
									anim = "solid";
								}
								switch (weapon.useCount) {
								case 1:
									patterns.get(anim).c1 = colors.get("orange");
									patterns.get(anim).c2 = colors.get(player.mainColor);
									patterns.get(anim).doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
									break;
								case 0:
									patterns.get(anim).c1 = colors.get("green");
									patterns.get(anim).c2 = colors.get(player.mainColor);
									patterns.get(anim).doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
									break;
								}
							}
							break;
						case BATTLE :
							patterns.get("solid").c1 = colors.get("white");
							patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							break;
						case SP_ANIMATION :
							if( i == 0 && battleSystem.battleResult[3] == 1){
								patterns.get("specialPower").c1 = colors.get("white");
								patterns.get("specialPower").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}else if( i == 1 && battleSystem.battleResult[4] == 1){
								patterns.get("specialPower").c1 = colors.get("white");
								patterns.get("specialPower").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}else{
								patterns.get("solid").c1 = colors.get("nocolor");
								patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}
							break;
						case BATTLE_ANIMATION :
							if( i == battleSystem.battleResult[0] && battleSystem.battleResult[i+1] == weapon.address){
								patterns.get("fadeInOutString").c1 = colors.get(playerColor);
								patterns.get("fadeInOutString").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}else if( i != battleSystem.battleResult[0]  && battleSystem.battleResult[i+1] == weapon.address){
								patterns.get("fadeInOutEven").c1 = colors.get(playerColor);
								patterns.get("fadeInOutEven").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}else{
								patterns.get("solid").c1 = colors.get("nocolor");
								patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}
							break;
						case BATTLE_RESULT :
							if (battleSystem.roundEndsGame) {
								if(i == battleSystem.winner){
									patterns.get("specialPower").c1 = colors.get(playerColor);
									patterns.get("specialPower").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
								}else{
									patterns.get("solid").c1 = colors.get("nocolor");
									patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
								}
							}else if( i == battleSystem.battleResult[0] && battleSystem.battleResult[i+1] == weapon.address && battleSystem.battleResult[5] == 1){
								//Attacker success
								patterns.get("attackOK").c1 = colors.get(playerColor);
								patterns.get("attackOK").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}else if( i == battleSystem.battleResult[0] && battleSystem.battleResult[i+1] == weapon.address && battleSystem.battleResult[5] == 0){
								//Attacker fail
								patterns.get("fadeOut").c1 = colors.get(playerColor);
								patterns.get("fadeOut").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}else if( i != battleSystem.battleResult[0] && battleSystem.battleResult[i+1] == weapon.address && battleSystem.battleResult[5] == 1){
								//Defender fail
								patterns.get("fadeOut").c1 = colors.get(playerColor);
								patterns.get("fadeOut").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}else if( i != battleSystem.battleResult[0] && battleSystem.battleResult[i+1] == weapon.address && battleSystem.battleResult[5] == 0){
								//Defender success
								patterns.get("attackOK").c1 = colors.get(playerColor);
								patterns.get("attackOK").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}else{
								patterns.get("solid").c1 = colors.get("nocolor");
								patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							}
							// if(battleSystem.battleResult[5] == 0){//Attack Fail
							// 	if(i == battleSystem.battleResult[0]){//Player is attacker
							// 		if (battleSystem.battleResult[1] == j+1){//Is selected weapon
							// 			patterns.get("fadeOut").c1 = colors.get(playerColor);
							// 			patterns.get("fadeOut").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							// 		}else{
							// 			patterns.get("solid").c1 = colors.get("nocolor");
							// 			patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							// 		}
							// 	}else if (i != battleSystem.battleResult[0]) {//Player is defender
							// 		if (battleSystem.battleResult[2] == j+1){//Is selected weapon
							// 			patterns.get("solid").c1 = colors.get(playerColor);
							// 			patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							// 		}else{
							// 			patterns.get("solid").c1 = colors.get("nocolor");
							// 			patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							// 		}
							// 	}
							// }else if (battleSystem.battleResult[5] == 1) {//Attack success
							// 	if(i == battleSystem.battleResult[0]){//Player is attacker
							// 		if (battleSystem.battleResult[1] == j+1){//Is selected weapon
							// 			patterns.get("solid").c1 = colors.get(playerColor);
							// 			patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							// 		}else{
							// 			patterns.get("solid").c1 = colors.get("nocolor");
							// 			patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							// 		}
							// 	}else if (i != battleSystem.battleResult[0]) {//Player is defender
							// 		if (battleSystem.battleResult[2] == j+1){//Is selected weapon
							// 			patterns.get("fadeOut").c1 = colors.get(playerColor);
							// 			patterns.get("fadeOut").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							// 		}else{
							// 			patterns.get("solid").c1 = colors.get("nocolor");
							// 			patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							// 		}
							// 	}
							// }
							break;
						case NULL_STATE :
							patterns.get("solid").c1 = colors.get("nocolor");
							patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							break;
						default:
							patterns.get("solid").c1 = colors.get("nocolor");
							patterns.get("solid").doPattern(weapon.ledCount, player, weapon.address, fc, battleSystem);
							break;
						}
					    delay(5);
						j++;
					}
					// Hp - 10
						patterns.get("solid").c1 = colors.get("white");
						patterns.get("solid").doPattern(10, player, 5, fc, battleSystem); 
					// Att - 5 
						patterns.get("solid").c1 = colors.get("red");
						patterns.get("solid").doPattern(5, player, 6, fc, battleSystem);
					// Def - 5
						patterns.get("solid").c1 = colors.get("blue");
						patterns.get("solid").doPattern(5, player, 7, fc, battleSystem);
					i++;
				}
		}
	}
}