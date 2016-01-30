import java.util.ArrayList;

public class Player extends Block {
    public static final int UP = 0;
    public static final int LEFT = 1;
    public static final int DOWN = 2;
    public static final int RIGHT = 3;
    public int direction;
    public ArrayList<Item> items;

    private PImage rD1;
    private PImage rD2;
    private PImage rD3;
    private PImage rD4;

    public Player(int row, int col) {
        super(true, row, col);
        direction = RIGHT;
        items = new ArrayList<Item>();
  
        rD1 = loadImage("Rdir1.png");
        rD2 = loadImage("Rdir2.png");
        rD3 = loadImage("Rdir3.png");
        rD4 = loadImage("Rdir4.png");
    }

    public int[] getCoordinatesInFront() {
        int x = 0;
        int y = 0;
        switch (direction) {
            case UP:
                x = col;
                y = --row;
                break;
            case DOWN:
                x = col;
                y = ++row;
                break;
            case LEFT:
                x = --col;
                y = row;
                break;
            case RIGHT:
                x = ++col;
                y = row;
                break;
        }
        return new int[]{y, x};
    }

    public PImage getCurrentImage() {
        switch(direction) {
            case UP:
                return rD2;
            case DOWN:
                return rD4;
            case LEFT:
                return rD1;
            default:
                return rD3;
        }
    }

    public void pickUpItem(Item item) {
        items.add(item);
    }
}