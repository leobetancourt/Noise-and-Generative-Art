int boxWidth = 500;
float planeZ = boxWidth / 2;

void setup() {
    size(1920, 1080, P3D);
}

void draw() {
    background(20);
    directionalLight(255, 255, 255, -0.1, 0, -1);

    pushMatrix();
    camera(width, 100, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
    translate(width/2, height/2, 0);
    noStroke();
    fill(255);
    box(boxWidth);
    fill(255, 0, 0, 200);
    rectMode(CENTER);
    translate(0, 0, planeZ);
    rect(0, 0, boxWidth + 100, boxWidth + 100);
    popMatrix();

    planeZ -= 1;
}
