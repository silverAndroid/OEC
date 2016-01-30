import java.util.concurrent.ThreadLocalRandom;

public class Board {
    public int numRows;
    public int numCols;
    public Block[][] board;
    int playerRow;
    int playerCol;

    public Board(int playerRow, int playerCol) {
        this(100, 100, playerRow, playerCol);
    }

    public Board(int rows, int cols, int playerRow, int playerCol) {
        numRows = rows;
        numCols = cols;
        this.playerRow = playerRow;
        this.playerCol = playerCol;
        board = new Block[rows][cols];
        /*for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (i == playerRow && j == playerCol) {
                    board[i][j] = new Player(i, j);
                } else {
                    int random = ThreadLocalRandom.current().nextInt(0, 2);
                    Block block = new Block(true, i, j);
                    try {
                        block.name = block.types[random];
                    } catch (ArrayIndexOutOfBoundsException ignored) {

                    }

                    board[i][j] = block;
                }
            }
        }*/
        generateHardcodedMaze();
    }

    public Block[][] callFunction(String function) {
        if (function.equals(Function.MOVE.getName())) {
            Player player = (Player) board[playerRow][playerCol];
            int[] coordinates = player.getCoordinatesInFront();
            movePlayer(coordinates[0], coordinates[1], player);
        } else if (function.equals(Function.TURN_LEFT.getName())) {
            Player player = (Player) board[playerRow][playerCol];
            int direction = player.direction;
            player.direction = (direction + 1) % 4;
        } else if (function.equals(Function.TURN_RIGHT.getName())) {
            Player player = (Player) board[playerRow][playerCol];
            int direction = player.direction;
            player.direction = (direction - 1) % 4;
        } else if (function.equals(Function.GRAB.getName())) {
            Player player = (Player) board[playerRow][playerCol];
            int[] coordinates = player.getCoordinatesInFront();
            if (board[coordinates[0]][coordinates[1]] instanceof Item) {
                player.pickUpItem((Item) board[coordinates[0]][coordinates[1]]);
            } else {
                //Display message in console saying item not found
                throw new IllegalFunctionException("Item not found!"); //Maybe?
            }
        } else if (function.equals(Function.USE.getName())) {
            Player player = (Player) board[playerRow][playerCol];
            int[] coordinates = player.getCoordinatesInFront();
            if (board[coordinates[0]][coordinates[1]] instanceof Item) {
                player.pickUpItem((Item) board[coordinates[0]][coordinates[1]]);
            } else {
                //Display message in console saying item not found
                throw new IllegalFunctionException("Item not found!"); //Maybe?
            }
        } else if (function.equals(Function.LOOK.getName())) {
            throw new IllegalFunctionException(function + " should be called in " +
                    "callLookFunction!");
        } else {
            throw new IllegalFunctionException("Function is not recognized!");
        }
        return board;
    }

    public Block callLookFunction() {
        Player player = (Player) board[playerRow][playerCol];
        int[] coordinates = player.getCoordinatesInFront();
        return board[coordinates[0]][coordinates[1]];
    }

    private void movePlayer(int row, int column, Player player) {
        playerRow = row;
        playerCol = column;
        int oldRow = player.row;
        int oldColumn = player.col;
        board[oldRow][oldColumn] = board[row][column];
        player.row = row;
        player.col = column;
        board[row][column] = player;
        System.out.println("moved");
    }

    public void generateHardcodedMaze() {
        for (int i = 0; i < numRows; i++) {
            for (int j = 0; j < numCols; j++) {
                Block block = new Block(true, i, j);
                int random = ThreadLocalRandom.current().nextInt(0, 10);
                if (random == 0 && i != 0 && j != 0)
                    block.name = "WALL";
            }
        }
    }
}