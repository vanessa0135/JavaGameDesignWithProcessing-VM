/* Game Class Starter File
 * Authors: Vanessa B & Mariam L
 * Last Edit: 6/5/2024
 */

//import processing.sound.*;

//------------------ GAME VARIABLES --------------------//

//Title Bar
String titleText = "Stellar Sprint";
String extraText = "Who's Turn?";
String p1 = "STARS P1 =  ";
String p2= "STARS P2 =  ";

//VARIABLES: Whole Gaalien1.move(-10,0);
// AnimatedSprite runningHorse;
// boolean doAnimation;

//variables for star counters 
int starCount1 = 0;
int starCount2 = 0;
//variables for alien count
int alienCount1 = 0;
int alienCount2 = 0;
//total score
int score1 = 0;
int score2 = 0;

//VARIABLES: Splash Screen
Screen splashScreen;
PImage splashBg;
String splashBgFile = "images/apcsa.png";
//SoundFile song;

//VARIABLES: Level1World Screen
// Grid level1Grid;
World level1World;
PImage level1Bg;
String level1BgFile = "images/Space.jpg";

Sprite player1;
String player1File = "images/Astro.png";
int player1Row = 3;
int player1Col = 0;
int health = 3;

Sprite player2;
String player2File = "images/Astro2.png";
int player2Row = 1;
int health2 = 3;

Sprite alien1;
String alien1File = "images/Alien1.png";
int alien1Row = 2;
int alien1Col = 3;

Sprite alien2;
String alien2File = "images/Alien2.png";
int alien2Row = 1;
int alien2Col = 3;

Sprite alien3;
String alien3File = "images/Alien3.png";
int alien3Row = 2;
int alien3Col = 2;

Sprite star;
String starFile = "images/Star.png";
int starRow = 2;
int starCol = 3;

AnimatedSprite walkingChick;
Button b1;

//VARIABLES: EndScreen
World endWorld;
PImage endBg;
String endBgFile = "images/spaceShip.jpg";


//VARIABLES: Tracking the current Screen being displayed
Screen currentScreen;
World currentWorld;
Grid currentGrid;
private int msElapsed = 0;

int msSprites = 0;

//game elements
//int timerCount = 60;
float randoY; 
float randoX; 

String st2 = "TIME: ";
//------------------ REQUIRED PROCESSING METHODS --------------------//

//Required Processing method that gets run once
void setup() {

  //SETUP: Match the screen size to the background image size
  size(1424,748);  //these will automatically be saved as width & height
  imageMode(CORNER);    //Set Images to read coordinates at corners
  //fullScreen();   //only use if not using a specfic bg image
  
  //SETUP: Set the title on the title bar
  surface.setTitle(titleText);

  

  //SETUP: Load BG images used in all screens
  splashBg = loadImage("images/Space.png");
  splashBg.resize(width, height);
  level1Bg = loadImage("images/Space.png");
  level1Bg.resize(width, height);
  endBg = loadImage("images/spaceShip.jpg");
  endBg.resize(626, 417); //maybe make this the same size as the screen with width, height?

  //SETUP: Screens, Worlds, Grids
  splashScreen = new Screen("splash", splashBg);
  //level1Grid = new Grid("Space", level1Bg, 6, 6);
  //level1Grid.startPrintingGridMarks();
  level1World = new World("Space", level1Bg);
  //level2World = new World("sky", level2BgFile, 8.0, 0, 0); //moveable World constructor --> defines center & scale (x, scale, y)???

  endWorld = new World("end", endBgFile, 5.0, 1424.0, 748.0);

  currentScreen = splashScreen;

  //SETUP: Splash Screen
  //runningHorse = new AnimatedSprite("sprites/horse_run.png", "sprites/horse_run.json", 50.0, 75.0, 10.0);
  //runningHorse.animateHorizontal(5.0, 10.0, true);

  //SETUP: Level 1 Screen
  player1 = new Sprite("images/Astro.png", 0.7);
  player2 = new Sprite("images/Astro2.png", 0.7);
  player1.move(50, 800/2);
  player2.move(50, 400/2);
  

  alien1 = new Sprite("images/Alien1.png", 0.6);
  //alien1.move(1424,100); //function to have alien Sprite start at interesting location
  alien2 = new Sprite("images/Alien2.png", 0.6);
  //alien2.move(1424, 200);
  alien3 = new Sprite("images/Alien3.png", 0.6);
  
  star = new Sprite("images/Star.png", 0.15);
  
  Button b1 = new Button("rect", 650, 25, 100, 30,"play again");


  // walkingChick = new AnimatedSprite("sprites/chick_walk.png", "sprites/chick_walk.json", 0.0, 0.0, 5.0);
  // level1World.addSpriteCopyTo(walkingChick, 100, 200);  //example Sprite added to a World at a location, with a speed

  //Adding pixel-based Sprites to the world
  // mainGrid.addSpriteCopyTo(exampleSprite);
  level1World.printWorldSprites();
  System.out.println("Done loading Level 1 ...");
  
  //SETUP: Sound
  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();
  
  //println("Game started...");

} //end setup()


//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {
  

  updateTitleBar();
  updateScreen();
  
  populateSprites();

  //simple timing handling
  if (msElapsed % 300 == 0) {
    //sprite handling
    
    moveSprites();
  }

  msElapsed +=100;
  msSprites += 10;
  currentScreen.pause(50);

  //check for end of game
  if(isGameOver()){
    endGame();
  }

} //end draw()

//------------------ USER INPUT METHODS --------------------//


//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){
  //player1.setSpeed(10, 10);

  //check what key was pressed
  System.out.println("\nKey pressed: " + keyCode); //key gives you a character for the key pressed

  //What to do when a key is pressed?
  
  //KEYS FOR LEVEL1
  if(currentScreen == level1World || currentScreen == endWorld){

    //set [W] key to move the player1 up & avoid Out-of-Bounds errors
    if(keyCode == 87){
      player1.move(0,-50);
    }
     if(keyCode == 65){
      player1.move(-50,0);
    }
     if(keyCode == 68){
      player1.move(50,0);
    }
     if(keyCode == 83){
      player1.move(0,50);
    }


   //move by arrows 
    if(keyCode == 38){
     player2.move(0, -50);
    }
    if(keyCode == 37){
     player2.move(-50,0);
    }
    if(keyCode == 40){
     player2.move(0, 50);
    }
    if(keyCode == 39){
     player2.move(50, 0);
    }
    if(isCollision(player1, star)){
    starCount1++;
    }
    if(isCollision(player2, star)){
    starCount2++;
    }
  }

  //CHANGING SCREENS BASED ON KEYS
  //change to level1 if 1 key pressed, level2 if 2 key is pressed
  if(key == '1'){
    currentScreen = level1World;
   } 
  //else if(key == '2'){
  //   currentScreen = endWorld;
  // }

}

//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){
  
  //check if click was successful
  System.out.println("\nMouse was clicked at (" + mouseX + "," + mouseY + ")");
  if(currentGrid != null){
    System.out.println("Grid location: " + currentGrid.getGridLocation());
  }

  //what to do if clicked? (Make player1 jump back?)
  


  //Toggle the animation on & off
  // doAnimation = !doAnimation;
  // System.out.println("doAnimation: " + doAnimation);
  if(currentGrid != null){
    currentGrid.setMark("X",currentGrid.getGridLocation());
  }

}



//------------------ CUSTOM  GAME METHODS --------------------//

//method to update the Title Bar of the Game
public void updateTitleBar(){

  if(!isGameOver()) {
    //set the title each loop
    score1 = starCount1 - alienCount1;
    score2 = starCount2 - alienCount2;

    surface.setTitle(p1 + score1 + " " + p2 + score2);

    //adjust the extra text as desired
   
   
   
     
  }
   
     
  }


//method to update what is drawn on the screen each frame
public void updateScreen(){
    
  //UPDATE: Background of the current Screen
  if(currentScreen.getBg() != null){
    background(currentScreen.getBg());
  }

  //UPDATE: splashScreen
  if(currentScreen == splashScreen && splashScreen.getScreenTime() > 3000 && splashScreen.getScreenTime() < 5000){
    System.out.print("s");
    currentScreen = level1World;
      
  }

  //UPDATE: level1World Screen
  if(currentScreen == level1World){
    System.out.print("1");

    //Display the Sprites

    player1.show();
    player2.show();

    star.show();

    //update other screen elements
    level1World.showWorldSprites();

    //move to next level based on a button click
    
    String st = "GAME BEGINS IN: ";
    if(currentScreen.getScreenTime()/1000 < 8 ){
      textSize(50);
      text(st + (8 - currentScreen.getScreenTime()/1000), 1050/2, 748/2);
      fill(255, 255, 255);
    } else{
      st = "";
    } 

    
    if(currentScreen.getScreenTime()/1000 >= 8 && (currentScreen.getScreenTime()/1000) < 68){
    textSize(50);
    text(st2 + (68 - currentScreen.getScreenTime()/1000) , 20, 50);
    fill(255, 255, 255);
    //timerCount -= 100;
    } 

    //deleting sprites before changing screens
    if((currentScreen.getScreenTime()/1000) == 68 ){
      player1.moveTo(1500, 1500);
      player2.moveTo(1500, 1500);
      level1World.clearAllSprites();
    }

    // changed to endScreen
    if(currentScreen == level1World && (level1World.getScreenTime()/1000 > 68) && level1World.getScreenTime()/1000 < 71 ){
      
      currentScreen = endWorld;
      
      System.out.println("end screen is shown");
    }
    
  }

    //UPDATE: endWorld Screen
    if(currentScreen == endWorld){

      player1.show();
      player2.show();

      System.out.print("2");

      textSize(50);
      text("SUMMARY", 600, 200);
      fill(255, 255, 255);

      //player 1 summary
      textSize(30);
      text("Player 1 star collected: " + starCount1, 300, 300);
      fill(255, 255, 255);

      textSize(30);
      text("Player 1 alien collided: " + alienCount1, 300, 400);
      fill(255, 255, 255);

      textSize(30);
      text("Player 1 total score: " + score1, 300, 500);
      fill(255, 255, 255);

      //player 2 summary
      textSize(30);
      text("Player 2 star collected: " + starCount2, 800, 300);
      fill(255, 255, 255);

      textSize(30);
      text("Player 2 alien collided: " + alienCount2, 800, 400);
      fill(255, 255, 255);

      textSize(30);
      text("Player 2 total score: " + score2, 800, 500);
      fill(255, 255, 255);

      if(score1 > score2){
        textSize(50);
        text("Player 1 Won!", 600, 700);
      } else{
        textSize(50);
        text("Player 2 Won!", 600, 700);
      }

       //b1.show();

      // if(b1.isClicked()){
      //   currentScreen = splashScreen;
      //   System.out.println("\nButton Clicked");
      // }
    //endWorld.showWorldSprites();

  
    }

  }//UPDATE: End Screen




//Method to populate enemies or other sprites on the screen
public void populateSprites(){
  
  //Generate a random number
  //float randoX = ((float) Math.random()  * 500) + 500;
  randoY = (float)  Math.random()  * 630;
  randoX = (float)  Math.random()  * 1420;
  //System.out.println("x: " + randoX);

  alien1.move(-10,0);  //<-- this is the original alien who is not a part of the arrayList
  //star.move(-10,0);  //<-- this is the original star who is not a part of the arrayList
     
  
if((currentScreen.getScreenTime()/1000 >= 8) && currentScreen == level1World){

  if (msElapsed % 200 == 0) {
    //System.out.println("sprites are being shown");

    //sprite handling
    for(int i = 0; i < level1World.getSprites().size(); i++){

      level1World.getSprites().get(i).move(-10, 0);
    }

    if(msSprites % 950 == 50) {

      level1World.addSprite(alien1.copyTo(1424, randoY));
    }
    if(msSprites % 1500 == 0){

      level1World.addSprite(alien2.copyTo(1424, randoY));
    }
    if(msSprites % 1040 == 0){

      level1World.addSprite(alien3.copyTo(1424, randoY));
    }

    
  }

 
    if((starCount1 >= 1) || (starCount2 >= 1)) {
      level1World.removeSprite(star);
      
    } else {
      star.moveTo(500, 500);
    }
  
   if(isCollision(player1, star) || isCollision(player2, star)){
      level1World.removeSprite(star);
      star.moveTo(randoX, randoY);
      level1World.showWorldSprites();
    }
  
  }
    
}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){
  // System.out.println("p1 top " + player1.getTop());
  // System.out.println("p1 bottom " + player1.getBottom());

  //loop through alien array list
  for(int i = 0; i < level1World.getSprites().size(); i++){

    Sprite sprite = level1World.getSprites().get(i);

       if(isCollision(player1, sprite)){
        
        level1World.removeSprite(sprite);
        alienCount1++;
        
      }

      if(isCollision(player2, sprite)){
      
        level1World.removeSprite(sprite);
        alienCount2++;
      
      }
      if(sprite.getRight() < 0){
        
        level1World.removeSprite(sprite);
        }
      }

        //deletes array when off screen
         
      //System.out.println(loc + " " + grid.hasTileImage(loc));
          
      //CASE 3: Enemy leaves screen at first column
   }
       



//Method to check if there is a collision between Sprites on the Screen
public boolean isCollision(Sprite sp1, Sprite sp2){
   
   if (sp1.getTop() < sp2.getBottom()){
    if (sp1.getBottom() > sp2.getTop()) {
      if (sp1.getRight() > sp2.getLeft()){
        if (sp1.getLeft() < sp2.getRight()){
            return true;
        }
      }
    }
   }
  //   if (sp2.getTop() < sp1.getBottom()){
  //   if (sp2.getBottom() > sp1.getTop()) {
  //     if (sp2.getRight() > sp1.getLeft()){
  //       if (sp2.getLeft() < sp1.getRight()){
        
  //        return true;
         
  //       }
  //     }
  //   }
  // }
  return false; //<--default return
}


//method to indicate when the main game is over
public boolean isGameOver(){
  
  return false; //by default, the game is never over
}

//method to describe what happens after the game is over
public void endGame(){
    System.out.println("Game Over!");

    //Update the title bar

    //Show any end imagery



}
