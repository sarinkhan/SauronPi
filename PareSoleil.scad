
baseX=50;
baseY=37;
baseZ=6;

centralHoleRadius=26.6/2;
centralHoleLipRadius=35/2;


fixScrews1Radius=3/2;
fixScrews1DistFromEdge=5;

skirtHeight=20;
skirtWallsThickness=1.2;

gasketThickness=1;


module fixScrews()
{
translate([fixScrews1DistFromEdge,fixScrews1DistFromEdge,-1])
{
    cylinder(fixScrews1Radius,h=baseZ*2,$fn=16);
}

translate([fixScrews1DistFromEdge,baseY-fixScrews1DistFromEdge,-1])
{
    cylinder(fixScrews1Radius,h=baseZ*2,$fn=16);
}

translate([baseX-fixScrews1DistFromEdge,fixScrews1DistFromEdge,-1])
{
    cylinder(fixScrews1Radius,h=baseZ*2,$fn=16);
}

translate([baseX-fixScrews1DistFromEdge,baseY-fixScrews1DistFromEdge,-1])
{
    cylinder(fixScrews1Radius,h=baseZ*2,$fn=16);
}
}


module fixationBasePlate()
{
difference()
{
    cube([baseX,baseY,baseZ]);
    translate([baseX/2,baseY/2,-baseZ/2])
    {
        cylinder(r=centralHoleRadius,h=baseZ*2,$fn=64);
    }
    fixScrews();
}
}

module gasket()
{
    difference()
    {
        cube([baseX,baseY,gasketThickness]);
        translate([baseX/2,baseY/2,-baseZ/2])
        {
            cylinder(r=centralHoleRadius,h=baseZ*2,$fn=64);
        }
        fixScrews();
    }
}


module sunSkirt()
{
fixationBasePlate();
    translate([baseX/2-centralHoleRadius-2.5,baseY/2-centralHoleRadius-2.5,baseZ])
    {
        cube([skirtWallsThickness,centralHoleRadius*2+5,skirtHeight]);
    }
    translate([baseX/2+centralHoleRadius+1,baseY/2-centralHoleRadius-2.5,baseZ])
    {
        cube([skirtWallsThickness,centralHoleRadius*2+5,skirtHeight]);
    }

    translate([baseX/2-centralHoleRadius-2.5,baseY/2-centralHoleRadius-2.5,baseZ])
    {
        cube([centralHoleRadius*2+3.5,skirtWallsThickness,skirtHeight]);
    }
    
    translate([baseX/2-centralHoleRadius-2.5,baseY/2+centralHoleRadius+2.5-skirtWallsThickness,baseZ])
    {
        cube([centralHoleRadius*2+3.5,skirtWallsThickness,skirtHeight]);
    }

}
//fixationBasePlate();
//gasket();
sunSkirt();



