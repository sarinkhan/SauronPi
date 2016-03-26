use<rpiPlate5_halfFlatMount.scad>;

bottomPlateZ=5;
bottomPlateX=98-bottomPlateZ;
bottomPlateY=44;

holesDist=60;

switchesPlate1Z=40;

beamsScrewHolesRadius=3/2;

module hollowBream(x0,y0,z0,r0)
{
    difference()
    {
        cube([x0,y0,z0]);
        translate([x0/2,y0/2,-0.5])
            cylinder(r=r0,h=z0+1);
    }
}

difference()
{
openBasePlate3(chassX=bottomPlateX,chassY=bottomPlateY,beamsThick=bottomPlateZ,nbBeamsX=2,nbBeamsY=1,thickness01=bottomPlateZ);
    
  translate([33.5,20,-1])
    cylinder(r=3/2,bottomPlateZ+2,$fn=10);
    
  translate([64.5,20,-1])
    cylinder(r=3/2,bottomPlateZ+2,$fn=10);
    
  translate([bottomPlateX,36-10.5,2])
    {
      rotate([0,90,0])
        cylinder(r=1,bottomPlateZ+2,$fn=10);
    }
  translate([bottomPlateX,36+10.5,2])
    {
      rotate([0,90,0])
        cylinder(r=1,bottomPlateZ+2,$fn=10);
    }
}

//fixation camera
 /*translate([bottomPlateX+bottomPlateZ,23.5-1,0])
    cube([4,1,20]);

 translate([bottomPlateX+bottomPlateZ,23.5-1+25+0.5,0])
    cube([4,1,20]);
*/
/*
translate([15,bottomPlateY,0])
openBasePlate3(chassX=bottomPlateY,chassY=12,beamsThick=bottomPlateZ,nbBeamsX=2,nbBeamsY=0,thickness01=bottomPlateZ);*/


translate([15,-10,0])
{
color([1,0.5,0])
piSupport2(1,1,bottomPlateZ);
}

/*

translate([bottomPlateX,0,0])
{
    hollowBream(bottomPlateZ,bottomPlateZ,switchesPlate1Z,beamsScrewHolesRadius);
}
translate([bottomPlateX-10,0,0])
    hollowBream(bottomPlateZ,bottomPlateZ,switchesPlate1Z,beamsScrewHolesRadius);

translate([bottomPlateX,bottomPlateY/3,0])
    hollowBream(bottomPlateZ,bottomPlateZ,switchesPlate1Z,beamsScrewHolesRadius);



translate([bottomPlateX,2*bottomPlateY/3,0])
hollowBream(bottomPlateZ,bottomPlateZ,switchesPlate1Z,beamsScrewHolesRadius);
*/

/*
translate([bottomPlateX,bottomPlateY/3+5+25,0])
cube([bottomPlateZ,bottomPlateZ,switchesPlate1Z]);
*/