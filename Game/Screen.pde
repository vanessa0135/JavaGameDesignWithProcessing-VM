/* Screen class - a high level class that handles background screens & millisecond timing
 * Has a World Subclass
 * Author: Joel Bianchi & Carey Jiang
 * Last Edit: 5/20/2024
 * Added moveable background
 */

public class Screen {

    //Screen fields
    private String screenName;
    private PImage bg;
    private boolean isMoveable;
    private Sprite mbg;
    
    private long startTime;
    private long lastTime = 0;

    //Screen Constructor #1: For background images that move (Coded as a Sprite, not a Processing background PImage)
    public Screen(String screenName, String movingBgFile, float x, float y, float scale) {
        this.isMoveable = true;
        this.setName(screenName);
        mbg = new Sprite(movingBgFile, x, y, scale);
        
        this.x = x;
        this.y = y;
        startTime = getTotalTime();
    }

    //Screen Constructor #2: Stationary background image
    public Screen(String screenName, PImage bg) {
        this.isMoveable = false;
        this.setName(screenName);
        if(bg != null) {
            this.setBg(bg);
        }
    }

    //Screen Accessors + Mutators
    public void setName(String screenName){
        this.screenName = screenName;
    }
    public String getName(){
        return screenName;
    }

    public void setBg(PImage bg){
        if(!isMoveable){
            this.bg = bg;
            //background(bg);
        }
    }
    public PImage getBg(){
        return bg;
    }

    //SCREEN MOVING METHODS

    //move the background image in the X direction
    public void moveBgXY(float speedX, float speedY){
        mbg.move(speedX, speedY);
    }

    

    //speedx
    //speedy
    //movexy
    //restart
    //incrementalmovex
    //incrementalmovey


    public void setX(float x) {
        this.x = x;
    }
    public float getX() {
        return x;
    }

    public void setY(float y) {
        this.y = y;
    }
    public float getY() {
        return y;
    }

    //???
    public void setScreenSize(int w, int h){

    }
    

    //SCREEN TIME METHODS
    public long getTotalTime(){
        return millis();  //milliseconds world
    }
    public long getScreenTime(){
        return millis() - startTime;  //milliseconds world
    }
    public long getTimeSince(long lastCheck){
        return getScreenTime() - lastCheck;
    }
    public float getScreenTimeSeconds(){
        return getScreenTime() / 1000.0f;
    }
    
    //pauses ALL screen methods!
    public void pause(final int milliseconds) {
        try {
            Thread.sleep(milliseconds);
        } catch (final Exception e) {
            System.out.println(e);
        }
    }



    public String toString(){
        return "Screen: " + screenName + " at " + x + "," + y;
    }

    //updates the time and any movement of the background
    public void updateScreen(){

        //update time

        if(isMoveable){
            //update screen
        }

    }


}
