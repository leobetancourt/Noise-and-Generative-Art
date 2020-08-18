import controlP5.*;

ControlP5 MyController;

Noise n;

float freq = 0.0005;
float amp = 1;
float rough = 3;
float pers = 0.5;

float warpStrength = 7000;

float z = 0;

public void settings() {
    size(850, 480);
}

void setup() {
    n = new Noise();
    MyController = new ControlP5(this);

    createGUI();
}

void draw() {
    loadPixels();
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;
            float val = domainWarp(x, y, z);
            pixels[i] = color(map(val, -1, 1, 0, 255));
        }
    }
    updatePixels();
    z += 0.01;
}

float domainWarp(float x, float y, float z) {
    // offset noise using more noise
    float offsetX = n.fractal(x + 0, y + 0, z, freq, amp, rough, pers, 5);
    float offsetY = n.fractal(x + 5.2, y + 2.4, z, freq, amp, rough, pers, 5);
    
    return n.fractal(x + warpStrength * offsetX, y + warpStrength * offsetY, 0, freq, amp, rough, pers, 5);
}

float[] domainWarpWithOffset(float x, float y, float z) {
    // offset noise using more noise
    float offsetX = n.fractal(x + 0, y + 0, z, freq, amp, rough, pers, 5);
    float offsetY = n.fractal(x + 5.2, y + 2.4, z, freq, amp, rough, pers, 5);
    
    return new float[] {n.fractal(x + warpStrength * offsetX, y + warpStrength * offsetY, z, freq, amp, rough, pers, 5), offsetX, offsetY};
}

void createGUI() {
    // fractal noise options
    MyController.addSlider("freq", 0.0001, 0.001, freq, 10, 10, 100, 20)
        .setColorBackground(#000000)
        .setColorForeground(#545454);

    MyController.addSlider("rough", 1, 5, rough, 10, 40, 100, 20)
        .setColorBackground(#000000)
        .setColorForeground(#545454);

    MyController.addSlider("pers", 0, 1, pers, 10, 70, 100, 20)
        .setColorBackground(#000000)
        .setColorForeground(#545454);

    MyController.addSlider("warpStrength", 5000, 10000, warpStrength, 10, 100, 100, 20)
        .setColorBackground(#000000)
        .setColorForeground(#545454);
}
