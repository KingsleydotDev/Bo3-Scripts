function init()
{
    thread BouncePos();
    thread doBounce();
}

function BouncePos()
{
    level.currentMap = "zm_testing"; // MAP NAME HERE!!
    level.bounces[level.currentMap]    =    [];
    level.bounces[level.currentMap][0] = (0, 0, 0);
}



function doBounce()
{

    while(isDefined(level.bounces[level.CurMap]))
    {
        wait 0.01;

        foreach(player in level.players)
        {
            player.vel = player getVelocity();

            if(!isDefined(player.CanBounce)) // Ehh; works for now anyways. -- removed ->  || player.vel[2] >= -10 && player.vel[2] <= 10
                player.CanBounce = 1;

            if( player isOnGround() || player isOnLadder() || !isAlive( player ) || player.vel[2] > 0) // bounces won't affect people walking, climbing a ladder, dead, or people jumping UP instead of DOWN
                continue;

            for( bCount = 0; bCount < level.bounces[level.CurMap].size; bCount++ )
            {
                if(!isDefined(level.bounces[level.CurMap][bCount])) // incase you forgot to change the array's number when removing a bounce, this will stop various errors/bugs.
                    continue; // You /should/ up the digit though; there will be errors still (I.E. some bounces won't be counted)

                if(isDefined(level.bounces[level.CurMap]["radius"][bCount])) // check for custom radius
                {
                    player.bRadius = level.bounces[level.CurMap]["radius"][bCount];
                } else { // if error or no custom radius then we assign the 'default'.
                    level.bounces[level.CurMap]["radius"][bCount] = 80;
                    player.bRadius = level.bounces[level.CurMap]["radius"][bCount];
                }

                if(distance(player.origin, level.bounces[level.CurMap][bCount]) <= player.bRadius && player.canBounce == 1 && player.origin[2] - level.bounces[level.CurMap][bCount][2] <= 25) {

                    if(isDefined(level.bounces[level.CurMap]["multiplier"][bCount])) // check for custom multiplier
                    {
                        player.bMultiplier = level.bounces[level.CurMap]["multiplier"][bCount];
                    } else { // if error or no custom multiplier we assign default
                        level.bounces[level.CurMap]["multiplier"][bCount] = -1.215; //Standard: -1.215
                        player.bMultiplier = level.bounces[level.CurMap]["multiplier"][bCount];
                    }

                    player setVelocity( ( player.vel[0], player.vel[1], player.vel[2] * player.bMultiplier ) ); // -1.215 is the 'multiplier' of the bounce; lower number (remember its negative) = higher bounce
                    player.CanBounce = 0;
                    player thread resetBounce();
                }
            }
        }
    }
}


function resetBounce() // mere work around for player.canBounce -- works slightly better for now anyways
{
    self endon("disconnect");
    self endon("finishReset");
    wait 5;
    self.canBounce = 1;
    self notify("finishReset");
}

