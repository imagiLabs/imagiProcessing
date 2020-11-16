PFont myFont;
float x = 10;
float y = 40;
float vx = 100;
float vy = 0;
PImage imagiQuiz;
float dt = 1.0/30.0;
float gravity = 100;
float restitution = .9;

void setup() {
  size(375, 667);
  //background(242, 170, 224);
  imagiQuiz = loadImage("imagiQuiz.jpg");
  frameRate(30);
  smooth();
  myFont = createFont("VT323-Regular", 32);
  textFont(myFont);
}

void draw() {
  image(imagiQuiz,0,0, 375, 667);
  fill(255, 170, 224, 20);
  rect(0,0,width,height);
  fill(255);
  text("imagiQuiz time!", x, y);
  vy += gravity*dt;
  x += vx*dt;
  y += vy*dt;
  if (x < 0){
    x = 0;
    vx *= -restitution;
  } else if (x > width-190){
    //The 100 here is roughly the width
    //of the text
    x = width-190;
    vx *= -restitution;
  }
  if (y > height){
    y = height;
    vy *= -restitution;
  }
}
 
