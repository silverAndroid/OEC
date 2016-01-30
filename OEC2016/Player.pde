import java.util.ArrayList;

public class Player extends Block {
    public static final int UP = 0;
    public static final int LEFT = 1;
    public static final int DOWN = 2;
    public static final int RIGHT = 3;
    public int direction;
    public ArrayList<Item> items;

    public Player(int row, int col) {
        super(true, row, col);
        direction = UP;
        items = new ArrayList<>();
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

    public void pickUpItem(Item item) {
        items.add(item);
    }
}