

UseProc useProc;

boolean portrait, portraitTested;

public void testPortrait(){
  if(portraitTested){
    return;
  }
  portrait = height >= width;
  
  portraitTested = true;
}

public void useProc(UseProc nev){
  useProc = nev;
  
  testPortrait();
  if(portrait){
      useProc.initP();
    } else {
      useProc.initL();
    }
}


public abstract class UseProc{
  
  
  
  public UseProc(){
    doAfterRender = false;
    doRender = true;
    
    
    
    
    vibrate(); // have it?
    
  }
  
  protected boolean doAfterRender;
  protected boolean doRender;
  
  
  boolean lastPress;
  
  
  
  public void tickButtons(){}
  public void tick(){}
  public void render(){}
  public void initP(){init();}
  public void initL(){init();}
  public void init(){}
  
  
  int buttonStartTime;
  public void tickFirstPress(){buttonStartTime = millis();}
  public void tickPress(int elapsedTime){}
  public void tickLastPress(int totalTime){
    if(totalTime < smallPress){
      tickButtons();
    }
  }
  
  
  
  
  public void doRender(){
    doRender(true);
  }
  
  public void doRender(boolean render){
    this.doRender = render;
  }
  
  public void setDoRender(boolean state){
    doAfterRender = state;
  }
  
  
  
  
  public void drawHelper(){
    
    tick();
    
    if(mousePressed){
      // here is press
      if(!lastPress) {
        // last is false; now is true -> pressbeginn
        
        tickFirstPress();
      }
      tickPress(millis() - buttonStartTime);
      
    } else if(lastPress){
      tickLastPress(millis() - buttonStartTime);
      
      // to know the time between presses
      //buttonTime = millis();
    }
    
    if(doRender){
      render();
      doRender = doAfterRender;
    }
    
    lastPress = mousePressed;
    
  }
  
  
  // TODO remove?
  public void onBackScreen(){
    doRender();
  }
  
  
}


public void vibrate(){
  vibrate(100);
}

public void vibrate(long millis){
  // TODO
}


