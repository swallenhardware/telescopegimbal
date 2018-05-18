use <struts.scad>

fidelity = 200;

shaftDiameter = 10.25;
shaftLength = 10+5+9;

shaftOffset = 70-shaftLength+9;

innerRadius = 96/2;
outerRadius = innerRadius+5;

bandWidth = 30;

lowerMount();

module lowerMount() {
    copyMirror() {
        translate([shaftOffset,0,0]) rotate([0,90,0]) cylinder(shaftLength, r=shaftDiameter/2, $fn=fidelity);
    }
    
    translate([0,shaftDiameter/2,0]) rotate([90,0,0]) difference() {
        cylinder(bandWidth, r=outerRadius, $fn=fidelity);
        translate([0,0,-1]) cylinder(bandWidth+2, r=innerRadius, $fn=fidelity);
        translate([-outerRadius,0,-1]) cube([outerRadius*2,outerRadius,bandWidth+2]);
    }
}