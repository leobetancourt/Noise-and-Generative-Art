public class Gradient {

    private color[] colors;
    private float[] bounds;

    public Gradient(color[] c, float[] b) {
        colors = c;
        bounds = b;
    }

    public color getColor(float amt) {
        for (int i = 1; i < bounds.length; i++) {
            if (amt < bounds[i]) {
                float percent = (amt - bounds[i-1]) / (bounds[i] - bounds[i-1]);
                return lerpColor(colors[i-1], colors[i], percent);
            }
        }

        return colors[colors.length - 1];
    }
}