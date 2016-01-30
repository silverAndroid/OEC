public class Block {
    public static final int PIXEL_SIZE = 40;
    public boolean visible;
    public int row;
    public int col;

    public Block(boolean isVisible, int row, int col) {
        visible = isVisible;
        this.row = row;
        this.col = col;
    }

    public int getX() {
        return col * PIXEL_SIZE;
    }

    public int getY() {
        return row * PIXEL_SIZE;
    }
}