class Noise {
    private OpenSimplexNoise simplex;
    private OpenSimplex2F simplex2F;

    public Noise() {
        simplex = new OpenSimplexNoise();
        simplex2F = new OpenSimplex2F(3);
    }

    public float perlin(float x, float y, float z) {
        return map(noise(x, y, z), 0, 1, -1, 1);
    }

    public float openSimplex(float x, float y, float z) {
        return (float) simplex.eval(x, y, z);
    }

    public float openSimplex2F(float x, float y, float z) {
        return (float) simplex2F.noise3_Classic((double) x, (double) y, (double) z);
    }

    public float fractal(float x, float y, float z, float freq, float amp, float rough, float pers, int oct) {
        float frequency = freq;
        float amplitude = amp;
        float roughness = rough;
        float persistence = pers;

        int octaves = oct;

        float noiseVal = 0;

        for (int i = 0; i < octaves; i++) {
            float n = openSimplex2F(x * frequency, y * frequency, z);

            noiseVal += n * amplitude;
            frequency *= roughness;
            amplitude *= persistence;
        }

        return noiseVal;
    }
}