/* Sprite class - to create objects that move around with their own properties
 * Inspired by Daniel Shiffman's p5js Animated Sprite tutorial
 * Note: Picture coordinate origina at top, left corner
 * Author: Joel Bianchi
 * Last Edit: 6/10/24
 * Added getName() method for easier tracking of categories of sprites
 */

public class Sprite {
  
  //------------------ SPRITE FIELDS --------------------//
  PImage spriteImg;
  private String spriteImgFile;
  private float centerX;
  private float centerY;
  private float speedX;
  private float speedY;
  private float w;
  private float h;
  private boolean isAnimated;


  //------------------ SPRITE CONSTRUCTORS --------------------//

  // Sprite Constructor #1: Only pass in the image file (Non-animated)
  public Sprite(String spriteImgFile){
    this(spriteImgFile, 1.0, 0.0, 0.0, false);
  }

  // Sprite Constructor #2: Only pass in the image file that can be scaled (Non-animated)
  public Sprite(String spriteImgFile, float scale){
    this(spriteImgFile, scale, 0.0, 0.0, false);
  }

  // Sprite Constructor #3: for Non-Animated Sprite
  public Sprite(String spriteImgFile, float scale, float x, float y) {
    this(spriteImgFile, scale, x, y, false);
  }

  // Sprite Constructor #4: for ANY Sprite
  public Sprite(String spriteImgFile, float scale, float x, float y, boolean isAnimated) {
    this.spriteImgFile = spriteImgFile;
    setLeft(x);
    setTop(y);
    this.speedX = 0;
    this.speedY = 0;
    this.isAnimated = isAnimated;
    if(!isAnimated){
      if( spriteImgFile != null){
        this.spriteImg = loadImage(spriteImgFile);
        w = spriteImg.width * scale;
        h = spriteImg.height * scale;
      } else{
        
      }

    }
  }


  //------------------ SPRITE MOTION METHODS --------------------//

  // method to display the Sprite image on the screen
  public void show() {
      image(spriteImg, getLeft(), getTop(), w, h);
  }

  // method to move Sprite image on the screen to a specific coordinate
  public void moveTo(float x, float y){
    setLeft(x);
    setTop(y);
  }

  // method to move Sprite image on the screen relative to current position
  public void move(float changeX, float changeY){
    this.centerX += changeX;
    this.centerY += changeY;
    //System.out.println(getLeft() + "," + getTop());
  }

  //method to change the speed of the Sprite
  public void setSpeed( float speedX, float speedY){
    this.speedX = speedX;
    this.speedY = speedY;
  }


  // method to rotate Sprite image on the screen
  public void rotate(float degrees){
    float rads = radians(degrees);
    translate(centerX,centerY);
    rotate(rads);
  }



  //------------------ SPRITE ACCESSOR METHODS --------------------//

  public float getW(){
    return w;
  }
  public float getH(){
    return h;
  }
  public float getCenterX(){
    return centerX;
  }
  public float getCenterY(){
    return centerY;
  }
  public float getX(){
    return getCenterX();
  }
  public float getY(){
    return getCenterY();
  }
  public PImage getImg(){
    return spriteImg;
  }
  public boolean getIsAnimated(){
    return isAnimated;
  }
  
  
  //------------------ SPRITE MUTATOR METHODS --------------------//

  public void setW(float w){
    this.w = w;
  }
  public void setH(float h){
    this.h=h;
  }
  public void setCenterX(float centerX){
    this.centerX = centerX;
  }
  public void setCenterY(float centerY){
    this.centerY=centerY;
  }
  public void setImg(PImage img){
    this.spriteImg = img;
  }
  public void setIsAnimated(boolean a){
    isAnimated = a;
  }


  /*------------------ SPRITE BOUNDARY METHODS  --------------------
   * -- Used from Long Bao Nguyen
   *  -- https://longbaonguyen.github.io/courses/platformer/platformer.html
   */
  void setLeft(float left){
    centerX = left + w/2;
  }
  float getLeft(){
    return centerX - w/2;
  }
  void setRight(float right){
    centerX = right - w/2;
  }
  float getRight(){
    return centerX + w/2;
  }
  void setTop(float top){
    centerY = top + h/2;
  }
  float getTop(){
    return centerY - h/2;
  }
  void setBottom(float bottom){
    centerY = bottom - h/2;
  }
  float getBottom(){
    return centerY + h/2;
  }

  //Accessor method to the image path of the Sprite
  public String getImagePath(){
    return this.spriteImgFile;
  }
  public String getName(){
    return getImagePath();
  }
  
  //Accessor method to the image path of the Sprite
  public PImage getImage(){
    return this.spriteImg;
  }

  //Method to copy a Sprite to a specific location
  public Sprite copyTo(float x, float y){

    PImage si = this.spriteImg;
    String sif = this.spriteImgFile;
    float cx = this.centerX;
    float cy = this.centerY;
    float sx = this.speedX;
    float sy = this.speedY;
    float w = this.w;
    float h = this.h;
    boolean ia = this.isAnimated;
    
    Sprite sp = new Sprite(sif, 1.0, x, y, ia);
    sp.setSpeed(sx,sy);
    sp.setW(w);
    sp.setH(h);

    return sp;

  }

  public void resize(int width, int height){
    spriteImg.resize(width, height);
  }


  // method that automatically moves the Sprite based on its velocity
  public void update(){
    move(speedX, speedY);
  }

  public void update(float deltaTime){
    speedX += deltaTime/1000;
    speedY += deltaTime/1000;
    move(speedX, speedY);
  }

  //Method to copy a Sprite to same location
  public Sprite copy(){
    return copyTo(this.centerX, this.centerY);
  }

  //Method to check if 2 Sprites are the same (based on PImage)
  public boolean equals(Sprite otherSprite){
    if(this.spriteImgFile != null && otherSprite != null && this.spriteImgFile.equals(otherSprite.getImagePath())){
      return true;
    }
    return false;
  }

  public String toString(){
    return spriteImgFile + "\t" + getLeft() + "\t" + getTop() + "\t" + speedX + "\t" + speedY + "\t" + w + "\t" + h + "\t" + isAnimated;
  }


}
