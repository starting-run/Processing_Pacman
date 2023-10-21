class Coin {
  int x, y;
  
  Coin() {
    while (true) {
    int newx = x;
    int newy = y;
    newx = int(random(1, cols - 1));
    newy = int(random(4, rows - 3));
    if (isCellEmpty(newx, newy)) {
        x = newx;
        y = newy;
        break;
      }
    }
  }
  void display() {
    fill(255, 188, 172);
    ellipse(x * gridSize + gridSize/2, y * gridSize + gridSize/2, gridSize / 1.5, gridSize / 1.5);
  }
}

class Item {
  int x, y;
  int upsize;
  int volume;
  
  Item(int vol) {
    this.volume = vol;
    while (true) {
    int newx = x;
    int newy = y;
    newx = int(random(1, cols - 1));
    newy = int(random(4, rows - 4));
    if (isCellEmpty(newx, newy)) {
        x = newx;
        y = newy;
        break;
      }
    }
  }
  
  void display(PImage items, int status, int volume) {
    if (status == 0) {
      image(items, x * gridSize, y * gridSize, gridSize, gridSize);
    } else if (status == 1) { //status = 1이면 먹은 상태이므로 크기를 2배해서 오른쪽 아래에 박제
      image(items, 18 * gridSize + (volume * -85), 23 * gridSize, gridSize * 2, gridSize * 2);      
    }
  }
}
