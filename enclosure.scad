battSlotsSpacingX=1;
beamsThickness2=5;
firstStageHeight=28;

include<../parts/lipoBattHolder.scad>
include<waterproofBox.scad>
include<../parts/rpiPlate5_halfFlatMount_mod.scad>




//constraints : these are the minimal internal dimensions of the box
insideBoxMinX=basicBattHolderLength;
insideBoxMinY=80+2*beamsThickness2;
insideBoxMinZ=70;




//if you want to alter the box size, change the values here, keeping the min sizes and adding a value : 
insideBoxX1=insideBoxMinX+battSlotsSpacingX*2+25;
insideBoxY1=insideBoxMinY+0;
insideBoxZ1=insideBoxMinZ+0;




echo ("inside box X : ");
echo(insideBoxX1);
echo ("inside box Y : ");
echo(insideBoxY1);
echo ("inside box Z : ");
echo(insideBoxZ1);

//basicBattHolderWidth
boxWallsThickness1=1;
boxSealingLipWidth=beamsThickness2;
screwHoles1Radius=3/2;



secondStageDecal=0.5;


cameraHoleRadius=20/2;
cameraHoleZDecal=5;
cameraSkirtSupportThickness=7;
cameraSkirtSupportBaseWidth=cameraHoleRadius*2+20;
cameraSkirtSupportBaseHeight=cameraSkirtSupportBaseWidth;
cameraSkirtSupportDecalY=(cameraSkirtSupportBaseWidth-cameraHoleRadius*2)/2;
cameraSkirtSupportDecalZ=(cameraSkirtSupportBaseHeight-cameraHoleRadius*2)/2;
cameraSkirtSupportScrewHolesDistFromEdge=4;

cameraHole=1;   //set to 1 for a camera hole, 0 for no hole

buttonsHoles=1; //set to 1 for button holes, 0 for no hole
buttonsHolesRadius=16.5/2;
buttonsCount1=3;
buttonsMargin1=5;

totalBoundingBoxX=insideBoxX1+2*boxWallsThickness1+2*boxSealingLipWidth;
totalBoundingBoxY=insideBoxY1+2*boxWallsThickness1+2*boxSealingLipWidth;
totalBoundingBoxZ=insideBoxZ1+boxWallsThickness1+0;//define

module cameraSkirtBaseShape()
{
                   difference()
                {
                    cube([cameraSkirtSupportThickness,cameraSkirtSupportBaseWidth,cameraSkirtSupportBaseHeight]);   
                    translate([-cameraSkirtSupportThickness/2,cameraSkirtSupportScrewHolesDistFromEdge,cameraSkirtSupportScrewHolesDistFromEdge])
                        rotate([0,90,0])
                            cylinder(r=screwHoles1Radius,h=cameraSkirtSupportThickness*2,$fn=64);
                    translate([-cameraSkirtSupportThickness/2,cameraSkirtSupportBaseWidth-cameraSkirtSupportScrewHolesDistFromEdge,cameraSkirtSupportScrewHolesDistFromEdge])
                        rotate([0,90,0])
                            cylinder(r=screwHoles1Radius,h=cameraSkirtSupportThickness*2,$fn=64);
                    translate([-cameraSkirtSupportThickness/2, cameraSkirtSupportScrewHolesDistFromEdge, cameraSkirtSupportBaseHeight-cameraSkirtSupportScrewHolesDistFromEdge])
                        rotate([0,90,0])
                            cylinder(r=screwHoles1Radius,h=cameraSkirtSupportThickness*2,$fn=64);
                    translate([-cameraSkirtSupportThickness/2, cameraSkirtSupportBaseWidth-cameraSkirtSupportScrewHolesDistFromEdge, cameraSkirtSupportBaseHeight-cameraSkirtSupportScrewHolesDistFromEdge])
                        rotate([0,90,0])
                            cylinder(r=screwHoles1Radius,h=cameraSkirtSupportThickness*2,$fn=64);
                }
}

module mainBox()
{

difference()
{
    union()
    {
        boxWithLidAndBeams();
         if(cameraHole==1)
        {
            translate([-boxWallsThickness1-cameraSkirtSupportThickness,insideBoxY1/2-cameraHoleRadius-cameraSkirtSupportDecalY,firstStageHeight+cameraHoleZDecal+beamsThickness2-cameraSkirtSupportDecalZ])
            {
                cameraSkirtBaseShape();
                translate([cameraSkirtSupportThickness,cameraSkirtSupportBaseWidth,0])
            rotate([90,-180,0])
                triangleSupport(cameraSkirtSupportThickness,cameraSkirtSupportThickness,cameraSkirtSupportBaseWidth);
            }
        }
    }
    if(cameraHole==1)
    {
        translate([-boxWallsThickness1*2-cameraSkirtSupportThickness,0+insideBoxY1/2,firstStageHeight+cameraHoleZDecal+cameraHoleRadius+beamsThickness2])
            rotate([0,90,0])                 
                cylinder(r=cameraHoleRadius,h=boxWallsThickness1*4+cameraSkirtSupportThickness*2,$fn=64);
    }
    
    //buttonDecalY*i+buttonsHolesRadius+buttonsHolesRadius*2*(i-1)
    buttonDecalY=(insideBoxY1-buttonsHolesRadius*2*buttonsCount1-beamsThickness*2 - buttonsMargin1*2)/buttonsCount1;
    if(buttonsHoles==1)
    {
        for(i = [0 : 1 : buttonsCount1-1])
        {
            translate([insideBoxX1-boxWallsThickness1*2, beamsThickness2+buttonsHolesRadius+buttonDecalY*i  +buttonsHolesRadius*2*(i)+buttonsMargin1,buttonsHolesRadius+boxWallsThickness1+buttonsMargin1])
                rotate([0,90,0])                 
                cylinder(r=buttonsHolesRadius,h=boxWallsThickness1*4,$fn=64);
        }

            
    }
}

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


cameraPiCameraAxisZ=14;
cameraSupportX=3;
cameraSupportY=25;
cameraSupportZ=24;
cameraSupportZ=cameraPiCameraAxisZ;
cameraSupportBeamsY=7;

cameraSupportBaseX=beamsThickness2;
cameraSupportBaseZ=cameraHoleZDecal+cameraHoleRadius-cameraPiCameraAxisZ;
module cameraSupport()
{
    cube([cameraSupportBaseX,cameraSupportY,cameraSupportBaseZ]);
    translate([0,0,cameraSupportBaseZ])
    cube([cameraSupportX,cameraSupportBeamsY,cameraSupportZ]);
    translate([0,cameraSupportY-cameraSupportBeamsY,cameraSupportBaseZ])
    cube([cameraSupportX,cameraSupportBeamsY,cameraSupportZ]);
}


module electronicsPlate()
{
    translate([0,0,boxWallsThickness1+firstStageHeight])
    {
        difference()
        {
            union()
            {
                translate([secondStageDecal,secondStageDecal,0])
                    cube([insideBoxX1-2*secondStageDecal,beamsThickness2,beamsThickness2]);
                translate([secondStageDecal,secondStageDecal,0])
                    cube([beamsThickness2,insideBoxY1-2*secondStageDecal,beamsThickness2]);
                translate([secondStageDecal,insideBoxY1-beamsThickness2-secondStageDecal,0])
                    cube([insideBoxX1-2*secondStageDecal,beamsThickness1,beamsThickness2]);
                translate([insideBoxX1-beamsThickness2-secondStageDecal,secondStageDecal,0])
                    cube([beamsThickness2,insideBoxY1-2*secondStageDecal,beamsThickness2]);
                translate([insideBoxX1/2-beamsThickness2-secondStageDecal,secondStageDecal,0])
                    cube([beamsThickness2,insideBoxY1-2*secondStageDecal,beamsThickness2]);
            }
            //front
            translate([beamsThickness2/2,beamsThickness2/2,-beamsThickness2/2])
                cylinder(r=screwHoles1Radius, h=beamsThickness2*2,$fn=12);
            translate([beamsThickness2/2,insideBoxY1-beamsThickness2/2,-beamsThickness2/2])
                cylinder(r=screwHoles1Radius, h=beamsThickness2*2,$fn=12);
            //middle
            translate([insideBoxX1/2-beamsThickness2/2,beamsThickness2/2,-beamsThickness2/2])
                cylinder(r=screwHoles1Radius, h=beamsThickness2*2,$fn=12);
            translate([insideBoxX1/2-beamsThickness2/2,insideBoxY1-beamsThickness2/2,-beamsThickness2/2])
                cylinder(r=screwHoles1Radius, h=beamsThickness2*2,$fn=12);
            //back
            translate([insideBoxX1-beamsThickness2/2,beamsThickness2/2,-beamsThickness2/2])
                cylinder(r=screwHoles1Radius, h=beamsThickness2*2,$fn=12);
            translate([insideBoxX1-beamsThickness2/2,insideBoxY1-beamsThickness2/2,-beamsThickness2/2])
                cylinder(r=screwHoles1Radius, h=beamsThickness2*2,$fn=12);
        }
        
        translate([0,(insideBoxY1-cameraSupportY)/2,beamsThickness2])
        cameraSupport();
        piSupportSpacingX=5+secondStageDecal;
        piSupportSpacingY=(insideBoxY1-beamsThickness2*2-chassisY)/2;
        
        translate([piSupportSpacingX,beamsThickness2+piSupportSpacingY,0])
        color([1,0.5,0])
            piSupport2(1,1,h0);
        translate([piSupportSpacingX+chassisX+2,secondStageDecal,0])
                    cube([beamsThickness1,insideBoxY1-2*secondStageDecal,beamsThickness2]);
        
    }
}   
    
mainBox();

electronicsPlate();
    
    
    
//gasket();

//translate([0,0,+insideBoxZ1+2])
//flatBoxLid();

    
    
    
    
    
    
    
    
    

