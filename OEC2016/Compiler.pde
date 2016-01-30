import java.lang.String;
import java.lang.Integer;
import java.lang.Exception;

public class Compiler{
  String[] code;
  String[][] subroutines;
  int numSubroutines = 0;
  String[][] vars;
  int numVars = 0;
  
  Board board;
  DrawB ux;
  PApplet wind;

  private String[] keyWords = {"is it?", "is", "stop", "steps to", "move", "turn left", "turn right", "grab", "use", "look"};
  private int listSize = 75;

  public Compiler(Board board, DrawB ux, PApplet wind){
    this.board = board;
    this.ux = ux;
    this.wind = wind;
    subroutines = new String[listSize][listSize];
    vars = new String[listSize][2];
  }

  public void sendProgram(String[] code){
    this.code = code;
    System.out.println(code.length);
    //first pass on code
    for(int i = 0; i < code.length; i++){
      String line = code[i];
      int instruction = getCommand(line);
      if(instruction == 1){
       createVar(line); 
      } else if(instruction == 3){
        i = createSubroutine(line, i);
      }
    }
    System.out.println("Run");
    runProgram();
  }
  
  public void runProgram(){
    if(code == null){return;}
    
    for(int i = 0; i < code.length; i++){
      
     String cmd = code[i];
     System.out.println(cmd);
     if(getCommand(cmd) == 3){
       cmd = cmd.substring(cmd.split(" ")[0].length() + 1);
       try{
         String routineID = subroutines[indexOfKey(subroutines, cmd, numSubroutines)][0];
         String[] routineComp = routineID.split(" ");
         int numSkip = Integer.parseInt(routineComp[routineComp.length - 1]);
         i += numSkip;
       }catch(Exception e){ }      
     } else {
       if(getCommand(cmd) == -1){
        executeSub(indexOfSub(cmd));
       } else if(getCommand(cmd) == 0){
         i = executeCond(cmd, i);
       } else {
         execute(cmd);
       }
     }
    }
  }
  
  public void clearProgram(){
   this.code = null; 
    subroutines = new String[listSize][listSize];
    vars = new String[listSize][2];
  }
  
  public void execute(String cmd){
    int cmdID = getCommand(cmd);
    if(cmdID == 1){
      setVar(cmd);
    } else if(cmdID == 4){
     board.callFunction("move");
     System.out.println("A");
     draw();
    } else if(cmdID == 5){
     board.callFunction("turn left");
     draw();
    } else if(cmdID == 6){
     board.callFunction("turn right");
     draw();
    } else if(cmdID == 7){
     board.callFunction("grab");
     draw();
    } else if(cmdID == 8){
     board.callFunction("use");
     draw();
    } else if(cmdID == 9){
     board.callLookFunction();
     draw();
    } else if(getCommand(cmd) == -1){
        executeSub(indexOfSub(cmd));
    }
  }
  
  public void executeSub(int routineIndex){
    System.out.println("Sub");
    String routineID = subroutines[routineIndex][0];
    String[] routineComp = routineID.split(" ");
    int subLength = Integer.parseInt(routineComp[routineComp.length - 1]);
    for(int i = 1; i <= subLength; i++){
     String cmd = subroutines[routineIndex][i];
     execute(cmd);
    }
  }
  
  public int executeCond(String cmd, int pos){
    System.out.println("Condition");
    pos++;
    boolean valid;
    String[] cmdComp = cmd.split(keyWords[0]);
    
    String cmpVal = cmdComp[1];
    
    if(cmpVal.compareTo("look") == 0){
      Block b = board.callLookFunction(); 
      if(b instanceof Wall){
        cmpVal = "wall";
      } else if(b instanceof Item){
       cmpVal = "item"; 
      } else {
       cmpVal = "empty";
      }
    }
    
    valid = (vars[indexOfKey(vars, cmdComp[0], numVars)][1].compareTo(cmpVal) == 0);
    System.out.println(valid);
    if(!valid){
      return pos;
    }
    String line = code[pos];
    while((line.compareTo("stop") != 0)&&(pos < code.length)){
      execute(line);
      pos++;
    }
    return pos;
  }
  
  public void setVar(String cmd){
    cmd.replace("is", "~");
    String[] cmdComp = cmd.split("~");
    
    String newVal;
    String oldVal = vars[indexOfKey(vars, cmdComp[0], numVars)][1];
    
    if(cmdComp[1].startsWith("+")){
      int tmp = Integer.parseInt(cmdComp[1].replace("+", ""));
      newVal = Integer.toString(Integer.parseInt(oldVal) + tmp);
    }
    
    vars[indexOfKey(vars, cmdComp[0], numVars)][1] = cmdComp[1];
  }
  
  private int getCommand(String line){
    int indexOfWord = -1;
    for(int i = 0; i < keyWords.length; i++){
      if( line.indexOf(keyWords[i]) != -1 ){
        indexOfWord = i;
        return indexOfWord;
      }
    }
    return indexOfWord;
  }

  private void createVar(String line){
    String varName;
    varName = line.split(" is ")[0];
    if(!searchKey(vars, varName, numVars)){
      vars[numVars][0] = varName;
      numVars++;
    }
  }

  private int createSubroutine(String line, int pos){
    String routineName;
    routineName = line.substring(9);
    System.out.println("Routine mande -- " + routineName);

    //add the subroutine
    if(!searchKey(subroutines, routineName, numSubroutines)){
      int lineNo = 0;

      subroutines[numSubroutines][lineNo] = routineName;
      lineNo++;
      pos++;
      
      while((pos < code.length)&&(startsWithInt(code[pos]))){
        String cmd = code[pos].substring(code[pos].split(" ")[0].length() + 1); //slice numbers off
        subroutines[numSubroutines][lineNo] = cmd;
        lineNo++;
        
        if(getCommand(cmd) == 2){
          createVar(cmd);
        } 
        else if(getCommand(cmd) == 0){
          //process if statement
          int tmpIndex = pos + 1;
          while((tmpIndex < code.length)&&(!startsWithInt(code[tmpIndex]))){
            subroutines[numSubroutines][lineNo] = code[tmpIndex];
            lineNo++;
            tmpIndex++;
          }
          pos = tmpIndex-1;
        }
        pos++;
      }
      subroutines[numSubroutines][0] = subroutines[numSubroutines][0] + " " + (lineNo-1);
      numSubroutines++;
    }
    return pos-1;
  }

  private boolean startsWithInt(String line){
    try{
      Integer.parseInt(line.split(" ")[0].replace(".", ""));
      return true;
    } catch(Exception e){
      return false;
    }
  }

  private boolean searchKey(String[][] src, String key, int size){
    for(int i = 0; i < size; i++){
      if(src[i][0].compareTo(key) == 0){
        return true;
      }
    }
    return false;
  }
  
  public int indexOfKey(String[][] src, String key, int size){
    for(int i = 0; i < size; i++){
      if(src[i][0].compareTo(key) == 0){
        return i;
      }
    }
    return -1;
  }
  
  public int indexOfSub(String subroutine){
    for(int i = 0; i < numSubroutines; i++){
      if(subroutines[i][0].startsWith(subroutine)){
        return i;
      }
    }
    return -1;
  }
  
  private void draw(){
    System.out.println("D");
  clear();
  background(255, 255, 255);
    
  //Drawing lines for the board
  for (int i = 0; i <= 680; i += 40)
  {
    line(310, i, 1110, i);
  }
  
  for(int i = 310; i <= 1110; i+=40)
  {
    line(i, 0, i, 680);
  }
  
  //Drawing components on the board
  for(int i = 0; i < b.numRows; i++)
  {
    for(int j = 0; j < b.numCols; j++)
    {
      if (b.board[i][j] instanceof Player){image(b.getPlayer().getCurrentImage(), b.board[i][j].getX() + 310, b.board[i][j].getY());}
      if (b.board[i][j] instanceof Wall){image(wall, b.board[i][j].getX() + 310, b.board[i][j].getY());}
      if (b.board[i][j] instanceof Item){image(bana, b.board[i][j].getX() + 310, b.board[i][j].getY());}
    }
  }
  }
}