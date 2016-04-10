battLength=69.4;
battRadius=18.7/2;
battHolderWallsThickness=1.3;
battBoxLenghtAdjustment=10;

battTabWidth=6.8;
battTabLenth=14;
battTabMaxThickness=4.6;
battTabLowPartHeight=4;

simpleFixationEarsX=8;
fixationHolesRadius=3/2;

basicBattHolderWidth=battRadius*2+battHolderWallsThickness*2;
basicBattHolderLength=battLength+battBoxLenghtAdjustment+battHolderWallsThickness*2;


module battTabHolder()
{
    translate([0,battRadius-battTabWidth/2-battHolderWallsThickness,0])
cube([battHolderWallsThickness*3,battHolderWallsThickness,battRadius*1.5]);

translate([0,battRadius+battTabWidth/2,0])
cube([battHolderWallsThickness*3,battHolderWallsThickness,battRadius*1.5]);

translate([battHolderWallsThickness*2,battRadius-battTabWidth/2,battHolderWallsThickness])
cube([battHolderWallsThickness,battTabWidth,battTabLowPartHeight]);

translate([battHolderWallsThickness*2,battRadius-battTabWidth/2,battHolderWallsThickness])
cube([battHolderWallsThickness,battHolderWallsThickness,battRadius]);

translate([battHolderWallsThickness*2,battRadius+battTabWidth/2-battHolderWallsThickness,battHolderWallsThickness])
cube([battHolderWallsThickness,battHolderWallsThickness,battRadius]);
}

module basicBattHolder()
{
    translate([battHolderWallsThickness,battHolderWallsThickness,0])
    {
cube([battLength+battBoxLenghtAdjustment,battRadius*2,battHolderWallsThickness]);
translate([-battHolderWallsThickness,0,0])
cube([battHolderWallsThickness,battRadius*2,battRadius*1.5]);

battTabHolder();

translate([battLength+battBoxLenghtAdjustment,0,0])
cube([battHolderWallsThickness,battRadius*2,battRadius*1.5]);

translate([battLength+battBoxLenghtAdjustment,battRadius*2,0])
rotate([0,0,180])
battTabHolder();

translate([-battHolderWallsThickness,-battHolderWallsThickness,0])
cube([battLength+battBoxLenghtAdjustment+battHolderWallsThickness*2,battHolderWallsThickness,battRadius]);

translate([-battHolderWallsThickness,battRadius*2,0])
cube([battLength+battBoxLenghtAdjustment+battHolderWallsThickness*2,battHolderWallsThickness,battRadius]);
    }
}


module simpleFixationEar()
{
translate([-battHolderWallsThickness-simpleFixationEarsX+0.2,-battHolderWallsThickness,0])
{
    difference()
    {
        cube([simpleFixationEarsX,battRadius*2+2*battHolderWallsThickness,battHolderWallsThickness]);
        translate([simpleFixationEarsX/2,battRadius+fixationHolesRadius,-battHolderWallsThickness/2])
        cylinder(r=fixationHolesRadius,h=battHolderWallsThickness*2,$fn=12);
    }
}
}

module battHolderWithBasicEars()
{
    basicBattHolder();
    simpleFixationEar();
    translate([battLength+battBoxLenghtAdjustment,battRadius*2,0])
    rotate([0,0,180])
    simpleFixationEar();
}

//battHolderWithBasicEars();






