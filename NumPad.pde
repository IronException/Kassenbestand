
public class NumPad extends Panel{
  
  public NumPad(){
    super();
    state = false;
  }
  
  boolean animate = true;
  boolean overlapping = true;
  
  Panel[] panels;
  boolean state;
  
  
  
  public void setState(boolean state){
    this.state = state;
    
    int animation = 0;
    if(animate){
      animation = animationLen;
    }
    
    // depending on overlapping it sets the pos when disabled directly under screen or every key the same dist...
    // TODO set pos and also depending on animation..
  }
  
  public boolean getState(){
    return this.state;
  }
  
  public float getTextSize(float now, float step){
    for(int i = 0; i < panels.length; i ++){
      now = panels[i].getTextSize(now, step);
    }
    return now;
  }
  
  public void render(){
    for(int i = panels.length - 1; i >= 0; i --){
      panels[i].render();
    }
    
  }
  
  
}


public class Key extends Panel{
  
  public Key(String name){
    this.name = name;
  }
  
  String name;
  
  @Override
  public float getTextSize(float now, float maxDist){
    return calcTextSize(name, now, maxDist, xSize, ySize);
  }
  
  public void render(){
    stroke(blackFrameCol);
    fill(255);
    rect(xPos, yPos, xSize, ySize);
    float xP = xPos + xSize / 2.0 - textWidth(name) / 2.0;
    float yP = yPos + ySize / 2.0 + (textAscent() - textDescent()) / 2.0;
    text(name, xP, yP);
    
  }
  
}