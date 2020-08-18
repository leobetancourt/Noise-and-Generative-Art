public class Noise {
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

    public float fractal(float x, float y, float z) {
        float frequency = 1;
        float amp = 1;
        float roughness = 3.5;
        float persistence = 0.5;

        int octaves = 5;

        float noiseVal = 0;

        for (int i = 0; i < octaves; i++) {
            float n = openSimplex2F(x * frequency, y * frequency, z);

            noiseVal += n * amp;
            frequency *= roughness;
            amp *= persistence;
        }

        return noiseVal;
    }
}
