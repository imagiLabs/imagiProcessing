String myText = "imagiQuiz time!";
PFont font;
PImage background_img, question;
float radius = 70;
float x, arclength, angle, move;
int[] blue = {103, 212, 239};
int[] pink = {242, 170, 224};
int grey = 57;

void setup(){
  size (360, 640);
  font = createFont("VT323-Regular", 35);
  textFont(font);
  textAlign(CENTER);
  smooth();
}

void draw(){
    
  arclength = 0;
  makeBackground();
  image(background_img, 0, 0, 360, 640);
  
  // Place the bigger circle
  translate(width/2, height/2);
  noStroke();
  push();
    fill(pink[0], pink[1], pink[2]);
    ellipse(0, 0, radius*2, radius*2);
  pop();
  
  
  for(int i=0; i<myText.length(); i++){
     // Place the next letter
    arclength += textWidth(myText.charAt(i))/2;
    angle = 5*PI/4 + arclength/radius + move;
    push();
      translate(radius*cos(angle), radius*sin(angle));
      fill(grey, grey, grey);
      rotate(angle+PI/2);
      text(myText.charAt(i), 0, 0);
    pop();
    // Place the next letter
    arclength += textWidth(myText.charAt(i))/2;
    // Move the string with every frame
     move += 0.0018;
  }
}

// Make a background of color-changing circles
void makeBackground(){
  background(blue[0], blue[1], blue[2]);
  // make image instances
  background_img = loadImage("background.jpg");
  question = loadImage("question.png");
}
