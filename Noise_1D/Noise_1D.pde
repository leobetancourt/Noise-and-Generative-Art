float freq = 0.005;

int x = 0;
float rectWidth = 1;

void setup() {
    size(1920, 1080);
    background(28, 28, 28);
}

void draw() {
    noise1D();
}

void noise1D() {
    if (x < width/rectWidth) {
        // perlin noise (processing default)
        float n = noise(x * freq);
        n = map(n, 0, 1, height, 0);
        noStroke();
        fill(255);
        rect(x * rectWidth, height - n, rectWidth, n);
        x++;
    }
}
