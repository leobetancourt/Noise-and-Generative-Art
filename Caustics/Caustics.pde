Noise noise;
Gradient gradient;

float ROUGHNESS = 1.5;
float PERSISTENCE = 0.5;
float BASE_FREQ = 0.007;
float BASE_AMP = 1;

float zoff = 0;
float zinc = 0.005;

public void settings() {
    size(1920, 1080);
}

void setup() {
    // create new LayeredNoise
    noise = new Noise();
    color[] colors = {color(255), color(0, 191, 241), color(1, 125, 197), color(33, 124, 210)};
    float[] bounds = {0.0, 0.09, 0.75, 1.0};
    gradient = new Gradient(colors, bounds);
}

void draw() {
    caustics();
}

void caustics() {
    loadPixels();
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            int i = x + y * width;
            float val = abs(noise.fractal(x, y, zoff, BASE_FREQ, BASE_AMP, ROUGHNESS, PERSISTENCE, 2));
            pixels[i] = gradient.getColor(val);
        }
    }
    updatePixels();
    // increment the zoff (time)
    zoff += zinc;
}
