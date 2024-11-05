import processing.sound.*;//im adding music in just to give the game some peaceful feeling

SoundFile music;




PImage img; // used cs171 lab to add image
ArrayList<Integer> x = new ArrayList<Integer>(), y =new  ArrayList<Integer>();//https://www.youtube.com/watch?v=UpGCxdTXfSY&t=671s
int q = 30, e=30, snakes=20, movement = 2, biax=15, biay=15,bd1=255,bd2=255,bd3=255, drive = 8, foodx = 10, foody=10;
//variables that move the snake
// if direction == 0 =down 1=up 2=right 3=left
int[]x_direction={0, 0, 1, -1}, y_direction={1, -1, 0, 0, };
boolean gameover=false;
String[] headlines = {
  "Dont Hit The Walls,  Dont touch the squares.", 
  "Enjoy The Game!!",// code taken from website http://learningprocessing.com/examples/chp17/example-17-03-scrollingtext#
};
PFont d;
float p;
int index = 0;


void setup() {
  surface.setTitle("My CS171 Project");
  size(600, 600);
  img = loadImage("snakey.jpg");
  x.add(0);
  y.add(15);
  d = createFont("Arial",16);
  
  p = width;
  
  music = new SoundFile(this, "adv.mp3");//incompetech.filmmusic.io
  music.play();
}

void draw() {
  background(0);
  image(img,0,0);
  fill(168, 228, 255);
  
  textFont(d,16);
  textAlign(LEFT);
  
  text(headlines[index],p,height-20);
  
  p = p-3;
  
  
  float z = textWidth(headlines[index]);
  if(p< -z){
  p = width;
  
  index =(index + 1) %headlines.length;
  }
  for (int i = 0; i< x.size(); i++) rect(x.get(i)*snakes, y.get(i)*snakes, snakes, snakes);
  if (!gameover) {
    fill(255); //food color
    fill(bd1,bd2,bd3);
    ellipse(biax*snakes+10, biay*snakes+10, snakes, snakes); //food
    fill(168, 50, 164);
    rect(foodx*snakes, foody*snakes , snakes, snakes);
    textAlign(LEFT); //score
    textSize(25);
    fill(255);
    text("Score: "+ x.size(), 10,10,width -20, 50);
    //code works 6 times a second since processing works at a defult 60 framrate
    if (frameCount%drive==0){
      x.add(0, x.get(0) + x_direction[movement]);
      y.add(0, y.get(0) + y_direction[movement]);
      if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) >=q || y.get(0) >=e) gameover=true;
      for(int i =1; i<x.size(); i++)
      if(x.get(0)==x.get(i)&&y.get(0)==y.get(i)) gameover = true;
      if (x.get(0)==foodx && y.get(0)==foody) {
        gameover = true;
      }
      if (x.get(0)==biax && y.get(0)==biay) {
        if(x.size()%5==0 && drive>=2) drive-=1;
        biax = (int)random(0, q);
        biay = (int)random(0, e);
        bd1=(int)random(255);bd2=(int)random(255);bd3=(int)random(255);
        foodx = (int)random(0, q);
        foody = (int)random(0, e);
      } else {
        //removes trail of blocks
        x.remove(x.size()-1);
        y.remove(y.size()-1);
      }
    }
  }else{
    music.stop();
    
    fill(193, 204, 39);
    textSize(40);
    textAlign(CENTER);
    text("GAME OVER \n Your Score is: "+ x.size() + "\n Press ENTER", width/2, height/3);
    if (keyCode == ENTER) {
      
      x.clear();
      y.clear();
      x.add(0);
      y.add(15);
     movement = 2;
      drive = 8;
      gameover = false; // code help from website:https://openprocessing.org/sketch/50988/#
      
      music.play();
    }
  }
}
//coding the snake to move when key is pressed
void keyPressed() {
  int newdir=keyCode == DOWN? 0:(keyCode== UP?1:(keyCode == RIGHT?2:(keyCode == LEFT?3:-1)));
  if (newdir !=-1) movement = newdir;
  
}
