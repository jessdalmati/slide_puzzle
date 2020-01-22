PImage background;
Tiles tiles;
Boolean completed;

void setup() {
  size(600, 600);
  background = loadImage("spirited_away.jpeg");
  tiles = new Tiles(4, 150);
  completed = false;
  textAlign(CENTER);
  textSize(25);
  //textFont(createFont("Courier New", 30));
}

void draw() {
  background(background);
  if(!completed) {
    tiles.drawTiles();
  } else if(!tiles.isFaded()) {
    tiles.fadeAnimation();
  } else {
    tiles.drawGrid();
  }
} 


void mousePressed() {
  int x = mouseX / 150;
  int y = mouseY / 150;
  
  tiles.moveTile(x, y);
  completed = tiles.completed();
  
  if(completed && tiles.isFaded()) {
    completed = false;
    tiles = new Tiles(4, 150);
  }
}

void keyPressed() {
  if(key == 'r') {
    completed = false;
    tiles = new Tiles(4, 150);
  }
}
