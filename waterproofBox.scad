

insideBoxMinX=80;
insideBoxMinY=60;
insideBoxMinZ=40;

insideBoxX1=insideBoxMinX+0;
insideBoxY1=insideBoxMinY+0;
insideBoxZ1=insideBoxMinZ+0;

boxWallsThickness1=1;
boxSealingLipWidth=10;

beamsThickness1=5;

screwHoles1Radius=3/2;

boxLipThickness=2;

module triangleSupport(c1=10,c2=15,pThick=1)
{
    angle=atan(c1/c2);
    difference()
    {
        cube([c1,c2,pThick]);
        translate([c1,0,-pThick])
            rotate([0,0,angle])
                cube([c1*2,c2*2,pThick*3]);
    }
}

module fixationPillar(pillarWidth=beamsThickness1,pillarHeight=insideBoxMinZ,pillarScrewRadius=screwHoles1Radius)
{
    difference()
    {
    cube([pillarWidth,pillarWidth,pillarHeight]);
        translate([pillarWidth/2,pillarWidth/2,-pillarHeight/2])
        cylinder(r=pillarScrewRadius,h=pillarHeight*2,$fn=12);
    } 
}

module topOpenedBox(insideBoxX=insideBoxX1,insideBoxY=insideBoxY1,insideBoxZ=insideBoxZ1,boxWallsThickness=boxWallsThickness1)
{
//bottom plate
cube ([insideBoxX,insideBoxY,boxWallsThickness]);


//back plate
translate([-boxWallsThickness,-boxWallsThickness,0])
cube([boxWallsThickness,insideBoxY+boxWallsThickness*2,insideBoxZ+boxWallsThickness]);

//front plate
translate([insideBoxX,-boxWallsThickness,0])
cube([boxWallsThickness,insideBoxY+boxWallsThickness*2,insideBoxZ+boxWallsThickness]);

//left plate
translate([0,-boxWallsThickness,0])
cube([insideBoxX,boxWallsThickness,insideBoxZ+boxWallsThickness]);

//Right plate
translate([0,insideBoxY,0])
cube([insideBoxX,boxWallsThickness,insideBoxZ+boxWallsThickness]);
}

module sealingLidShape(insideBoxX=insideBoxX1,insideBoxY=insideBoxY1,insideBoxZ=insideBoxZ1,boxWallsThickness=boxWallsThickness1,lipWidth=10,lipThickness=boxLipThickness,nbHolesX=3,nbHolesY=2,holesRadius=3/2, beamsThickness=beamsThickness1)
{
    
    decalX=(insideBoxX+boxWallsThickness*2-beamsThickness)/(nbHolesX-1);
    translate([0,0,insideBoxZ+boxWallsThickness-lipThickness])
    {
        difference()
        {
        
        union()
        {
        //back
        translate([-lipWidth-boxWallsThickness,-lipWidth-boxWallsThickness,0])
        cube([lipWidth,insideBoxY+lipWidth*2+boxWallsThickness*2,lipThickness]);
        
        //left
        translate([-lipWidth-boxWallsThickness,-lipWidth-boxWallsThickness,0])
        cube([insideBoxX+lipWidth*2+boxWallsThickness*2,lipWidth,lipThickness]);
        
        //front
        translate([insideBoxX1+boxWallsThickness,-lipWidth-boxWallsThickness,0])
        cube([lipWidth,insideBoxY+lipWidth*2+boxWallsThickness*2,lipThickness]);
        
        //right
        translate([-lipWidth-boxWallsThickness,insideBoxY+boxWallsThickness,0])
        cube([insideBoxX+lipWidth*2+boxWallsThickness*2,lipWidth,lipThickness]);
        }
        
        for(i = [0 : 1 : nbHolesX-1])
        {
            translate([-boxWallsThickness+beamsThickness/2+i*decalX,-beamsThickness/2-boxWallsThickness,-1])
            cylinder(r=holesRadius,h=insideBoxZ1+lipThickness+2,$fn=12);
        }
        
        for(i = [0 : 1 : nbHolesX-1])
        {
            translate([-boxWallsThickness+beamsThickness/2+i*decalX, insideBoxY+boxWallsThickness+beamsThickness/2,-1])
            cylinder(r=holesRadius,h=insideBoxZ1+lipThickness+2,$fn=12);
        }
        
    }
        
    } 
    
}

module boxWithLidAndBeams(insideBoxX=insideBoxX1,insideBoxY=insideBoxY1,insideBoxZ=insideBoxZ1,boxWallsThickness=boxWallsThickness1,lipWidth=beamsThickness1,lipThickness=boxLipThickness,nbHolesX=3,nbHolesY=2,holesRadius=3/2, beamsThickness=beamsThickness1)
{
    sealingLidShape(lipWidth=beamsThickness1);
    topOpenedBox();
    
    externalBoxX=insideBoxX+beamsThickness*2+boxWallsThickness*2;
    externalBoxY=insideBoxY+beamsThickness*2+boxWallsThickness*2;
    
    //front(-x)
    translate([-boxWallsThickness1,externalBoxY-lipWidth-boxWallsThickness,insideBoxZ1+boxWallsThickness-lipThickness])
            rotate([90,-180,0])
                triangleSupport(lipWidth,lipWidth,externalBoxY);
    //back (+x)
    translate([insideBoxX1+boxWallsThickness1,-lipWidth-boxWallsThickness,insideBoxZ1+boxWallsThickness-lipThickness])
            rotate([90,-180,180])
                triangleSupport(lipWidth,lipWidth,externalBoxY);
    
    
    difference()
    {
        union()
        {
            //side 1 (-y)
            translate([-boxWallsThickness,-boxWallsThickness,insideBoxZ1+boxWallsThickness-lipThickness])
                    rotate([90,-180,90])
                        triangleSupport(lipWidth,lipWidth,insideBoxX+boxWallsThickness*2);
            
            //side 2 (+y)
            translate([insideBoxX1+boxWallsThickness1,insideBoxY+boxWallsThickness,insideBoxZ1+boxWallsThickness-lipThickness])
                    rotate([90,-180,270])
                        triangleSupport(lipWidth,lipWidth,insideBoxX+boxWallsThickness*2);
        }
        for(i = [0 : 1 : nbHolesX-1])
        {
            translate([-boxWallsThickness+beamsThickness/2+i*decalX,-beamsThickness/2-boxWallsThickness,-1])
            cylinder(r=holesRadius,h=insideBoxZ1+lipThickness+2,$fn=12);
        }
        
        for(i = [0 : 1 : nbHolesX-1])
        {
            translate([-boxWallsThickness+beamsThickness/2+i*decalX, insideBoxY+boxWallsThickness+beamsThickness/2,-1])
            cylinder(r=holesRadius,h=insideBoxZ1+lipThickness+2,$fn=12);
        }
    }
    
    
    decalX=(insideBoxX+boxWallsThickness*2-beamsThickness)/(nbHolesX-1);
    for(i = [0 : 1 : nbHolesX-1])
    {
        translate([-boxWallsThickness+i*decalX,-beamsThickness-boxWallsThickness,0])
            fixationPillar();
    }
    
    for(i = [0 : 1 : nbHolesX-1])
    {
        translate([-boxWallsThickness+i*decalX,insideBoxY+boxWallsThickness,0])
            fixationPillar();
    }
    translate([0,0,-insideBoxZ-boxWallsThickness+lipThickness])
    sealingLidShape(lipWidth=beamsThickness1);
}

module gasket(insideBoxX=insideBoxX1,insideBoxY=insideBoxY1,insideBoxZ=insideBoxZ1,boxWallsThickness=boxWallsThickness1,lipWidth=beamsThickness1,gasketThickness=1,nbHolesX=3,nbHolesY=2,holesRadius=3/2, beamsThickness=beamsThickness1)
{ 
    sealingLidShape(insideBoxX,insideBoxY,insideBoxZ,boxWallsThickness, lipWidth,gasketThickness,nbHolesX,nbHolesY,holesRadius, beamsThickness);
}

module flatBoxLid(insideBoxX=insideBoxX1,insideBoxY=insideBoxY1,boxWallsThickness=boxWallsThickness1,lipWidth=beamsThickness1,lidThickness=2,nbHolesX=3,nbHolesY=2,holesRadius=3/2, beamsThickness=beamsThickness1)
{
    
    decalX=(insideBoxX+boxWallsThickness*2-beamsThickness)/(nbHolesX-1);

    difference()
    {
        
        translate([-lipWidth-boxWallsThickness,-lipWidth-boxWallsThickness,0])
        cube([lipWidth*2+boxWallsThickness*2+insideBoxX,insideBoxY+lipWidth*2+boxWallsThickness*2,lidThickness]);
        
        
        
        for(i = [0 : 1 : nbHolesX-1])
        {
            translate([-boxWallsThickness+beamsThickness/2+i*decalX,-beamsThickness/2-boxWallsThickness,-1])
            cylinder(r=holesRadius,h=lidThickness+2,$fn=12);
        }
        
        for(i = [0 : 1 : nbHolesX-1])
        {
            translate([-boxWallsThickness+beamsThickness/2+i*decalX, insideBoxY+boxWallsThickness+beamsThickness/2,-1])
            cylinder(r=holesRadius,h=lidThickness+2,$fn=12);
        }
        
    }
    
}


/*
translate([0,0,1])
gasket();
translate([0,0,+insideBoxZ1+2])
flatBoxLid();*/
//boxWithLidAndBeams();


