
public class SectionScreen extends Screen{
  
  public SectionScreen(Sum sum){
    super();
    
    panels = new Panel[1 + sum.sections.length];
    panels[0] = sum;
    for(int i = 0; i < sum.sections.length; i ++){
      panels[i + 1] = sum.sections[i];
    }
    
    
  }
  
  public void init(){
    
    for(int i = 0; i < panels.length; i ++){
      panels[i].setPosSize(0, i * yUniversalSize, width, yUniversalSize);
    }
    
    //panels[1].setAnimation(animationLen, 0, ySize);
    setDoRender(true);
    // todo all the height and pos
    super.init();
  }
  
  
  
  /*
    0 summe
    1 sections..
    
  */
  
  
  public boolean collapse(Section sec, Coin[] coins){
    
    int i = getInd(sec) + 1;
    
    boolean rV = doCollapse(i, coins[0]);
    if(rV){
      this.collapseCoins(i, coins);
    } else {
      this.expandCoins(i, coins);
    }
    
    super.init(false);
    return rV;
  }
  
  public boolean doCollapse(int i, Coin coin){
    if(i >= panels.length)
      return false;
    
    return panels[i] == coin;
  }
  
  
  public void expandCoins(int ind, Coin[] coins){
    Panel[] nev = new Panel[panels.length + coins.length];
    for(int i = 0; i < ind; i ++){
      nev[i] = panels[i];
    }
    
    for(int i = 0; i < coins.length; i ++){
      coins[i].setPosSize(0, ((float) ind - 1.0) * yUniversalSize, (float) width, yUniversalSize);
      coins[i].setAnimation(animationLen, 0, (ind + i) * yUniversalSize);
      
      nev[ind + i] = coins[i];
    }
    
    for(int i = ind; i < panels.length; i ++){
      panels[i].setAnimation(animationLen, 0, (i + coins.length) * yUniversalSize);
      
      nev[i + coins.length] = panels[i];
    }
    
    testCloseNumPad(ind, coins.length);
    
    
    panels = nev;
    
  }
  
  
  public void collapseCoins(int ind, Coin[] coins){
    Panel[] nev = new Panel[panels.length - coins.length];
    for(int i = 0; i < ind; i ++){
      nev[i] = panels[i];
    }
    
    for(int i = ind; i < nev.length; i ++){
      nev[i] = panels[i + coins.length];
      nev[i].setAnimation(animationLen, 0, ((float) i) * yUniversalSize);
      
    }
    
    testCloseNumPad(ind, -coins.length);
    
    panels = nev;
  }
  
  
  
  
  
  public void testCloseNumPad(int operatingI, int change){
    if(!numPad.getState())
      return;
      
      
    
    if(numInd < operatingI)
      return;
    
    // Im rly not sure bout rhis!!!!
    if(numInd + change < operatingI){
      numPad.setState(false);
    }
    
    
    numInd += change;
    
  }
  
  //boolean numPad = false;
  int numInd;
  
  public void enableNumPad(Coin coin){
    int nev = getInd(coin);
    numPad.setState(numInd != nev); // so its disabled if u tap ob the same again
    numInd = nev;
    
  }
  
}


