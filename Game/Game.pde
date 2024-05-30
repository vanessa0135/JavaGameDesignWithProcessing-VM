/* Game Class Starter File
 * Authors: Joel A. Bianchi
 * Last Edit: 5/29/2024
 * Modified for AnimatedSprites
 */

//import processing.sound.*;

//------------------ GAME VARIABLES --------------------//

//Title Bar
String titleText = "Stellar Sprint";
String extraText = "Who's Turn?";

//VARIABLES: Whole Game
AnimatedSprite runningHorse;
boolean doAnimation;

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

AnimatedSprite walkingChick;
Button b1 = new Button("rect", 650, 525, 100, 50, "GoToLevel2");

//VARIABLES: Level2World Pixel-based Screen

//VARIABLES: EndScreen
World endScreen;
PImage endBg;
String endBgFile = "images/youwin.png";


//VARIABLES: Tracking the current Screen being displayed
Screen currentScreen;
World currentWorld;
Grid currentGrid;
private int msElapsed = 0;


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

  endScreen = new World("end", endBg);
  currentScreen = splashScreen;

  //SETUP: Splash Screen
  runningHorse = new AnimatedSprite("sprites/horse_run.png", "sprites/horse_run.json", 50.0, 75.0, 10.0);
  runningHorse.animateHorizontal(5.0, 10.0, true);

  //SETUP: Level 1 Screen
  player1 = new Sprite("images/Astro.png", 0.7);
  player2 = new Sprite("images/Astro2.png", 0.7);
  player1.move(50, 800/2);
  player2.move(50, 400/2);

  alien1 = new Sprite("images/Alien1.png", 0.8);
  alien1.moveTo(600,100); //function to have alien Sprite start at interesting location
  alien2 = new Sprite("images/Alien2.png", 0.8);
  alien3 = new Sprite("images/Alien3.png", 0.8);

  walkingChick = new AnimatedSprite("sprites/chick_walk.png", "sprites/chick_walk.json", 0.0, 0.0, 5.0);
  level1World.addSpriteCopyTo(walkingChick, 100, 200);  //example Sprite added to a World at a location, with a speed

  //Adding pixel-based Sprites to the world
  // mainGrid.addSpriteCopyTo(exampleSprite);
  level1World.printWorldSprites();
  System.out.println("Done loading Level 1 ...");
  
  //SETUP: Sound
  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();
  
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
  System.out.println("\nKey pressed: " + keyCode); //key gives you a character for the key pressed

  //What to do when a key is pressed?
  
  //KEYS FOR LEVEL1
  if(currentScreen == level1World){

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
    currentScreen = level1World;
  } else if(key == '2'){
    //currentScreen = level2World;
  }

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

    alien1.move(-10, 5);
    alien1.show();
    //alien1.setSpeed(100, 100);
    alien2.show();
    alien3.show();

    //update other screen elements
    level1World.showWorldSprites();

    //move to next level based on a button click
    b1.show();
    if(b1.isClicked()){
      System.out.println("\nButton Clicked");
    }

  }
  
  //UPDATE: End Screen


}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

  //What is the index for the last column?
  //int lastCol = level1Grid.getNumCols() -1;

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
