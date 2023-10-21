class Pacman {
  int x, y;
  
  Pacman(int x, int y) {
    this.x = x;
    this.y = y;
    photo = loadImage("image/pacman_0.png");
  }
  
  void move(int xdir, int ydir) {
    int newx = x + xdir;
    int newy = y + ydir;
    
    // 벽에 부딪치지 않으면 이동
    if (isCellEmpty(newx, newy)) {
      x = newx;
      y = newy;
    }
  }
  
  void display() {
    image(photo, x * gridSize, y * gridSize, gridSize, gridSize);
  }
}

class Ghost {
  int x, y;
  int speed = 2; //고스트 이동속도(낮을수록 빠름)
  int lastMoveFrame;
  int currentDirection;
  
  Ghost(int x, int y) {
    this.x = x;
    this.y = y;
    lastMoveFrame = frameCount;
    currentDirection = int(random(4));
  }
  
  void move() {
    if (frameCount - lastMoveFrame > speed) {
      int newx = x;
      int newy = y;

      //객체 생성당시 선택된 방향으로 계속 직진함
      if (currentDirection == 0) {
        newx = x - 1;
      } else if (currentDirection == 1) {
        newx = x + 1;
      } else if (currentDirection == 2) {
        newy = y - 1;
      } else if (currentDirection == 3) {
        newy = y + 1;
      }
      
      //벽을 만나면 랜덤한 방향을 선택하여 그 방향으로 계속 이동
      if (!isCellEmpty(newx, newy) || newx < 0 || newx >= cols || newy < 0 || newy >= rows) {
        currentDirection = int(random(4));
        return;
      }
      x = newx;
      y = newy;
      lastMoveFrame = frameCount;
    }
  }
  void display() {
    gphoto = loadImage("image/ghost.png");
    image(gphoto, x * gridSize, y * gridSize, gridSize, gridSize);
  }
}
