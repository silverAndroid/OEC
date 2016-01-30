public class Block {
    public static final String WALL = "WALL";
    public static final String KEY = "KEY";
    public static final String GATE = "GATE";
    public static final int PIXEL_SIZE = 40;
    public String name;
    public boolean visible;
    public int row;
    public int col;
    public String[] types = {WALL};

    public Block(boolean isVisible, int row, int col) {
        visible = isVisible;
        this.row = row;
        this.col = col;
        name = "";
    }

    public int getX() {
        return col * PIXEL_SIZE;
    }

    public int getY() {
        return row * PIXEL_SIZE;
    }
}