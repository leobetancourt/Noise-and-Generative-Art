Noise noise = new Noise();

float freq = 0.0001;

float z = 120;

color c1 = color(255);

public void settings() {
    size(1920, 1080);
    //fullScreen();
}

void setup() {

}

void draw() {
    loadPixels();
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;
            float[] vals = domainWarp(x * freq, y * freq, z);
            float noiseVal = vals[0];
            float ox = abs(vals[1]);
            float oy = abs(vals[2]);
            float omag = sqrt(ox * ox + oy * oy);
            color c2 = color(0 * ox, 255 * oy, 150);
            pixels[i] = lerpColor(c1, c2, 1 - abs(noiseVal));
            // pixels[i] = color(map(noiseVal, -1, 1, 0, 255));
        }
    }
    updatePixels();
    //noLoop();
    z += 0.001;
}

float[] domainWarp(float x, float y, float z) {
    float offsetX = noise.fractal(x + 0, y + 0, z);
    float offsetY = noise.fractal(x + 5.2, y + 2.4, z);
    
    return new float[] {noise.fractal(x + 3 * offsetX, y + 3 * offsetY, 0), offsetX, offsetY};
}

void caustics() {
    color[] colors = {color(255), color(0, 191, 241), color(1, 125, 197), color(33, 124, 210)};
    float[] bounds = {0.0, 0.09, 0.75, 1.0};
    Gradient g = new Gradient(colors, bounds);

    loadPixels();
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;
            float val = noise.fractal(x, y, z);
            val = abs(val);
            pixels[i] = g.getColor(val);
        }
    }
    updatePixels();
    z += 0.02;
}
