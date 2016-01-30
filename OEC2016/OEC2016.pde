import controlP5.*;

int startTime;

ControlP5 cp5;
Board b;

Textlabel infoLabel;
Textlabel outLabel;
Textarea inTextarea;
Textarea outTextarea;
Textarea itemTextarea;

Compiler c;

PImage wall;
PImage bana;

StringBuilder sb;

void setup()
{
  frameRate(60);
  startTime = millis();
  
  size(1366, 695);
  
  
  cp5 = new ControlP5(this);
  b = new Board(17, 20, 1, 0);
  
  c = new Compiler(b, new DrawB(), this);
  
  wall = loadImage("wall.png");
  bana = loadImage("banana.png");
  
  //create a new button with name 'button'
  cp5.addButton("Run")
     .setValue(0)
     .setPosition(190,590)
     .setSize(100,20)
     .setColorBackground(#CECECE)
     .setColorLabel(0);
     ;
  
  inTextarea = cp5.addTextarea("in")
                  .setPosition(10,55)
                  .setSize(280,530)
                  .setFont(createFont("arial",16))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(255)
                  .setColorActive(255) 
                  .setColorForeground(255);
                  ;
                  
   outTextarea = cp5.addTextarea("out")
                  .setPosition(10,height - 45)
                  .setSize(280, 30)
                  .setFont(createFont("arial",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(255)
                  .setColorActive(0) 
                  .setColorForeground(0);
                  ;
                  
   itemTextarea = cp5.addTextarea("item")
                  .setPosition(1125, 55)
                  .setSize(225, 620)
                  .setFont(createFont("arial",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(255)
                  .setColorActive(0) 
                  .setColorForeground(0);
                  ;
     
  //Title label for "Writing Code"
  infoLabel = cp5.addTextlabel("inlabel")
                    .setText("Write Code")
                    .setPosition(5,10)
                    .setColorValue(0)
                    .setFont(createFont("Corbel",30))
                    ;
                    
   //Title label for "Message from Robot"
   outLabel = cp5.addTextlabel("outLabel")
                    .setText("Message from Robot")
                    .setPosition(5,height - 80)
                    .setColorValue(0)
                    .setFont(createFont("Corbel",30))
                    ;
                    
  //Title label for "Things Robot Has"
  infoLabel = cp5.addTextlabel("itemLabel")
                    .setText("Items on Robot")
                    .setPosition(1120,10)
                    .setColorValue(0)
                    .setFont(createFont("Corbel",30))
                    ;
   
   //Used to append to TextArea input when typing.
   sb = new StringBuilder();
}

void draw()
{
  background(255, 255, 255);
  drawBoard();

  infoLabel.draw(this);
  
  fill(#790507);
  stroke(#CECECE);
  rect(5, 45, 290, 570);
  rect(1120, 45, 235, 635);
  rect(5, height - 50 , 290, 40);
  
  stroke(0);
  line(300, 10, 300, 685); //Line Seperation between Interface and Graphics
}

public void controlEvent(ControlEvent theEvent)
{
}

//Method that handles the text input for user code
void keyPressed()
{
  if ( key >= 97 && key <= 122 || key == ENTER || key >= 48 && key <= 57 || key == 46 || key == 61 || key == 43 || key == 45  || key == 32)
  {
    sb.append( key );
    inTextarea.setText( sb.toString() );
  }
  else if(key == BACKSPACE && sb.length() != 0)
  {
    sb.deleteCharAt(sb.length() - 1);
    inTextarea.setText(sb.toString());
  }
}

//Method to draw the board
void drawBoard()
{
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

//Method that is invoked when the "Run" button is pressed
public void Run()
{
  if (millis()-startTime < 1000){return;}
  String input = cp5.get(Textarea.class,"in").getText();
  
  String lines[] = input.split("\\r?\\n");
  System.out.println(lines[0]);
  c.sendProgram(lines);
}

class DrawB
{
  public DrawB()
  {
  }
  
  public void drawBoard()
  {
    System.out.println("D");
    drawBoard();
  }
}