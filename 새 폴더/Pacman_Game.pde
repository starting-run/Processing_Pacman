PImage photo;
PImage gphoto;
PFont font;
PImage items;
boolean gameOver = false; //false일 경우 게임 진행 true일 경우 게임 종료

int gridSize = 40; //격자 크기
int cols, rows;
int[][] map; //0은 벽, 1은 길
int score = 0;
int highscore = 0;

Pacman pacman;
Ghost ghost;
Coin coin;
Item cherry;
Item pear;
Item ryb;

void CreateMap() {
  cols = width / gridSize;
  rows = height / gridSize;
  map = new int[cols][rows];

  //벽 생성 확률 15% && 위 아래 3격자크기만큼 비움.(UI삽입을 위함)
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (i == 0 || i == cols - 1 || j == 3 || j == rows - 3) {
        map[i][j] = 0; //벽
      if (j < 3 || j > rows - 3) {
        map[i][j] = 1; //길
      }
      } else { 
        if (random(1) < 0.15 && j > 3 && j < rows - 3) {
          map[i][j] = 0; //벽
        } else {
          map[i][j] = 1; //길
        }
      }
    }
  }
}

void setup() {
  size(800, 1000);
  CreateMap(); //맵 결정하는 함수(맵을 그리는건 draw에 정의)
  pacman = new Pacman(9, 13);
  ghost = new Ghost(cols - 3, rows - 5);
  coin = new Coin();
  cherry = new Item(1);
  pear = new Item(2);
  ryb = new Item(3);
}

//item을 먹은 상태인지 체크 (0 = 안먹음, 1 = 먹음)
//item을 먹었을 경우 오른쪽 아래에 해당 아이템이 박제되기 때문
//item은 매 판 1번만 생성됨
int status_cherry = 0;
int status_pear = 0;
int status_ryb = 0;

void draw() {
  if (!gameOver) {  
    background(0);
    
    //Coin을 먹었을 때
    if (pacman.x == coin.x && pacman.y == coin.y) {
      score+=100; 
      coin = new Coin();
    }
    
    //팩맨이 움직이는 방향
    if (keystatus == 1) {
      pacman.move(0, -1);
    } else if (keystatus == 2) {
      pacman.move(0, 1);
    } else if (keystatus == 3) {
      pacman.move(-1, 0);
    } else if (keystatus == 4) {
      pacman.move(1, 0);
    }
    
    //Ghost와 부딪혔을 때
    if (pacman.x == ghost.x && pacman.y == ghost.y) {
      if (highscore < score) {
        highscore = score; //현재 score를 highscore로 기록
      }
      gameOver = true; //고스트와 부딪히면 gameover
    }
    
    //체리를 먹었을 때
    if (pacman.x == cherry.x && pacman.y == cherry.y) {
      score+=100; // 점수 증가
      cherry = new Item(1);
      //Item인자 = 오른쪽 아래에서 아이템 배열을 위한 index값
      status_cherry = 1;
    }

    //배를 먹었을 때
    if (pacman.x == pear.x && pacman.y == pear.y) {
      score+=500; // 점수 증가
      pear = new Item(2);
      status_pear = 1;
    }
    
    //RYB를 먹었을 때
    if (pacman.x == ryb.x && pacman.y == ryb.y) {
      score+=2000; // 점수 증가
      ryb = new Item(3);
      status_ryb = 1;
    }
    
    //CreateMap()으로 생성된 2차원 배열을 그림
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (map[i][j] == 0) {
          fill(33, 33, 221); // 벽
        } else {
          fill(0); // 길
          noStroke();
        }
        rect(i * gridSize, j * gridSize, gridSize, gridSize);
      }
    }
    pacman.display();
    ghost.display();
    ghost.move();
    coin.display();
    cherry.display(loadImage("image/cherry.png"), status_cherry, 0);
    pear.display(loadImage("image/pear.png"), status_pear, 1);
    ryb.display(loadImage("image/ryb.png"), status_ryb, 2);
    
    font = createFont("font/pacman.ttf", 20);
    fill(248, 178, 238);
    textSize(50);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("GAME SCORE ", 150, 40);
    fill(255);
    text(score, 140, 70);
    text("HIGH SCORE ", 650, 40);
    fill(255);
    text(highscore, 640, 70);
  }
  else {
    gameOver();
    restartButton();
  }
}
  
//매개변수 좌표가 맵 안에 있고 벽이 아니라면 true 반환
boolean isCellEmpty(int x, int y) {
  return (x >= 0 && x < cols && y >= 0 && y < rows && map[x][y] == 1);
}
