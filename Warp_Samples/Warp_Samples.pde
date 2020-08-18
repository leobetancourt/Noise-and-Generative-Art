Noise n;

float freq = 0.0007;
float amp = 1;
float rough = 2;
float pers = 0.5;
int octaves = 5;

float warpStrength = 7000;

float z = 0;

public void settings() {
    size(1920, 1080);
}

void setup() {
    n = new Noise();
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
    //z += 0.01;
    rough += 0.001;
}

float domainWarp(float x, float y, float z) {
    // offset fractal noise using more noise (domain warp)
    float offsetX = n.fractal(x + 0, y + 0, z, 
                              freq, amp, rough, pers, octaves);
    float offsetY = n.fractal(x + 5.2, y + 2.4, z, 
                              freq, amp, rough, pers, octaves);
    
    return n.fractal(x + warpStrength * offsetX, y + warpStrength * offsetY, 0, 
                     freq, amp, rough, pers, octaves);
}
