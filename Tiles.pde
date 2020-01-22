import java.util.Random;

class Tiles {
  Tile[] tiles;
  int fade;

  Tiles(int squaresBy, int squareSize) {
    int[] nums = getShuffledArr(squaresBy*squaresBy); 
    //{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, -1};

    tiles = new Tile[squaresBy * squaresBy];

    for (int j = 0; j < squaresBy; j++) {
      for (int k = 0; k < squaresBy; k++) {
        tiles[j*4 + k] = new Tile(k*squareSize, j*squareSize, nums[j*4 + k]);
      }
    }

    tiles[squaresBy*squaresBy - 1] = null;
    fade = 225;
  }

  Boolean completed() {
    for (int i = 0; i < tiles.length - 2; i++) {
      if (tiles[i] == null || tiles[i + 1] == null) {
        return false;
      } else if (tiles[i].num + 1 != tiles[i + 1].num) {
        return false;
      }
    }
    return true;
  }

  int[] getShuffledArr(int noSquares) {
    int[] temp = new int[noSquares - 1];
    for (int i = 0; i < temp.length; i++) {
      temp[i] = i + 1;
    }

    shuffleArray(temp);

    int[] nums = new int[noSquares];
    for (int i = 0; i < temp.length; i++) {
      nums[i] = temp[i];
    }
    nums[nums.length - 1] = -1;
    return nums;
  }

  //copy pasted from processing forum?
  void shuffleArray(int[] array) {
    // with code from WikiPedia; Fisher–Yates shuffle 
    //@ <a href="http://en.wikipedia.org/wiki/Fisher" target="_blank" rel="nofollow">http://en.wikipedia.org/wiki/Fisher</a>–Yates_shuffle

    Random rng = new Random();

    // i is the number of items remaining to be shuffled.
    for (int i = array.length; i > 1; i--) {

      // Pick a random element to swap with the i-th element.
      int j = rng.nextInt(i);  // 0 <= j <= i-1 (0-based array)

      // Swap array elements.
      int tmp = array[j];
      array[j] = array[i-1];
      array[i-1] = tmp;
    }
  }

  void moveTile(int x, int y) {
    if (x+1 <= 3 && tiles[y*4 + x + 1] == null) {
      slideTileRight(y*4 + x);
    } else if (x-1 >= 0 && tiles[y*4 + x - 1] == null) {
      slideTileLeft(y*4 + x);
    } else if (y+1 <= 3 && tiles[(y+1)*4 + x] == null) {
      slideTileDown(y*4 + x);
    } else if (y-1 >= 0 && tiles[(y-1)*4 + x] == null) {
      slideTileUp(y*4 + x);
    }
  }

  void slideTileRight(int tileIndex) {
    tiles[tileIndex].x += 150;
    tiles[tileIndex+1] = tiles[tileIndex];
    tiles[tileIndex] = null;
  }

  void slideTileLeft(int tileIndex) {
    tiles[tileIndex].x -= 150;
    tiles[tileIndex-1] = tiles[tileIndex];
    tiles[tileIndex] = null;
  }

  void slideTileUp(int tileIndex) {
    tiles[tileIndex].y -= 150;
    tiles[tileIndex-4] = tiles[tileIndex];
    tiles[tileIndex] = null;
  }

  void slideTileDown(int tileIndex) {
    tiles[tileIndex].y += 150;
    tiles[tileIndex+4] = tiles[tileIndex];
    tiles[tileIndex] = null;
  }

  void drawTiles() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != null) {
        fill(245, fade);
        stroke(0);
        strokeWeight(1);
        rect(tiles[i].x, tiles[i].y, 150, 150);
        stroke(200, fade);
        noFill();
        strokeWeight(7);
        rect(tiles[i].x + 5, tiles[i].y + 5, 140, 140);
        stroke(255, fade);
        strokeWeight(1);
        rect(tiles[i].x + 8, tiles[i].y + 8, 134, 134);
        stroke(150, fade);
        line(tiles[i].x, tiles[i].y, tiles[i].x + 8, tiles[i].y + 8);
        line(tiles[i].x, tiles[i].y + 150, tiles[i].x + 8, tiles[i].y + 142);
        line(tiles[i].x + 150, tiles[i].y, tiles[i].x + 142, tiles[i].y + 8);
        line(tiles[i].x + 150, tiles[i].y + 150, tiles[i].x + 142, tiles[i].y + 142);
        fill(75, fade);
        text(str(tiles[i].num), tiles[i].x + 75, tiles[i].y + 75);
      }
    }
  }

  void fadeAnimation() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != null) {
        fill(255, fade);
        rect(tiles[i].x, tiles[i].y, 150, 150);
      }
    }
    if (!isFaded()) {
      fade--;
    }
  }

  void drawGrid() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != null) {
        noFill();
        rect(tiles[i].x, tiles[i].y, 150, 150);
      }
    }
  }

  Boolean isFaded() {
    return fade <= 0;
  }

  class Tile {
    int x;
    int y;
    int num;

    Tile(int x, int y, int num) {
      this.x = x;
      this.y = y;
      this.num = num;
    }
  }
}
