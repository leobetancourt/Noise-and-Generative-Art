

void noise1D() {
    float rectWidth = 1;
    for (int x = 0; x < width/rectWidth; x++) {
        float n = noise(x * freq);
        n = map(n, 0, 1, height, 0);
        noStroke();
        fill(0);
        rect(x * rectWidth, height - n, rectWidth, n);
        println(x);
    }
}

// make this into a class or something
void domainWrap() {
    loadPixels();
    OpenSimplexNoise noise = new OpenSimplexNoise();
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // get pixel position in pixels array
            int i = x + y * width;
            float qx = (float) noise.eval((x * freq) + 0, (y * freq) + 0);
            float qy = (float) noise.eval((x * freq) + 5.2, (y*freq) + 4);
            float n = (float) noise.eval((x* freq) + 2 * qx, (y * freq) + 2 * qy, z);
            pixels[i] = color(map(n, -1, 1, 0, 255));
        }
    }
    updatePixels();
    z += 0.01;
}