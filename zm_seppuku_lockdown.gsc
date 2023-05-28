#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;

#using scripts\zm\_zm_powerups;




function init()
{
    level.isPlayerLockeddown = false;
    level.isPlayerInLockdownZone = undefined;
    level.lockdownFinished = undefined;
    level.lockdownTime = 60;
    thread initLockdownEvent();
}




function giveRewardToPlayer()
{
    wait 0.05;
    zm_powerups::specific_powerup_drop("nuke",GetPlayers()[0].origin);
    zm_powerups::specific_powerup_drop("full_ammo",GetPlayers()[0].origin);
}

function finishLockdown()
{
    level.isPlayerLockeddown = false;
    level.lockdownFinished = true;
    iPrintLnBold("Quest complete"); //debug
    thread giveRewardToPlayer();
}



function doPunish()
{
    //punish them for leaving the zone.
    playerNewHealth = (self.health - 10);
    wait 0.05;
    if(playerNewHealth < 5)
    {
        playerNewHealth = 1; // stop negative hp
    }
    //IPrintLnBold(playerNewHealth); // debug
    self.health = playerNewHealth;
    Earthquake( 0.2, 0.3, GetPlayers()[0].origin, 1000);
    IPrintLnBold("get yo stinky ugly ass back to the zone"); //debug
}


function keepPlayersInLockdown()
{
    
    trigger = GetEnt("lockdownLocation1", "targetname");
    trigger waittill("trigger", player);
    for(;;)
    {
        if(player isTouching(trigger))
        {
            IPrintLnBold("you are in the zone"); //debug
            level.isPlayerInLockdownZone = true;
        }
        else if(level.isPlayerLockeddown)
        {
            player thread doPunish(); // punish them
            level.isPlayerInLockdownZone = false;
        }
        else if(level.lockdownFinished)
        {
            break;
        }
        else
        {
            IPrintLnBold("sum aint right"); // debug init
        }
        wait 1; // this is how often it checks
    }
}

function doLockdownQuest() // the quest/goal.
{
    iPrintLnBold("Starting Quest"); //debug
    level.isPlayerLockeddown = true; // flag for playing is in active quest 
    self thread keepPlayersInLockdown(); // keep them in the zone 
    wait level.lockdownTime; // defined at the top
    thread finishLockdown(); // umm take a guess 
}


function initLockdownEvent() // starting lock down. add button for this.
{
    //need custom flag for activation like button pushed??
    //level flag::wait_till("initial_blackscreen_passed");
    trigger = GetEnt("lockdownLocation1", "targetname");
    trigger waittill("trigger", player);
    thread doLockdownQuest();

}


