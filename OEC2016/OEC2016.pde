import controlP5.*;

int startTime;
ControlP5 cp5;

Textlabel infoLabel;
Textlabel outLabel;
Textarea inTextarea;
Textarea outTextarea;
Textarea itemTextarea;

PImage rD1;
PImage rD2;
PImage rD3;
PImage rD4;

StringBuilder sb;

void setup()
{
  frameRate(30);
  startTime = millis();
  
  size(1366, 695);
  
  cp5 = new ControlP5(this);
  
  rD1 = loadImage("Rdir1.png");
  rD2 = loadImage("Rdir2.png");
  rD3 = loadImage("Rdir3.png");
  rD4 = loadImage("Rdir4.png");
  
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
  clear();
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
  if (key != BACKSPACE)
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

//Method to draw the lines of the board
void drawBoard()
{
  for (int i = 0; i <= 680; i += 40)
  {
    line(310, i, 1110, i);
  }
  
  for(int i = 310; i <= 1110; i+=40)
  {
    line(i, 0, i, 680);
  }
}

//Method that is invoked when the "Run" button is pressed
public void Run()
{
  if (millis()-startTime < 1000){return;}
  String input = cp5.get(Textarea.class,"in").getText();
  
  String lines[] = input.split("\\r?\\n");
}