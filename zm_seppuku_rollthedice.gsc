#using scripts\shared\weapons_shared;
#using scripts\shared\array_shared;

function init(){
	self.lastroll = undefined;
	level.stage = 1;//1 pistol// 2 semi pistol // 3 semi rifle//  4 SMG // 5 AR //6 AR PackaPunch???? // 7 ??????????????????
	level.timeToRoll = 45; // time between rolls
	thread doStart();
}

function doStart(){
	wait 0.05;
	thread giveWeaponsHandler();
	thread stageHandlerLevel2();
	thread stageHandlerLevel3();
	thread stageHandlerLevel4();
	thread stageHandlerLevel5();
	thread stageHandlerLevel6();
	thread stageHandlerLevel7();

}

function stageHandlerLevel2(){
	trigger = GetEnt("startLevel2", "targetname");
    trigger waittill("trigger", player);
	wait 0.05;
	trigger Delete();
	level.stage = 2;
}
function stageHandlerLevel3(){
	trigger = GetEnt("startLevel3", "targetname");
    trigger waittill("trigger", player);
	wait 0.05;
	trigger Delete();
	level.stage = 3;
}
function stageHandlerLevel4(){
	trigger = GetEnt("startLevel4", "targetname");
    trigger waittill("trigger", player);
	wait 0.05;
	trigger Delete();
	level.stage = 4;
}
function stageHandlerLevel5(){
	trigger = GetEnt("startLevel5", "targetname");
    trigger waittill("trigger", player);
	wait 0.05;
	trigger Delete();
	level.stage = 5;
}
function stageHandlerLevel6(){
	trigger = GetEnt("startLevel6", "targetname");
    trigger waittill("trigger", player);
	wait 0.05;
	trigger Delete();
	level.stage = 6;
}
function stageHandlerLevel7(){
	trigger = GetEnt("startLevel7", "targetname");
    trigger waittill("trigger", player);
	wait 0.05;
	trigger Delete();
	level.stage = 7;
}
function doReroll(){
	giveWeaponsHandler();
}

function giveWeaponsHandler()
{
	if(level.stage == 1){
		stageOneWeapons = array("pistol_standard", "smg_versatile", "smg_burst"); // list of weapons in the pool
        //self TakeAllWeapons(); // remove players weapon
        wait 0.05; // added wait to stop removing new given weapon
        self GiveWeapon(getWeapon(array::randomize(stageOneWeapons[randomInt(stageOneWeapons.size)]))); // give random weapon to player from list
        wait 1; // time between rolls 
        thread doReroll(); // it do what it say lmao
	}
	if(level.stage == 2){
		stageTwoWeapons = array("pistol_standard", "smg_versatile", "smg_burst"); // list of weapons in the pool
        self TakeAllWeapons(); // remove players weapon
        wait 0.05; // added wait to stop removing new given weapon
        self GiveWeapon(getWeapon(array::randomize(stageTwoWeapons[randomInt(stageTwoWeapons.size)]))); // give random weapon to player from list
        wait level.timeToRoll; // time between rolls 
        thread doReroll(); // it do what it say lmao
	}
	if(level.stage == 3){
		stageThreeWeapons = array("pistol_standard", "smg_versatile", "smg_burst"); // list of weapons in the pool
        self TakeAllWeapons(); // remove players weapon
        wait 0.05; // added wait to stop removing new given weapon
        self GiveWeapon(getWeapon(array::randomize(stageThreeWeapons[randomInt(stageThreeWeapons.size)]))); // give random weapon to player from list
        wait level.timeToRoll; // time between rolls 
        thread doReroll(); // it do what it say lmao
	}
	if(level.stage == 4){
		stageFourWeapons = array("pistol_standard", "smg_versatile", "smg_burst"); // list of weapons in the pool
        self TakeAllWeapons(); // remove players weapon
        wait 0.05; // added wait to stop removing new given weapon
        self GiveWeapon(getWeapon(array::randomize(stageFourWeapons[randomInt(stageFourWeapons.size)]))); // give random weapon to player from list
        wait level.timeToRoll; // time between rolls 
        thread doReroll(); // it do what it say lmao
	}
	if(level.stage == 5){
		stageFiveWeapons = array("pistol_standard", "smg_versatile", "smg_burst"); // list of weapons in the pool
        self TakeAllWeapons(); // remove players weapon
        wait 0.05; // added wait to stop removing new given weapon
        self GiveWeapon(getWeapon(array::randomize(stageFiveWeapons[randomInt(stageFiveWeapons.size)]))); // give random weapon to player from list
        wait level.timeToRoll; // time between rolls 
        thread doReroll(); // it do what it say lmao
	}
	if(level.stage == 6){
		stageSixWeapons = array("pistol_standard", "smg_versatile", "smg_burst"); // list of weapons in the pool
        self TakeAllWeapons(); // remove players weapon
        wait 0.05; // added wait to stop removing new given weapon
        self GiveWeapon(getWeapon(array::randomize(stageSixWeapons[randomInt(stageSixWeapons.size)]))); // give random weapon to player from list
        wait level.timeToRoll; // time between rolls 
        thread doReroll(); // it do what it say lmao
	}
	if(level.stage == 7){
		stageSevenWeapons = array("pistol_standard", "smg_versatile", "smg_burst"); // list of weapons in the pool
        self TakeAllWeapons(); // remove players weapon
        wait 0.05; // added wait to stop removing new given weapon
        self GiveWeapon(getWeapon(array::randomize(stageSevenWeapons[randomInt(stageSevenWeapons.size)]))); // give random weapon to player from list
        wait level.timeToRoll; // time between rolls 
        thread doReroll(); // it do what it say lmao
	}
}
