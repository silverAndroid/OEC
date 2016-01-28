import controlP5.*;

int startTime;
ControlP5 cp5;
Textlabel infoLabel;
Textlabel outLabel;

void setup()
{
  startTime = millis();
  
  size(1200, 695);
  
  cp5 = new ControlP5(this);
  
  //create a new button with name 'button'
  cp5.addButton("Submit")
     .setValue(0)
     .setPosition(140,100)
     .setSize(50,19)
     .setColorBackground(#CECECE)
     .setColorLabel(0);
     ;
     
  cp5.addSlider("sliderValue")
     .setPosition(50,150)
     .setRange(0,255)
     .setCaptionLabel("");
     ;
  
  //Create a new Text Field
  cp5.addTextfield("input")
     .setPosition(10, 50)
     .setSize(180,30)
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     .setColorBackground(#CECECE)
     .setColorValueLabel(0)
     .setColorForeground(255)
     .setColorActive(255)
     ;
     
  //Title label for "Interface"
  infoLabel = cp5.addTextlabel("label")
                    .setText("Interface")
                    .setPosition(5,10)
                    .setColorValue(0)
                    .setFont(createFont("Corbel",30))
                    ;
                    
   //Title label for "Output"
   outLabel = cp5.addTextlabel("outLabel")
                    .setText("Output")
                    .setPosition(5,height/2)
                    .setColorValue(0)
                    .setFont(createFont("Corbel",30))
                    ;
}

void draw()
{
  clear();
  background(255, 255, 255);
  
  infoLabel.draw(this);
  
  fill(#790507);
  stroke(#CECECE);
  rect(5, 45, 190, 300);
  rect(5, height/2 + 35, 190, 300);
  
  stroke(0);
  line(200, 10, 200, 685); //Line Seperation between Interface and Graphics
  
  
}

public void controlEvent(ControlEvent theEvent)
{
}

public void Submit()
{
  if (millis()-startTime < 1000){return;}
  String input = cp5.get(Textfield.class,"input").getText();
}