void gameOver() {
  fill(90, 173, 255); 
  textSize(40);
  text("PLAYER", width / 2, (height / 2) + -50);
  fill(113, 17, 0);
  text("GAME OVER", width / 2, (height / 2) + 50);
  noLoop();
}

void restartButton() {
  fill(50, 50, 50);
  rect(width / 2 - 100, height / 2 + 150, 200, 50);
  fill(255);
  textSize(25);
  text("RESTART", width / 2, height / 2 + 175);
}

void mousePressed() {
  if (gameOver == true && mouseX > width / 2 - 100 && mouseX < width / 2 + 100 &&
      mouseY > height / 2 + 150 && mouseY < height / 2 + 200) {
    resetGame();
    gameOver = false;
  }
}
//RESTART버튼 누를시 맵을 새로 생성하고 모든 객체 초기화, 점수는 0으로 초기화
void resetGame() {
  CreateMap();
  score = 0;
  pacman = new Pacman(9, 13);
  ghost = new Ghost(cols - 3, rows - 5);
  coin = new Coin();
  status_cherry = 0;
  status_pear = 0;
  status_ryb = 0;
  keystatus = 0;
  cherry = new Item(1);
  pear = new Item(2);
  ryb = new Item(3);
  loop(); 
}

int keystatus = 0;
void keyPressed() {
  if (keyCode == UP) {
    photo = loadImage("image/pacman_top.png");
    keystatus = 1;
  } else if (keyCode == DOWN) {
    photo = loadImage("image/pacman_down.png");    
    keystatus = 2;
  } else if (keyCode == LEFT) {
    photo = loadImage("image/pacman_left.png");
    keystatus = 3;
  } else if (keyCode == RIGHT) {
    photo = loadImage("image/pacman_right.png");
    keystatus = 4;
  } else if (key == 'R' || key == 'r') {
    resetGame(); //R키 누르면 리셋
  }
}
