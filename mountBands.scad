use <struts.scad>

fidelity = 200;

innerRadius = 96/2;
outerRadius = innerRadius+5;

shaftDiameter = 9.75;
shaftLength = 70+9-innerRadius;

mountingBlockWidth = 9;

bandWidth = 30;

collarRadius = shaftDiameter/2+3;
collarLength = shaftLength-9-mountingBlockWidth;

upperMountHeight = shaftDiameter/2+3;

mountingHoleOffset = innerRadius+mountingBlockWidth/2;

//lowerMount();
translate([0,0,upperMountHeight]) upperMount();

module lowerMount() {
    difference() {
        union() {
            difference() {
                copyMirror() translate([innerRadius,0,0]) {
                    //shafts
                     rotate([0,90,0]) cylinder(shaftLength, r=shaftDiameter/2, $fn=fidelity);
                    
                    //upper mounting blocks
                    translate([0,shaftDiameter/2-bandWidth,-shaftDiameter/2]) cube([mountingBlockWidth, bandWidth, shaftDiameter]);
                }
                
                //set screw hole
                translate([-innerRadius-shaftLength+9+3+5,0,-shaftDiameter/2]) cylinder(shaftDiameter, r=3/2, $fn=fidelity);
            }
            
            //collar for non-gear sided
            translate([innerRadius+mountingBlockWidth,0,0]) rotate([-90,0,0]) difference() {
                rotate([0,90,0]) cylinder(collarLength, r=collarRadius, $fn=fidelity);
                translate([0,-collarRadius,shaftDiameter/2]) cube([collarLength, collarRadius*2, 10]);
            }
            
            //main band
            translate([0,shaftDiameter/2,0]) rotate([90,0,0]) difference() {
                cylinder(bandWidth, r=outerRadius, $fn=fidelity);
                translate([0,0,-1]) cylinder(bandWidth+2, r=innerRadius, $fn=fidelity);
                translate([-outerRadius,0,-1]) cube([outerRadius*2,outerRadius,bandWidth+2]);
            }
        }
        
        translate([0,shaftDiameter/2,0])mountMountingHoles();
    }
}

module upperMount() translate([0,shaftDiameter/2,0]) {
    difference() {
        union() {
            //main band
            translate([0,0,-upperMountHeight]) rotate([90,0,0]) difference() {
                cylinder(bandWidth, r=outerRadius, $fn=fidelity);
                translate([0,0,-1]) cylinder(bandWidth+2, r=innerRadius, $fn=fidelity);
                translate([-outerRadius,upperMountHeight-outerRadius*2,-1]) cube([outerRadius*2,outerRadius*2,bandWidth+2]);
        
                //extra cutout for mounting bolt heads
                translate([mountingHoleOffset,11,bandWidth/2]) rotate([-90,0,0]) cylinder(30,r=10/2,$fn=fidelity);
            }
            
            //mounting Blocks
            copyMirror() translate([innerRadius,-bandWidth,0]) cube([mountingBlockWidth, bandWidth, 3]);
        }
        
        mountMountingHoles();
    }
}

module mountMountingHoles() {
    copyMirror() translate([mountingHoleOffset,-bandWidth/2,-50]) cylinder(100, r=3/2, $fn=fidelity);
}