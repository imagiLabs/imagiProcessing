class Card {
  PImage card;
  PImage cover;
  int locX, locY, id, index;
  boolean flipped, matched, runTimer;
  long timer;

  Card(int _locX, int _locY, PImage _card, int _id, int _index) {
    locX = _locX;
    locY = _locY;
    id = _id;
    index = _index;
    card = _card;
    cover = loadImage("cover.png");
    timer = millis();
    flipped = false;
    matched = false;
    runTimer = false;
  }

  void display() {
    if (flipped)
      image(card, locX, locY);
    else
      image(cover, locX, locY);
  }

  // check to see if is clicked
  // if so flip and return true
  boolean checkClicked() {
    boolean clicked = false;
    if (mouseX <= locX+card.width
      && mouseX >= locX
      && mouseY <= locY + card.height
      && mouseY >= locY) {
      flipped = true;
      clicked = true;
    }
    return clicked;
  }

  // set a timer to flip the card over if it is not a match
  // only do this once when to flip the card back over (in main sketch)
  void triggerTimer() {
    timer = millis()+200;
    runTimer = true;
  }

  // run this all the time to check the timer (in main sketch)
  void checkTimer() {
    if (millis()>timer && runTimer) {
      flipped = false;
      runTimer = false;
    }
  }
}
