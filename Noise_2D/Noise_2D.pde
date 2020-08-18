float freq = 0.005;
float z = 0;

void setup() {
    size(1920, 1080);
}

void draw() {
    background(28);
    noise2D();
}

void noise2D() {
    loadPixels();
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;
            // get noise value at position (x, y, z)
            float n = noise(x * freq, y * freq, z);
            // color pixel according to noise value
            pixels[i] = lerpColor(color(255), color(0, 38, 166), n);
        }
    }
    updatePixels();

    z += 0.01;
}
