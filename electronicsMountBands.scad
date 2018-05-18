use <struts.scad>

fidelity = 200;

innerRadius = 96/2;
outerRadius = innerRadius+5;

screwHoleOffset = 7;

voidWidth = 5;

shaftDiameter = 9.75;
shaftLength = 70+9-innerRadius;

mountingBlockWidth = 10;
mountingBlockThickness = 3;

bandWidth = 30;

collarRadius = shaftDiameter/2+3;
collarLength = shaftLength-9-mountingBlockWidth;

upperMountHeight = shaftDiameter/2+3;

mountingHoleOffset = innerRadius+screwHoleOffset;

piMountOffsetX = 49;
piMountOffsetY = 58;
piMountThickness = 3;

stepDriverMountPylonSeperation = 29.5;

lowerMount();
upperMount();

module lowerMount() {
    difference() {
        union() {
            copyMirror() translate([innerRadius,0,0]) {
                //upper mounting blocks
                translate([0,-bandWidth,-voidWidth/2-mountingBlockThickness]) cube([mountingBlockWidth, bandWidth, mountingBlockThickness]);
            }
            
            //main band
            rotate([90,0,0]) difference() {
                cylinder(bandWidth, r=outerRadius, $fn=fidelity);
                translate([0,0,-1]) cylinder(bandWidth+2, r=innerRadius, $fn=fidelity);
                translate([-outerRadius,-voidWidth/2,-1]) cube([outerRadius*2,outerRadius,bandWidth+2]);
            }
        }
        
        mountMountingHoles();
    }
}

module upperMount() {
    difference() {
        union() {
            //main band
            translate([0,0,0]) rotate([90,0,0]) difference() {
                cylinder(bandWidth, r=outerRadius, $fn=fidelity);
                translate([0,0,-1]) cylinder(bandWidth+2, r=innerRadius, $fn=fidelity);
                translate([-outerRadius,voidWidth/2-outerRadius*2,-1]) cube([outerRadius*2,outerRadius*2,bandWidth+2]);
            }
            
            //mounting Blocks
            copyMirror() translate([innerRadius,-bandWidth,voidWidth/2]) cube([mountingBlockWidth, bandWidth, 3]);
        }
        
        mountMountingHoles();
    }
    
    //raspberry pi mount
    difference() {
        //mount plate
        translate([-piMountOffsetX/2-3,-bandWidth,outerRadius-piMountThickness]) cube([piMountOffsetX+6,piMountOffsetY+6,piMountThickness]);
        
        //mount holes
        translate([0,piMountOffsetY/2+3-bandWidth,20]) raspberryPiMountHoles();
    }
    
    //big easydriver mount pylons
    copyMirror([1,0,0]) rotate([0,55,0]) translate([0, -bandWidth+4, outerRadius-4]) {
        copyMirror([1,0,0]) translate([-stepDriverMountPylonSeperation/2,0,0]) difference() {
            cylinder(8, r=8/2, $fn=fidelity);
            cylinder(8, r=3/2, $fn=fidelity);
        }
    }
}

module mountMountingHoles() {
    copyMirror() translate([mountingHoleOffset,-bandWidth/2,-50]) cylinder(100, r=3/2, $fn=fidelity);
}

module raspberryPiMountHoles() {
    copyMirror() {
        translate([piMountOffsetX/2, piMountOffsetY/2,-50]) cylinder(100, r=3/2, $fn=fidelity);
        translate([piMountOffsetX/2, -piMountOffsetY/2,-50]) cylinder(100, r=3/2, $fn=fidelity);
    }
}