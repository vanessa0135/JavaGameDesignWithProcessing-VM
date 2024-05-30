/* GridTile class - Designed to be used within the Grid class
 * GridTiles have distinguishable marks that will be printed out to the console for easy visualization of a 2D array
 * GridTiles can indicate if they have been "captured", colored, or are displaying an image
 * Authors: Joel Bianchi, Naomi Gaylor, Ezzeldin Moussa
 * Last Edit: 5/29/24
 * Functioning with Sprites and AnimatedSprites
 */

import java.awt.Color;

public class GridTile{
  
  private GridLocation location;
  private PImage pi;
  private Sprite sprite;
  private boolean coveredPic;
  private color fillColor;
  final color defaultFillColor = #FFFFFF; //WHITE
  private color outlineColor;
  final color defaultOutlineColor = #000000; //BLACK
  private String mark;
  final private static String noMark = " ";
  private boolean isCaptured;

  //------------------GridTile Constructors ---------------//
  //GridTile constructor #1: Adds the specified String mark
  public GridTile(String mark, GridLocation loc){
    this.mark = mark;
    location = loc;
    fillColor = defaultFillColor;
    outlineColor = defaultOutlineColor;
    coveredPic = false;
  }
  
  //GridTile constructor #2 which adds a mark, but no Location
  public GridTile(String mark){
    this(mark, null);
  }

  //GridTile constructor #3 which adds a GridLocation, but no mark  
  public GridTile(GridLocation loc){
    this(noMark, loc);
  }

  //Default GridTile constructor which puts an empty String mark in the GridTile
  public GridTile(){
    this(noMark, null);
  }

  //------------------Marking Methods ---------------//
  // Accessor method that gets the mark in the GridTile
  public String getMark(){
    return mark;
  }

  //Method to access the symbol for no mark
  public String getNoMark(){
    return noMark;
  }
  
  // Mutator method that automatically changes the mark
  public void setMark(String mark){
    this.mark = mark;
  }

  // Mutator method sets a new mark in the GridTile 
  // if it does not already have a mark, 
  // returns true or false if successful
  public boolean setNewMark(String mark){
    if(this.mark.equals(noMark)){
      this.mark = mark;
      System.out.println("Successfully changed mark");
      return true;
    } else {
      System.out.println("That GridTile is already taken!");
      return false;
    }
  }

  public boolean removeMark(){
    if(this.mark.equals(noMark)){
      return false;
    }
    else{
      this.mark = noMark;
      return true;
    }
  }
  
  //------------------PImage Methods ---------------//
  // Mutator method that sets a new PImage in the GridTile
  public void setImage(PImage pi){
    this.pi = pi;
  }

  //Accessor method that returns the PImage stored in the GridTile
  public PImage getImage(){
    return pi;
  }

  //Method to check if the GridTile has an PImage in it
  public boolean hasImage(){
    if(pi == null){
      return false;
    }
    return true;
  }

  //------------------Sprite Methods ---------------//
 // Mutator method that sets a new Sprite in the GridTile
  public void setSprite(Sprite sprite){
    this.sprite = sprite;
  }

  //Accessor method that returns the Sprite stored in the GridTile
  public Sprite getSprite(){
    return sprite;
  }

  //Method to check if the GridTile has an Sprite in it
  public boolean hasSprite(){
    if(sprite == null){
      return false;
    }
    return true;
  }

  //------------------Capturing Tiles Methods ---------------//
  //method to "capture" a tile by changing its color
  public void captureTile(color clr){
    this.isCaptured = false;
    this.fillColor = clr;
  }

  //method to "release" a tile by changing its color
  public void releaseTile(){
    this.isCaptured = false;
    this.fillColor = defaultFillColor;
  }

  //accessor method to check if tile is captured
  public boolean checkIsCaptured(){
    return isCaptured;
  }


  //------------------Coloring Tiles Methods ---------------//
  //method to change the color of the tile
  public void setColor(color clr) {
    this.fillColor = clr;
  }

  //method to access the color of the tile
  public color getColor() {
    return fillColor;
  }

  public void setOutlineColor(color oclr){
    this.outlineColor = oclr;
  }

  public color getOutlineColor(){
    return this.outlineColor;
  }

  public void setCoveredWithPic(boolean isCoveredWithPic) {
    this.coveredPic = isCoveredWithPic;
  }

  public boolean isCoveredWithPic() {
    return this.coveredPic;
  }



  //method to access the location of the GridTile
  public GridLocation getLocation(){
      return location;
  }

  //ToString simply retuns the mark on the Tile, useful for printing out 2D grids
  public String toString(){
    return mark;
  }


}
