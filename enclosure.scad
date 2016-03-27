battSlotsSpacingX=1;
beamsThickness2=5;
firstStageHeight=24;

include<../parts/lipoBattHolder.scad>
include<waterproofBox.scad>



//constraints : these are the minimal internal dimensions of the box
insideBoxMinX=basicBattHolderLength;
insideBoxMinY=60+2*beamsThickness2;
insideBoxMinZ=60;




//if you want to alter the box size, change the values here, keeping the min sizes and adding a value : 
insideBoxX1=insideBoxMinX+battSlotsSpacingX*2+20;
insideBoxY1=insideBoxMinY+0;
insideBoxZ1=insideBoxMinZ+0;


//basicBattHolderWidth
boxWallsThickness1=1;
boxSealingLipWidth=10;
screwHoles1Radius=3/2;



secondStageDecal=0.5;

module mainBox()
{

boxWithLidAndBeams();

maxBattSlots=floor((insideBoxY1-2*beamsThickness2)/basicBattHolderWidth);
nbBattSlots=maxBattSlots;


battSlotsSpacingY=(insideBoxY1-(nbBattSlots*basicBattHolderWidth)-2*beamsThickness2)/nbBattSlots;

    for(i = [0 : 1 : nbBattSlots-1])
    {
        translate([battSlotsSpacingX,beamsThickness2+battSlotsSpacingY/2+(basicBattHolderWidth+battSlotsSpacingY)*i,boxWallsThickness1])
            basicBattHolder();
    }
    
    translate([0,0,boxWallsThickness1])
            fixationPillar(beamsThickness1,firstStageHeight,screwHoles1Radius);
    translate([0,insideBoxY1-beamsThickness2,boxWallsThickness1])
            fixationPillar(beamsThickness1,firstStageHeight,screwHoles1Radius);
    
    translate([insideBoxX1/2-beamsThickness2,0,boxWallsThickness1])
            fixationPillar(beamsThickness1,firstStageHeight,screwHoles1Radius);
    translate([insideBoxX1/2-beamsThickness2,insideBoxY1-beamsThickness2,boxWallsThickness1])
            fixationPillar(beamsThickness1,firstStageHeight,screwHoles1Radius);
    
    translate([insideBoxX1-beamsThickness2,0,boxWallsThickness1])
            fixationPillar(beamsThickness1,firstStageHeight,screwHoles1Radius);
    translate([insideBoxX1-beamsThickness2,insideBoxY1-beamsThickness2,boxWallsThickness1])
            fixationPillar(beamsThickness1,firstStageHeight,screwHoles1Radius);
}    



mainBox();
    translate([0,0,boxWallsThickness1+firstStageHeight])
    {
        translate([secondStageDecal,secondStageDecal,0])
            cube([insideBoxX1-2*secondStageDecal,beamsThickness1,beamsThickness1]);
        translate([secondStageDecal,secondStageDecal,0])
            cube([beamsThickness1,insideBoxY1-2*secondStageDecal,beamsThickness1]);
        translate([secondStageDecal,insideBoxY1-beamsThickness1-secondStageDecal,0])
            cube([insideBoxX1-2*secondStageDecal,beamsThickness1,beamsThickness1]);
        translate([insideBoxX1-beamsThickness1-secondStageDecal,secondStageDecal,0])
            cube([beamsThickness1,insideBoxY1-2*secondStageDecal,beamsThickness1]);
        translate([insideBoxX1/2-beamsThickness1-secondStageDecal,secondStageDecal,0])
            cube([beamsThickness1,insideBoxY1-2*secondStageDecal,beamsThickness1]);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

