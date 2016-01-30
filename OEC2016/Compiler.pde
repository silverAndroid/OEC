import java.lang.String;
import java.lang.Integer;
import java.lang.Exception;

public class Compiler{
  static String[] code;
  static String[][] subroutines;
  static int numSubroutines = 0;
  static String[][] vars;
  static int numVars = 0;

  private static String[] keyWords = {"is it?", "is", "stop", "steps to", "move", "turn left", "turn right", "grab", "use", "look"};
  private static int listSize = 75;

  public Compiler(){
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
      System.out.println(instruction + "  -  " + line);
      if(instruction == 1){
       createVar(line); 
      } else if(instruction == 3){
        i = createSubroutine(line, i);
      }
    }
  }
  
  public void runProgram(){
    if(code == null){return;}
    
    for(int i = 0; i < code.length; i++){
      
     String cmd = code[i];
     
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
        //sub 
       } else if(getCommand(cmd) == 0){
         
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
  
  public static void execute(String cmd){
    int cmdID = getCommand(cmd);
    if(cmdID == 1){
      //decleration
    } else if(cmdID == 4){
     //playe.move 
    } else if(cmdID == 5){
     //playe.left 
    } else if(cmdID == 6){
     //playe.right 
    } else if(cmdID == 7){
      //grab
    } else if(cmdID == 8){
      //use
    } else if(cmdID == 9){
     //look 
    }
  }
  
  public static void executeSub(int routineIndex){
    String routineID = subroutines[routineIndex)][0];
    String[] routineComp = routineID.split(" ");
    int  = Integer.parseInt(routineComp[routineComp.length - 1]);
    int subLength = 
  }
  
  public static int executeCond(String cmd, int pos){
    
    return pos;
  }
  
  private static int getCommand(String line){
    int indexOfWord = -1;
    for(int i = 0; i < keyWords.length; i++){
      if( line.indexOf(keyWords[i]) != -1 ){
        indexOfWord = i;
        return indexOfWord;
      }
    }
    return indexOfWord;
  }

  private static void createVar(String line){
    String varName;
    varName = line.split(" is ")[0];
    if(!searchKey(vars, varName, numVars)){
      vars[numVars][0] = varName;
      numVars++;
    }
  }

  private static int createSubroutine(String line, int pos){
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

  private static boolean startsWithInt(String line){
    try{
      Integer.parseInt(line.split(" ")[0].replace(".", ""));
      return true;
    } catch(Exception e){
      return false;
    }
  }

  private static boolean searchKey(String[][] src, String key, int size){
    for(int i = 0; i < size; i++){
      if(src[i][0].compareTo(key) == 0){
        return true;
      }
    }
    return false;
  }
  
  public static int indexOfKey(String[][] src, String key, int size){
    for(int i = 0; i < size; i++){
      if(src[i][0].compareTo(key) == 0){
        return i;
      }
    }
    return -1;
  }
  
  public static int indexOfSub(String subroutine){
    for(int i = 0; i < numSubroutines; i++){
      if(subroutines[i][0].startsWith(subroutine)){
        return i;
      }
    }
    return -1;
  }
  
  public static void main(String[] args){
    Compiler comp = new Compiler();
    String[] program = {"block is look", "steps to walks", "1. block is look", "2. block is it? path", "move", "stop", "3. walks", "block is it? empty", "turn left","steps to run", "1. fancy is me", "2. fuck you"};
    comp.sendProgram(program);
System.out.println("vars");
    for(int i = 0; i < numVars; i++){
      for(int j = 0; j < vars[i].length; j++){
        if(vars[i][j] != null){
          System.out.println(vars[i][j]);
        }
      }
    }
System.out.println("Subs");
        for(int i = 0; i < numSubroutines; i++){
          for(int j = 0; j < subroutines[i].length; j++){
 
              System.out.println(subroutines[i][j]);
            
          }
        }
        System.out.println("END");
  }
}