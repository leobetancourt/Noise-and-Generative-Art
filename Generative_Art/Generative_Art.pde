Noise n;
Gradient grad;

float freq = 0.0005;
float amp = 1;
float rough = 4;
float pers = 0.35;
int octaves = 5;

float warpStrength = 5000;

float z = 4;

public void settings() {
    size(1920, 1080);
}

void setup() {
    n = new Noise();
}

void draw() {
    loadPixels();
    art3();
    updatePixels();
    z += 0.0005;
}

float domainWarp(float x, float y, float z) {
    // offset noise using more noise
    float offsetX = n.fractal(x + 5, y + 2, z, freq, amp, rough, pers, octaves);
    float offsetY = n.fractal(x + 10, y + 5, z, freq, amp, rough, pers, octaves);
    
    return n.fractal(x + warpStrength * offsetX, y + warpStrength * offsetY, z, freq, amp, rough, pers, octaves);
}

float[] domainWarpWithOffset(float x, float y, float z) {
    // offset noise using more noise
    float offsetX = n.fractal(x + 0, y + 0, z, freq, amp, rough, pers, octaves);
    float offsetY = n.fractal(x + 5.2, y + 2.4, z, freq, amp, rough, pers, octaves);
    
    return new float[] {n.fractal(x + warpStrength * offsetX, y + warpStrength * offsetY, z, freq, amp, rough, pers, octaves), offsetX, offsetY};
}

void art1() {
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;
            float val = domainWarp(x, y, z);
            float[] vals = domainWarpWithOffset(x, y, z);
            float noiseVal = vals[0];
            float ox = abs(vals[1]);
            float oy = abs(vals[2]);
            float omag = sqrt(ox * ox + oy * oy);
            color c1 = color(255);
            color c2 = color(255 * ox, 150 * oy, 150);
            pixels[i] = lerpColor(c1, c2, 1 - abs(noiseVal));
        }
    }
}

void art2() {
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;
            float[] vals = domainWarpWithOffset(x, y, z);
            float noiseVal = vals[0];
            float ox = (vals[1] + 1) / 2;
            float oy = (vals[2] + 1) / 2;
            float omag = sqrt(ox * ox + oy * oy);
            color col = lerpColor(color(255, 212, 71), color(88, 24, 69), abs(noiseVal));
            col = lerpColor(color(199, 0, 57), col, omag);
            pixels[i] = col;
        }
    }
}

void art3() {
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;
            float[] vals = domainWarpWithOffset(x, y, z);
            float noiseVal = vals[0];
            float ox = abs(vals[1]);
            float oy = abs(vals[2]);
            float omag = sqrt(ox * ox + oy * oy);
            color c1 = color(255);
            color c2 = color(0, 255 * ox, 230 * omag);
            pixels[i] = lerpColor(c1, c2, 1 - abs(noiseVal));
        }
    }
}
