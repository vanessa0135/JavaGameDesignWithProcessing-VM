/* Game Class Starter File
 * Authors: Joel A. Bianchi
 * Last Edit: 5/22/2024
 */

//import processing.sound.*;

//------------------ GAME VARIABLES --------------------//

//Title Bar
String titleText = "Stellar Sprint";
String extraText = "Who's Turn?";

//Splash Screen Variables
Screen splashScreen;
PImage splashBg;
String splashBgFile = "images/apcsa.png";
//SoundFile song;

//Level1 Grid-Screen Variables
Grid level1Grid;
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

Button b1 = new Button("rect", 400, 500, 100, 50, "GoToLevel2");

//EndScreen variables
World endScreen;
PImage endBg;
String endBgFile = "images/youwin.png";

//Whole Game Variables
AnimatedSprite exampleSprite;
boolean doAnimation;

//Variables to track the current Screen being displayed
Screen currentScreen;
World currentWorld;
Grid currentGrid;
private int msElapsed = 0;


//------------------ REQUIRED PROCESSING METHODS --------------------//

//Required Processing method that gets run once
void setup() {

  //Match the screen size to the background image size
  size(1424,748);
  
  //Set the title on the title bar
  surface.setTitle(titleText);

  

  //Load BG images used
  splashBg = loadImage("images/Space.png");
  splashBg.resize(1424,748);
  level1Bg = loadImage("images/Space.png");
  level1Bg.resize(1424,748);
  endBg = loadImage("images/spaceShip.jpg");
  endBg.resize(626, 417);
   
  //setup the screens/worlds/grids in the Game
  splashScreen = new Screen("splash", splashBg);
  level1Grid = new Grid("Space", level1Bg, 6, 6);
  level1World = new World("Space", level1Bg);
  //level2World = new World("sky", level2BgFile, 8.0, 0, 0); //moveable World constructor --> defines center & scale (x, scale, y)???
  //level2World = new World("sky", level2Bg);   //simple World construtor
  endScreen = new World("end", endBg);
  currentScreen = splashScreen;

  //setup the sprites  
  player1 = new Sprite("images/Astro.png", 0.7);
  player2 = new Sprite("images/Astro2.png", 0.7);
  player1.move(50, 800/2);
  player2.move(50, 400/2);


  // mainGrid.setTileSprite(player1);
  // mainGrid.addSprite(player1);

//h
  //player1.resize(100, 100);

  alien1 = new Sprite("images/Alien1.png", 0.8);
  alien2 = new Sprite("images/Alien2.png", 0.8);
  alien3 = new Sprite("images/Alien3.png", 0.8);

  //  enemy.resize(100,100);

  //Adding pixel-based Sprites to the world
  // level1Grid.addSpriteCopyTo(exampleSpriteet);
  level1Grid.printSprites();
  System.out.println("Done adding sprites to main world..");
  
  //Other Setup
  exampleAnimationSetup();

  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();
  
  imageMode(CORNER);    //Set Images to read coordinates at corners
  //fullScreen();   //only use if not using a specfic bg image
  println("Game started...");

} //end setup()

//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {

  updateTitleBar();
  updateScreen();

  //simple timing handling
  if (msElapsed % 300 == 0) {
    //sprite handling
    populateSprites();
    moveSprites();
  }
  msElapsed +=100;
  currentScreen.pause(100);

  //check for end of game
  if(isGameOver()){
    endGame();
  }

} //end draw()

//------------------ USER INPUT METHODS --------------------//


//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("Key pressed: " + keyCode); //keyCode gives you an integer for the key

  //What to do when a key is pressed?
  
  //KEYS FOR LEVEL1
  if(currentScreen == level1Grid){

    //set [W] key to move the player1 up & avoid Out-of-Bounds errors
    if(keyCode == 87){
      player1.move(0,-70);
    }
     if(keyCode == 65){
      player1.move(-70,0);
    }
     if(keyCode == 68){
      player1.move(70,0);
    }
     if(keyCode == 83){
      player1.move(0,70);
    }

   //move by arrows 
  if(keyCode == 38){
    
   
     player2.move(0, -50);
    }

    if(keyCode == 37){
    
    
     player2.move(-70,0);
    }
    if(keyCode == 40){
    
      
     player2.move(0, 70);
    }
    if(keyCode == 39){
    
     
     player2.move(70, 0);
    }

    


    


  }

  //CHANGING SCREENS BASED ON KEYS
  //change to level1 if 1 key pressed, level2 if 2 key is pressed
  if(key == '1'){
    currentScreen = level1Grid;
  } else if(key == '2'){
    //currentScreen = level2World;
  }

}

//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){
  
  //check if click was successful
  System.out.println("Mouse was clicked at (" + mouseX + "," + mouseY + ")");
  if(currentGrid != null){
    System.out.println("Grid location: " + currentGrid.getGridLocation());
  }

  //what to do if clicked? (Make player1 jump back?)
  


  //Toggle the animation on & off
  doAnimation = !doAnimation;
  System.out.println("doAnimation: " + doAnimation);
  if(currentGrid != null){
    currentGrid.setMark("X",currentGrid.getGridLocation());
  }

}



//------------------ CUSTOM  GAME METHODS --------------------//

//method to update the Title Bar of the Game
public void updateTitleBar(){

  if(!isGameOver()) {
    //set the title each loop
    surface.setTitle(titleText + "    " + extraText + " " + health);

    //adjust the extra text as desired
  
  }
}

//method to update what is drawn on the screen each frame
public void updateScreen(){

  //Update the Background of the current Screen
  if(currentScreen.getBg() != null){
    background(currentScreen.getBg());
  }

  //splashScreen update
  if(splashScreen.getScreenTime() > 3000 && splashScreen.getScreenTime() < 5000){
    currentScreen = level1World;
    player1.show();
    player2.show();
  }

  //level1Screen Screen Updates
  if(currentScreen == level1World){
    currentScreen = level1World;

    //Display the Player1 image
    // GridLocation player1Loc = new GridLocation(player1Row,0);
    // GridLocation player2Loc = new GridLocation(player2Row,0);
    //level1Grid.setTileSprite(player1Loc, player1);
    player1.show();
    player2.show();

    alien1.show();
    //alien1.setSpeed(100, 100);
    alien2.show();
    alien3.show();

  // for(int i = 0; i< 10; i++){
  //   alien1.move(-100, 100);
  // }
    //update other screen elements
    level1World.showSprites();
    // level1Grid.showImages();
    // level1Grid.showGridSprites();

    //move to next level based on a button click
    b1.show();
    if(b1.isClicked()){
      //currentScreen = level2World;
    }
    
  }

  //level2World Updates
  // else if(currentScreen == level2World){
  //   currentWorld = level2World;
    
  //   level2World.moveBgXY(-3.0, 0);
  //   level2World.show();
  //   player2.show();


  // }

  //Updtes for any Screen
  checkExampleAnimation();


}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

  //What is the index for the last column?
  int lastCol = level1Grid.getNumCols() -1;

  //Loop through all the rows in the last column

    //Generate a random number


    //10% of the time, decide to add an enemy image to a Tile
    

}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){

//Loop through all of the rows & cols in the grid

      //Store the current GridLocation

      //Store the next GridLocation

      //Check if the current tile has an image that is not player1      


        //Get image/sprite from current location
          

        //CASE 1: Collision with player1


        //CASE 2: Move enemy over to new location


        //Erase image/sprite from old location

        //System.out.println(loc + " " + grid.hasTileImage(loc));

          
      //CASE 3: Enemy leaves screen at first column

}

//Method to check if there is a collision between Sprites on the Screen
public boolean checkCollision(GridLocation loc, GridLocation nextLoc){

  //Check what image/sprite is stored in the CURRENT location
  // PImage image = grid.getTileImage(loc);
  // AnimatedSprite sprite = grid.getTileSprite(loc);

  //if empty --> no collision

  //Check what image/sprite is stored in the NEXT location

  //if empty --> no collision

  //check if enemy runs into player

    //clear out the enemy if it hits the player (using cleartTileImage() or clearTileSprite() from Grid class)

    //Update status variable

  //check if a player collides into enemy

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
    currentScreen = endScreen;

}

//example method that creates 1 horse run along the screen
public void exampleAnimationSetup(){  
//   int i = 2;
//   exampleSprite = new AnimatedSprite("sprites/horse_run.png", "sprites/horse_run.json", 50.0, i*75.0);
//   //exampleSprite.resize(200,200);
}

//example method that animates the horse Sprites
public void checkExampleAnimation(){
  if(doAnimation){
    //exampleSprite.animateHorizontal(5.0, 10.0, true);
    //System.out.println("animating!");
  }
}
