int ttAtExitPoint=0 # Used for win condition objective, it's basically boolean.

bool baseTideIsFlooding=false
bool floodedCaveForkExcavationStarted # Doesnt matter how far, jsut that excavation has started in any way.
bool caveForkBypassEnabled
bool forkCliffExcavated
bool forkBypassFlooded
bool forkCliffFlooded
bool weakenedWallAdjacentToFork

float floodSpeedFast=0.25
float floodSpeedNormal=1.0

# Disable certain advantagous buildings, due to "resource shortage".
disable:BuildingSupportStation_C

# MSG: Objectives
string superTeleportBuiltMsg="Good! Now all you need to do is to teleport down a Heavycopter and exit the cavern via the waterfall"
string ttSpawnedMsg="Board the Tunnel Transport and exit the cavern via the waterfall"

# MSG: Base tide
string baseTideFloodsMsg="The tide has risen, resulting in another blackout."
string baseTideEbbsMsg="The tide has receeded, but it will rise again. Quickly, rebuild that power path while you still can!"

# MSG: Flooded cave
string floodedCaveTriggeredMsg="I warned you!! You drilled directly into a flooding cavern, get out of there now!"
string floodedCaveDiverted="Phew, it looks like the water was safely diverted through a cave fork, we're safe for now... But, please be more careful in the future!"
string floodedCaveNotDiverted="The water flooded all the way back to base, all of those caverns are now out of our reach! This is a grave set back, indeed..."
string caveForkBypassEnabledMsg="It seems like this cave ends in a cliff, we might be able to divert water this way."

# MSG: Floodable Fork cave
string weakenedWallAdjacentToForkTornDownMsg="The flood of water has caused the weakend wall foundation to subside, the path is clear!"
string weakenedWallAdjacentToForkMsg="Your drilling activity seems to have weakended one of the solid rock walls, maybe it can be torn down somehow?"

baseTideEbbs::;
place:6,4,5;
baseTideIsFlooding=false;
msg:baseTideEbbsMsg;

baseTideFloods::;
place:6,4,11;
baseTideIsFlooding=true;
msg:baseTideFloodsMsg;

baseTideToggle::;
((baseTideIsFlooding==true))[baseTideEbbs][baseTideFloods] ;

weakenedWallAdjacentToForkTornDown::;
((forkCliffExcavated==true))msg:weakenedWallAdjacentToForkTornDownMsg;
((forkCliffExcavated==true))drill:7,18;
((forkCliffExcavated==true))drill:7,17;
((forkCliffExcavated==true))wait:floodSpeedFast;
((forkCliffExcavated==true))place:7,17,11;
((forkCliffExcavated==true))place:7,18,11;


floodFork::;
((get(12)(19)!=34))place:12,19,11;
wait:floodSpeedFast;
((get(11)(19)!=34))place:11,19,11;
wait:floodSpeedFast;
((get(10)(19)!=34))place:10,19,11;
wait:floodSpeedFast;
((get(10)(20)!=34))place:10,20,11;
((get(9)(19)!=34))place:9,19,11;
wait:floodSpeedFast;
# Tiny inner cave
((get(8)(19)!=11))place:8,19,11;
wait:floodSpeedFast;
((get(7)(19)!=11))place:7,19,11;
((weakenedWallAdjacentToFork==true))weakenedWallAdjacentToForkTornDown;
# Middle rocks
((get(7)(20)!=30))place:7,20,11;
wait:floodSpeedFast;
((get(6)(20)!=26))place:6,20,11;
wait:floodSpeedFast;
((get(5)(20)!=26))place:5,20,11;
((get(6)(21)!=26))place:6,21,11;
wait:floodSpeedFast;
((get(5)(21)!=26))place:5,21,11;
((get(6)(22)!=34))place:6,22,11;
wait:floodSpeedFast;
((get(4)(21)!=30))place:4,21,11;
((get(3)(21)!=30))place:3,21,11;
((get(3)(21)!=30))forkCliffExcavated=true;
# Final inner cave
((forkCliffExcavated==true))place:2,21,11;
((forkCliffExcavated==true))wait:floodSpeedFast;
((forkCliffExcavated==true))place:1,21,11;
((forkCliffExcavated==true))wait:floodSpeedFast;
((forkCliffExcavated==true))place:1,20,11;
((forkCliffExcavated==true))forkCliffFlooded=true;

floodTowardsBase::;
((get(13)(18)!=30))place:13,18,11;
wait:floodSpeedFast;
((get(13)(17)!=26))place:13,17,11;
wait:floodSpeedFast;
place:13,17,11;
wait:floodSpeedFast;
place:13,16,11;
wait:floodSpeedFast;
place:13,15,11;
wait:floodSpeedFast;
place:13,14,11;
wait:floodSpeedFast;
place:13,13,11;
wait:floodSpeedFast;
place:13,12,11;
wait:floodSpeedFast;
place:13,11,11;
wait:floodSpeedFast;
place:13,10,11;
wait:floodSpeedFast;
place:13,9,11;
wait:floodSpeedFast;
place:13,8,11;
wait:floodSpeedFast;
place:13,7,11;
wait:floodSpeedFast;
place:13,6,11;
wait:floodSpeedFast;
place:13,5,11;
msg:floodedCaveNotDiverted;


floodedCaveTriggered::;
# Order: center (NB: +1 south of rest) --> left,right --> far left,far right
# Step 1
place:13,26,11; # center
place:14,27,11; # east
place:12,27,11; # west
place:15,28,11; # east+1
place:11,28,11; # west+1
wait:3;
# Step 2
place:13,25,11; # center
place:14,26,11; # east
place:12,26,11; # west
place:15,27,11; # east+1
place:11,27,11; # west+1
wait:2;
# Step 3 (now entering slim cavern and thus speeding up)
place:13,24,11; # center (inside slim cavern)
place:14,25,11; # east
place:12,25,11; # west
place:15,26,11; # east+1
place:11,26,11; # west+1
# Flow until fork (if present)
wait:floodSpeedFast;
place:15,25,11; # east+1
place:11,25,11; # west+1
place:13,24,11; # center
wait:floodSpeedFast;
place:13,23,11;
wait:floodSpeedFast;
place:13,22,11;
wait:floodSpeedFast;
place:13,21,11;
wait:floodSpeedFast;
place:13,20,11;
wait:floodSpeedFast;
place:13,19,11;
# Possible fork
((floodedCaveForkExcavationStarted==true))floodFork;
((caveForkBypassEnabled!=true))floodTowardsBase;

discoverFloodedCave::;
drill:13,24;
msg:floodedCaveTriggeredMsg;
floodedCaveTriggered;

enableFloodForkBypass::;
caveForkBypassEnabled=true;
forkCliffExcavated=true;
msg:caveForkBypassEnabledMsg;

weakenedWallPathEnabled::;
place:7,16,11;
weakenedWallAdjacentToFork=true;
msg:weakenedWallAdjacentToForkMsg;
((forkCliffFlooded==true))wait:15;
((forkCliffFlooded==true))weakenedWallAdjacentToForkTornDown;

superTeleportBuilt::;
msg:superTeleportBuiltMsg;

arrow exitObjectiveArrow=green

tunnelTransportSpawned::;
msg:ttSpawnedMsg;
showarrow:1,1,exitObjectiveArrow;

rapidRiderDropsIntoWaterfall::;
msg:rapidRiderDropsIntoWaterfallMsg;
lastvehicle.

excavateForkViaBaseRiver::;
place:7,17,11;
drill:7,18;
wait:floodSpeedFast;
place:7,18,11;
wait:floodSpeedFast;
place:7,19,11;
place:8,19,11;
forkBypassFlooded=true;

winLevel::;
pan:31,31;
wait:3;
win;

### Triggers
when(drill:13,21)[shake:2.5] # A warning of things to come... The only one they get.
when(drill:13,23)[discoverFloodedCave]
when(drill:12,19)[floodedCaveForkExcavationStarted=true]
when(drill:3,21)[enableFloodForkBypass]

# When drilling walls adjacent to base river.
when(drill:3,16)[place:3,16,11]
when(drill:4,16)[place:4,16,11]
when(drill:5,16)[place:5,16,11]
when(drill:6,16)[place:6,16,11]

# Unlockable bonus path.
when(drill:7,16)[weakenedWallPathEnabled]

# Objective triggers
when(BuildingSuperTeleport_C.built)[superTeleportBuilt]
when(VehicleTunnelTransport_C.new)[tunnelTransportSpawned]
when(drive:1,1,VehicleTunnelTransport_C)[winLevel]

init::;
starttimer:baseTideTimer;

