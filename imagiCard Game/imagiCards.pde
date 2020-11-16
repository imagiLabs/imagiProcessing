Card[] cards;
int amountFlipped = 0;
int[] ids = {-1, -1};
int[] whichCard = {-1, -1};
int score = 0;

import processing.sound.*;
SoundFile click;

int scene;
int numCards = 20;

PImage[] images = new PImage[numCards];
PImage cardCover;

PFont font;
String instructions_1, instructions_2, instructions_3, instructions_4, btn_start, btn_quit;
int fontSize = 50;

int margin = 3;
IntList imageIndex = new IntList();
int[] flippedCard;

int[] pink = {242, 170, 224};
int[] green = {51, 225, 142};
int[] orange = {248, 163, 15};
int[] blue = {103, 212, 239};
int[] yellow = {255, 244, 108};

float rectX, rectY, rectWidth, rectHeight;

void setup() {
  size(1100, 800);
  rectMode(CENTER);
  click = new SoundFile(this, "clickSound.wav"); 
  
  scene = 0;
    
  rectX = width/2;
  rectY = height/2;
  rectWidth = 170;
  rectHeight = 80;
  
  // setting the text
  push();
    fontSize = 40;
    instructions_1 = "Welcome!";
    instructions_2 = "You are presented a deck of cards.";
    instructions_3 = "Your task is to flip and match every one of them.";
  pop();
  
  btn_start = "START";
  btn_quit = "QUIT";
  font = createFont("VT323-Regular", fontSize);
  textFont(font);
    
  cards = new Card[numCards];;

  loadCards();
}

void draw(){
  background(green[0], green[1], green[2]);
  // display scenes
  if (scene == 0){
    displayMenu();
  }
  if (scene == 1){
    playScene();
    //displayScore();
  }
  if (scene == 2){
    playWin();
  }
}

// display the UI scene
  void displayMenu(){
    
    // create a button
    push();
      noStroke();
      if(isHover())
        fill(yellow[0]-20,yellow[1]-20,yellow[2]-20);
      else
        fill(yellow[0],yellow[1],yellow[2]);
      rect(rectX, rectY, rectWidth, rectHeight);
    pop();
    
    // place instructions
    textAlign(CENTER);
    fill(0);
    text(instructions_1, width/2, height/6);
    text(instructions_2, width/2, height/6+80);
    text(instructions_3, width/2, height/6+120);
    text(btn_start, width/2, height/2+12.5);
  }
  
    boolean isHover(){
    if(mouseX <= rectX+rectWidth/2 
      && mouseX >= rectX - rectWidth/2
      && mouseY <= rectY + rectHeight/2
      && mouseY >= rectY - rectHeight/2 && mousePressed){
      scene = 1;
      return true;
    }
     else
       return false;
  }
  
    // load cards
  void loadCards(){
    
    // store all the cards in the image array
    for (int i = 0; i < numCards; i ++) {
      images[i] = loadImage(i+".png");
      imageIndex.append(i);
    }
   
    // shuffle images
    imageIndex.shuffle();
    
    // initialize counters
    int index;
    int id;
    
    // initialize a deck matrix
    for (int i = 0; i < 5; i++) { //i = x
      for (int j = 0; j < 4; j++) {//j = y
        index = i + j * 5; // width is 5
        id = index%10;
        cards[index] = new Card(i*(margin+images[i].width), j*(margin+images[i].height), images[index], id, index); // 
      }
    }
  }
  
    // display scene 1
  void playScene(){
    background(blue[0], blue[1], blue[2]);
    // show the cards
    for (int i = 0; i<numCards; i++){
      cards[imageIndex.get(i)].display();
      //cards[i].display();
      cards[i].checkTimer();
    }
    checkIDs();
    push();
      textSize(60);
      text("Score: " + score, width-200, height/2);
    pop();
  }
  
  void mousePressed() {
  
  click.play();
  for (int i=0; i<cards.length; i++) {
    // only flip cards over if there are less than 2 flipped
    if (amountFlipped<2) {
      // only flip if the card hasn't been flipped
      // and also hasn't been matched (just to be safe)
      if (!cards[i].flipped && !cards[i].matched) {
        // check which card got clicked
        if (cards[i].checkClicked()) {
          // we've flipped it now so increase the amount that have been flipped
          amountFlipped++;
        }
      }
    }
  }
}

// check the IDs of the flipped cards
void checkIDs() {
  // make sure we have two flipped 
  // (already checked in mousePressed to make sure we're not counting matched cards)
  if (amountFlipped == 2) {
    // we need to keep track to make sure we check two cards
    // this index does that (we already made sure it's only two just above)
    int thisIndex = 0;
    for (int i=0; i<cards.length; i++) {
      // if the card is flipped, AND is NOT matched
      if (cards[i].flipped && !cards[i].matched) {
        // get that card's ID and its index
        ids[thisIndex] = cards[i].id;
        whichCard[thisIndex] = cards[i].index;
        // increment our local index
        thisIndex++;
      }
    }
    // if we have something for both cards (otherwise one would be -1)
    if (whichCard[0]>=0 && whichCard[1]>=0) {
      // if they match set to matched and increase score
      if (ids[0] == ids[1]) {
        cards[whichCard[0]].matched = true;
        cards[whichCard[1]].matched = true;
        score++;
        if (score == numCards/2){
           scene = 2;
        }
      } else { // otherwise trigger the timer and reset things back to -1
        cards[whichCard[0]].triggerTimer();
        cards[whichCard[1]].triggerTimer();
        ids = new int[]{-1, -1};
        whichCard = new int[]{-1, -1};
      }
      // always reset the amountflipped back to 0 so we can start again
      amountFlipped = 0;
    }
  }
}

  // display the win scene
  void playWin(){
     background(pink[0], pink[1], pink[2]);
     text("You have matched them all!", width/2, height/2-200);
     push();
      noStroke();
      if(isHover())
        fill(yellow[0]-20,yellow[1]-20,yellow[2]-20);
      else
        fill(yellow[0],yellow[1],yellow[2]);
      rect(rectX, rectY, 2*rectWidth, rectHeight);
    pop();
    text("Play Again?", rectX, rectY+10);
    
    // reset the score and cards
    score = 0;
    for (int i = 0; i < numCards; i++){
      cards[i].matched = false;
      cards[i].flipped = false;
    }
  }
  
