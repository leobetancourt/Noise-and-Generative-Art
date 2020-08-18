Noise n;

float rough = 2;
float pers = 0.5;
float freq = 0.08;
float amp = 1;
int octaves = 5;

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
            float val = n.fractal(x, y, 0, freq, amp, rough, pers, octaves);
            pixels[i] = color(map(val, -1, 1, 0, 255));
        }
    }
    updatePixels();

}