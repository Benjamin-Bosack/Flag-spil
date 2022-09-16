
ArrayList<PImage> myPI = new ArrayList<PImage>();
ArrayList<Integer> myAnswer = new ArrayList<Integer>();
IntList shuffleList = new IntList();
boolean shuffleNow = true;
int counter = 0;
int game, score, highscore, x, y, vertical, wallx[] = new int[2], wally[] =new int[2];;
String gameState;

PImage a;
PImage b;
PImage c;
PImage d;
PImage e;
PImage f;
PImage g;
PImage h;
PImage i;
PImage j;

PImage Start;

PImage backpic, birdpic, wallpic, welcomescreen, flapBack, wrong, correct;

void setup() {

  size(600,800);
  gameState="START";

game = 1; score = 0; highscore = 0;

  myAnswer.add(2);
  myAnswer.add(4);
  myAnswer.add(3);
  myAnswer.add(2);
  myAnswer.add(1);
  myAnswer.add(3);
  myAnswer.add(4);
  myAnswer.add(1);
  myAnswer.add(3);
  myAnswer.add(4);


  myPI.add(loadImage("a.png"));
  myPI.add(loadImage("b.png"));
  myPI.add(loadImage("c.png"));
  myPI.add(loadImage("d.png"));
  myPI.add(loadImage("e.png"));
  myPI.add(loadImage("f.png"));
  myPI.add(loadImage("g.png"));
  myPI.add(loadImage("h.png"));
  myPI.add(loadImage("i.png"));
  myPI.add(loadImage("j.png"));
  
  welcomescreen=loadImage("welcomescreen.jpg");
  flapBack=loadImage("welcomepic.png");
  
  for (int i = 0; i< myPI.size(); i++) myPI.get(i).resize(1000,800);// shuffleList.append(i);
  for (int i = 0; i< myPI.size(); i++) shuffleList.append(i);
  
   backpic =loadImage("https://raw.githubusercontent.com/Gaspared/FlappyBird/main/img/back.png");
   birdpic =loadImage("https://raw.githubusercontent.com/Gaspared/FlappyBird/main/img/bird.png");
   wallpic =loadImage("https://raw.githubusercontent.com/Gaspared/FlappyBird/main/img/wall.png");
   wrong = loadImage("wrong.png");
  correct = loadImage("correct.jpg");
   
  
}

void draw() {

  //a.resize
  
  if (gameState == "INNIT") {
    innitGame();
    } else if (gameState == "START") {
    startGame();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN") {
    winGame();
  } else if (gameState == "LOSE") {
    loseGame();
  }
    else if (gameState == "BIRD"){
    flappyBird();
    }
    else if (gameState == "TEN"){
      ten();
}

}

void innitGame(){
  imageMode(CORNER);
  game = 1; score = 0; highscore = 0; x = -200; vertical = 0; 
  fill(0,0,0);
  textSize(20); 
  gameState="START";
}





//hej
void startGame() {
  image(welcomescreen, 0,0);
  textAlign(CENTER);
  textSize(50);
  fill(0,0,0);
  text("Flag bird", width/2, height/5);
  textSize(18);
  fill(0, 0, 0);
  text("Your goal is to select the correct country", width/2, height/3);
  text("Match the flag to the names", width/2, height/2.5);
  text("Use keys, 1,2,3 and 4 to select your answers", width/2, height/2);
  text("Click anywhere to start", width/2, height/1.5);
  if (mousePressed == true)
   gameState="PLAY";
  
}

void playGame() {
  background(100,100,100);
  if (shuffleNow == true) {
    shuffleList.shuffle();
    shuffleNow = false;
    
    }
    imageMode(CORNER);
  image(myPI.get(shuffleList.get(counter)), 0, 0);
  println(myAnswer.get(shuffleList.get(counter)));
  {
    if (keyPressed) {

      if((Character.getNumericValue(key)) > 0 && (Character.getNumericValue(key)) < 5){
            
        if(myAnswer.get(shuffleList.get(counter)) == (Character.getNumericValue(key))) {
          highscore = max(++score, highscore);
        gameState="WIN"; 
        }
        else gameState="LOSE";
        counter++;
    
      }

    }
  }
}
void winGame() {
  image(correct, 0,0);
  textAlign(CENTER);
  textSize(40);
  fill(0,0,0);
  text("CORRECT!", width/2, height/5);
  text("Click for another question!", width/2, height/1.3);
   textSize(25);
    text("Current Score:"+score,200,100);
  
  if (mousePressed == true){
   gameState="PLAY";
   if(score == 10) gameState = "TEN";
  }
}

void ten(){
  image(flapBack,0,0);
  flapBack.resize(width, height);
  textSize(55);
  fill(250,250,250);
  text("FLAGGY BIRD", width/2, height/4.6);
   textSize(35);
   fill(250,250,250);
    text("Congratulations on completing", width/2, height/3);
    text("ten correct answers in a row!", width/2, height/2.7);
    text("Click to access a secret gamemode!", width/2, height/2.3);
    text("Use the spacebar to start/jump", width/2, height/2);
    text("GET READY!", width/2, height/1.2);
    if (keyPressed)
    if (key==' ')
   gameState="BIRD";
}


void loseGame() {
  image(wrong, 0,0);


  
  if (mousePressed == true)
   gameState="PLAY";
   
   textSize(25);
   fill(0,0,0);
    text("Current Score: "+score,200,100);
}


void flappyBird(){
  
    imageMode(CORNER);
    image(backpic, 0, 0);
    image(backpic, x+backpic.width, 0);
    x -= 4;
    vertical += 1;
    y += vertical;
    if(x == -1800) x = 0;
    for(int i = 0 ; i < 2; i++) {
      imageMode(CENTER);
      image(wallpic, wallx[i], wally[i] - (wallpic.height/2+100));
      image(wallpic, wallx[i], wally[i] + (wallpic.height/2+100));
      if(wallx[i] < 0) {
        wally[i] = (int)random(200,height-200);
        wallx[i] = width;
      }
      if(wallx[i] == width/2) highscore = max(++score, highscore);
      if(y>height||y<0||(abs(width/2-wallx[i])<25 && abs(y-wally[i])>100)) gameState="INNIT";
      wallx[i] -= 7;
    }
    image(birdpic, width/2, y);
    text("Score: "+score, 10, 20);
    text("/10", 10,20);
    birdpic.resize(75,75);
    textSize(25);
    text("High Score: "+highscore, 200, 130);
    text("Current Score:"+score,200,100);
}



void keyPressed() {
  vertical = -15;
  if(game==1) {
    wallx[0] = 600;
    wally[0] = y = height/2;
    wallx[1] = 900;
    wally[1] = 600;
    x = game = score = 0;
  }
}
