/* Game Class Starter File
 * Authors: _____________________
 * Last Edit: 5/17/23
 */

//GAME VARIABLES
Grid grid = new Grid(6,8);
//HexGrid hGrid = new HexGrid(3);
PImage bg;
PImage player1;
PImage player2;
PImage endScreen;
String titleText = "HorseChess";
String extraText = "Who's Turn?";
AnimatedSprite exampleSprite;
boolean doAnimation;

int userRow = 3;


//Required Processing method that gets run once
void setup() {

  //Match the screen size to the background image size
  size(800, 600);

  //Set the title on the title bar
  surface.setTitle(titleText);

  //Load images used
  bg = loadImage("images/chess.jpg");
  player1 = loadImage("images/x_wood.png");
  player1.resize(100,100);
  endScreen = loadImage("images/youwin.png");

  
  //Animation & Sprite setup
  exampleAnimationSetup();

  println("Game started...");

  //fullScreen();   //only use if not using a specfic bg image
}

//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {

  updateTitleBar();
  updateScreen();
  populateSprites();
  moveSprites();
  
  if(isGameOver()){
    endGame();
  }

  checkExampleAnimation();

}


//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){
  
  //check if click was successful
  System.out.println("Mouse was clicked at (" + mouseX + "," + mouseY + ")");
  System.out.println("Grid location: " + grid.getGridLocation());

  //what to do if clicked?
  doAnimation = !doAnimation;
  System.out.println("doAnimation: " + doAnimation);
  grid.setMark("X",grid.getGridLocation());
  
}

//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("Key pressed: " + keyCode); //keyCode gives you an integer for the key

  //What to do when a key is pressed?
  
  //set "w" key to move the player1 up
  if(keyCode == 87){
    //check case where out of bounds
    
    //change the field for userRow
    userRow--;

    //shift the user picture up in the array
    GridLocation loc = new GridLocation(userRow, 0);
    grid.setTileImage(loc, player1);

    //eliminate the picture from the old location

  }


}



//------------------ CUSTOM  METHODS --------------------//

//method to update the Title Bar of the Game
public void updateTitleBar(){

  if(!isGameOver()) {
    //set the title each loop
    surface.setTitle(titleText + "    " + extraText);

    //adjust the extra text as desired
  
  }

}

//method to update what is drawn on the screen each frame
public void updateScreen(){

  //update the background
  background(bg);

  //Display the Player1 image
  GridLocation userLoc = new GridLocation(userRow,0);
  grid.setTileImage(userLoc, player2);
  
  //update other screen elements


}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){


}

//Method to handle the collisions between Sprites on the Screen
public void handleCollisions(){


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
    image(endScreen, 100,100);

}

//example method that creates 5 horses along the screen
public void exampleAnimationSetup(){  
  int i = 2;
  exampleSprite = new AnimatedSprite("sprites/horse_run.png", 50.0, i*75.0, "sprites/horse_run.json");
}

//example method that animates the horse Sprites
public void checkExampleAnimation(){
  if(doAnimation){
    exampleSprite.animateVertical(1.0, 0.1, true);
  }
}