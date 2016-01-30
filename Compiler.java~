import java.util.String;

public class Compiler{

  String[] code;
  String[][] subRoutines;

  String[][] variables;

  Player avatar;

  private static String[] keyWords = {"is it?", "is", "stop", "steps to", "move", "turn left", "turn right", "grab", "use",};

  public Compiler(){

  }

  public int[] sendProgram(String[] code){
    this.code[] = code;

    //first pass on code
    for(int i = 0; i < code.length; i++){
      String line = code[i];
      int instruction = getCommand(line);

      switch (instruction){
        case 1:
          createVar(line);
        case 3:
          i = createSubroutine(line, i);
      }

    }
  }

  private static int getCommand(String line){
    int indexOfWord = -1;
    for(int i = 0; i < keyWords.length; i++){
      if( line.indexOf(keyWords[i] != -1) ){
        indexOfWord = i;
        return indexOfWord;
      }
    }
    return indexOfWord;
  }

  private static void createVar(String line){


  }

  private static int createSubroutine(String line, int pos){

  }
}
