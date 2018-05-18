innerRadius = 31/2;
outerRadius = 40/2;

difference() {
    cylinder(9, outerRadius,outerRadius, $fn=200);
    
    cylinder(9, innerRadius,innerRadius, $fn=200);
}