

public class Screen extends UseProc{
  
  
  public Screen(){
    super();
    
    textSize = height;
    
    bg = color(255);
    panels = new Panel[0];
    
    scrollOffset = 0; // for scrolling
    // must init panels here
  }
  
  float textSize;
  
  Panel[] panels;
  
  NumPad numPad = new NumPad();
  
  int bg;
  
  public void init(){
    init(true);
  }
  
  public void init(boolean resetTextSize){
    // the erbung must do the pos here
    // thrn call this for this v
    
    if(resetTextSize) // numPad is in reset cuz the textSize is static...
      textSize = numPad.getTextSize(height, 1);
      
    for(int i = 0; i < panels.length; i ++){
      textSize = panels[i].getTextSize(textSize, 1);
      
    }
    
    textSize(textSize);
    
  }
  
  public void tick(){
    for(int i = 0; i < panels.length; i ++){
      panels[i].tick();
    }
  }
  
  public void render(){
    background(bg);
    for(int i = panels.length - 1; i >= 0; i --){
      panels[i].render();
    }
  }
  
  public void tickButtons(){
    for(int i = 0; i < panels.length; i ++){
      if(panels[i].tickButton(mouseX, mouseY))
        return;
    }
    
  }
  
  
  // for scrolling...
  
  float scrollOffset;
  float lastY;
  
  @Override
  public void tickFirstPress(){
    super.tickFirstPress();
    
    lastY = mouseY;
    
  }
  
  @Override
  public void tickPress(int time){
    super.tickPress(time);
    
    updateScrollOffset();
  }
  
  @Override
  public void tickLastPress(int time){
    super.tickLastPress(time); // <- very important
    
    scrollOffset = updateScrollOffset();
    
  }
  
  public float updateScrollOffset(){
    return updateScrollOffset(scrollOffset + lastY - mouseY);
  }
  
  public float updateScrollOffset(float scroll){
    float rV = cutDown(scroll, 0, getAbsHeight());
    for(int i = 0; i < panels.length; i ++){
      panels[i].setScrollOffset(rV);
      
    }
    return rV;
  }
  
  
  
  // api now.....................
  
  public float getAbsHeight(){
    return panels.length * yUniversalSize - height;
  }
  
  public int getInd(Panel p){
    int i = 0;
    while(i < panels.length){
      if(panels[i] == p)
        return i;
      i ++;
    }
    return -1;
  }
  
}


public class PosSize {
  
  
  public PosSize(){
    end = millis();
    
  }
  
  float yOffset;
  
  float xPos, yPos, xSize, ySize;
  
  float xOldPos, yOldPos, xOldSize, yOldSize;
  float xNevPos, yNevPos, xNevSize, yNevSize;
  long start, end;
  
  
  
  public void setPosSize(float xP, float yP, float xS, float yS){
    this.xPos = this.xOldPos = this.xNevPos = xP;
    this.yPos = this.xOldPos = this.yNevPos = yP;
    this.xSize = xS;
    this.ySize = yS;
    
  }
  
  public void setScrollOffset(float off){
    this.yOffset = off;
  }
  
  public void tick(){
    if(millis() >= end){
      this.xPos = this.xNevPos;
      this.yPos = this.yNevPos - this.yOffset;
      return;
    }
    
    float fac = (float) (millis() - start) / (float) (end - start);
    
    this.xPos = xOldPos + (xNevPos - xOldPos) * fac;
    this.yPos = yOldPos + (yNevPos - yOldPos) * fac - yOffset;
    
  }
  
  
  public void setAnimation(int timeLength, float xP, float yP){
    start = millis();
    end = start + timeLength;
    
    this.xOldPos = this.xPos;
    this.yOldPos = this.yPos;
    
    this.xNevPos = xP;
    this.yNevPos = yP;
    
  }
  
  
}

public abstract class Panel extends PosSize {
  
  
  
  
  public float getTextSize(float now, float step){return now;}
  
  
  public abstract void render();
  
  
  public boolean tickButton(float xMouse, float yMouse){
    if(xMouse < xPos)
      return false;
    
    if(yMouse < yPos)
      return false;
    
    if(xMouse > xPos + xSize)
      return false;
    
    if(yMouse > yPos + ySize)
      return false;
    
    return this.tickButton();
  }
  // TODO stop testing if true
  public boolean tickButton() {
    // ButtonExecution
    
    return true;
  }
  
}
