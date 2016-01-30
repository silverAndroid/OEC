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
    generateMaze();
  }

  public Player getPlayer() {
    return (Player) board[playerRow][playerCol];
  }

  public String callFunction(String function) {
    if (function.equals(Function.MOVE.getName())) {
      Player player = getPlayer();
      int[] coordinates = player.getCoordinatesInFront();
      movePlayer(coordinates[0], coordinates[1], player);
    } else if (function.equals(Function.TURN_LEFT.getName())) {
      Player player = getPlayer();
      int direction = player.direction;
      player.direction = (direction + 1) % 4;
      println(player.direction);
    } else if (function.equals(Function.TURN_RIGHT.getName())) {
      Player player = getPlayer();
      int direction = player.direction;
      player.direction = direction - 1;
      player.direction = player.direction == -1 ? 3 : player.direction;
      println(player.direction);
    } else if (function.equals(Function.GRAB.getName())) {
      Player player = getPlayer();
      int[] coordinates = player.getCoordinatesInFront();
      if (board[coordinates[0]][coordinates[1]] instanceof Item) {
        player.pickUpItem((Item) board[coordinates[0]][coordinates[1]]);
        Block block = new Block(true, coordinates[0], coordinates[1]);
        board[coordinates[0]][coordinates[1]] = block;
      } else {
        //Display message in console saying item not found
        return "Empty";
      }
    } else if (function.equals(Function.USE.getName())) {
      Player player = getPlayer();
      int[] coordinates = player.getCoordinatesInFront();
      if (board[coordinates[0]][coordinates[1]] instanceof Item) {
        player.pickUpItem((Item) board[coordinates[0]][coordinates[1]]);
      } else {
        //Display message in console saying item not found
        return "Empty";
      }
    } else if (function.equals(Function.LOOK.getName())) {
      throw new IllegalFunctionException(function + " should be called in " +
        "callLookFunction!");
    } else {
      return "Function is not recognized!";
    }
    return "";
  }

  public Block callLookFunction() {
    Player player = getPlayer();
    int[] coordinates = player.getCoordinatesInFront();
    return board[coordinates[0]][coordinates[1]];
  }

  private void movePlayer(int row, int column, Player player) {
    if (board[row][column] instanceof Wall || row < 0 || column < 0) {
      throw new UncheckedException("Cannot move!");
    } else {
    playerRow = row;
    playerCol = column;
    int oldRow = player.row;
    int oldColumn = player.col;
    board[oldRow][oldColumn] = board[row][column];
    player.row = row;
    player.col = column;
    board[row][column] = player;
    }
  }

  public void generateMaze() {
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        Block block = new Block(true, i, j);
        if (i == playerRow && j == playerCol) {
          board[i][j] = new Player(i, j);
        } else
        { 
          int random = ThreadLocalRandom.current().nextInt(0, 10);
          if (i != 0 && j != 0)
            if (random == 0)
              block = new Wall(i, j);
            else if (random == 1)
              block = new Item(i, j);
          board[i][j] = block;
        }
      }
    }
  }
}