#   Dynamic spreading of water (or other IDs)
#
#   By BluABK <bluabk@bluabk.net>
#

int waterSpreadCurrentRow=17
int waterSpreadCurrentCol=16
int spreadTileID=11 # Water
string myMsg=""
int rnd
int globalCounter
int spreadableRowsSize=4
int spreadableColsSize=4
intarray spreadableRows # 0: North, 1: East, 2: South, 3: West
intarray spreadableCols # 0: North, 1: East, 2: South, 3: West
bool spreadableCoordBooleanEq
bool isSpreadableRow
bool isSpreadableCol
bool isSpreadableCoord
bool canSpread
int nextTile
int nextRow
int nextCol

# <Helpers>
resetGlobalCounter::;
globalCounter=0;

clearSpreadableArray::;
spreadableRows[globalCounter]=0;
spreadableCols[globalCounter]=0;
globalCounter+=1;
((counter<spreadableRowsSize))clearSpreadableArray;

resetAndClear::;
resetGlobalCounter;
clearSpreadableArray;

# </Helpers>

# <Spreading>
int row
int col

spread::;
findSpreadableDirections;
rnd=random(0)(3);
# Determine if rnd index is spreadable
isSpreadableRow=false;
isSpreadableCol=false;
spreadableCoordBooleanEq=false;
isSpreadableCoord=false;
((spreadableRows[rnd]!=0))[isSpreadableRow=true][isSpreadableRow=false];
((spreadableCols[rnd]!=0))[isSpreadableCol=true][isSpreadableCol=false];
((isSpreadableRow==isSpreadableCol))spreadableCoordBooleanEq=true;
# If:   Randomly selected coord is NOT spreadable retry with a new random indaex
((spreadableCoordBooleanEq!=true))spread;
# Else: Place tile
((spreadableCoordBooleanEq==true))isSpreadableCoord=true;
((isSpreadableCoord==true))row=spreadableRows[rnd];
((isSpreadableCoord==true))col=spreadableCols[rnd];
((isSpreadableCoord==true))place:row,col,spreadTileID;
#       Update current position
((isSpreadableCoord==true))waterSpreadCurrentRow=row;
((isSpreadableCoord==true))waterSpreadCurrentCol=col;
#((isSpreadableCoord==true))clearSpreadableArray;

markSpreadableNorth::;
spreadableRows[0]=waterSpreadCurrentRow-1;
spreadableCols[0]=waterSpreadCurrentCol;
canSpread=true;

markSpreadableEast::;
spreadableRows[1]=waterSpreadCurrentRow;
spreadableCols[1]=waterSpreadCurrentCol+1;
canSpread=true;

markSpreadableSouth::;
spreadableRows[2]=waterSpreadCurrentRow+1;
spreadableCols[2]=waterSpreadCurrentCol;
canSpread=true;

markSpreadableWest::;
spreadableRows[3]=waterSpreadCurrentRow;
spreadableCols[3]=waterSpreadCurrentCol-1;
canSpread=true;

# Determine where we can spread
findSpreadableDirections::;
canSpread=false;
# North
nextRow=waterSpreadCurrentRow-1;
nextCol=waterSpreadCurrentCol;
nextTile=get(nextRow)(nextCol);
((nextTile!=spreadTileID))markSpreadableNorth;
# East
nextRow=waterSpreadCurrentRow;
nextCol=waterSpreadCurrentCol+1;
nextTile=get(nextRow)(nextCol);
((nextTile!=spreadTileID))markSpreadableEast;
# South
nextRow=waterSpreadCurrentRow+1;
nextCol=waterSpreadCurrentCol;
nextTile=get(nextRow)(nextCol);
((nextTile!=spreadTileID))markSpreadableSouth;
# West
nextRow=waterSpreadCurrentRow;
nextCol=waterSpreadCurrentCol-1;
nextTile=get(nextRow)(nextCol);
((nextTile!=spreadTileID))markSpreadableWest;

spreadAndMove::;
((canSpread==true))spread:
((canSpread==true))move;

debugMsg::;
msg:myMsg;

debugMsgHere::;
string str = "DEBUG: Got here!"
msg:str;

# </Spreading>

# <Test>
int iterations=50
int testCount=0

testSpread::;
testCount+=1;
wait:1;
spread;
((testCount<iterations))testSpread;
# </Test>


