public class Item extends Block {

    private final String itemName;

    public Item(int row, int col, String name) {
        super(true, row, col);
        this.name = "ITEM";
        itemName = name;
    }
}