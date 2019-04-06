


public class Sum extends Panel{
  
  
  public Sum(Section[] secs){
    sections = secs;
    
  }
  
  public Section[] sections;
  
  
  public float getTextSize(float now, float step){
    float xS = xSize / 2.0;
    now = calcTextSize("Summe: ", now, step, xS, ySize);
    xS -= xPosOffset;
    return calcTextSize(maxSumTxt, now, step, xS, ySize);
  }
  
  public int getSum(){
    int rV = 0;
    for(int i = 0; i < sections.length; i ++){
      rV += sections[i].getSum();
    }
    return rV;
  }
  
  
  
  public void render(){
    fill(67, 177, 57);
    stroke(blackFrameCol);
    rect(xPos, yPos, xSize, ySize);
    
    fill(0);
    String txt = "Summe: ";
    float xP = xPos + xPosOffset;
    float yP = yPos + ySize / 2.0 + (textAscent() - textDescent()) / 2.0;
    text(txt, xP, yP);
    
    txt = makeCurrency(getSum());
    xP = xPos + xSize - textWidth(txt);
    text(txt, xP, yP);
    
  }
  
  
  
  
}


public class Section extends Panel{
  
  
  public void extractData(String data){
    String[] sp = data.split("\\[\\{\\(");
    this.name = sp[0];
    
    sp = sp[1].split(", ");
    this.coins = new Coin[sp.length];
    for(int i = 0; i < sp.length; i ++){
      this.coins[i] = new Coin(sp[i]);
    }
    
  }
  
  public Section(String data){
    extractData(data);
    this.collapsed = true;
  }
  
  String name;
  
  
  
  boolean collapsed;
  
  public Coin[] coins;
  
  public float getTextSize(float now, float step){
    float xS = xSize / 2.0;
    now = calcTextSize(name + ": ", now, step, xS, ySize);
    xS -= xPosOffset;
    return calcTextSize(maxSectionTxt, now, step, xS, ySize);
  }
  
  public int getSum(){
    int rV = 0;
    for(int i = 0; i < coins.length; i ++){
      rV += coins[i].getValue();
    }
    return rV;
  }
  
  
  
  public void render(){
    fill(250);
    stroke(blackFrameCol);
    if(collapsed)
      stroke(normalFrameCol);
    
    rect(xPos, yPos, xSize, ySize);
    
    fill(0);
    String txt = name + ": ";
    float xP = xPos + xPosOffset;
    float yP = yPos + ySize / 2.0 + (textAscent() - textDescent()) / 2.0;
    text(txt, xP, yP);
    
    txt = makeCurrency(getSum());
    xP = xPos + xSize - textWidth(txt);
    text(txt, xP, yP);
    
  }
  
  @Override
  public boolean tickButton(){
    
    // TODO tell screen to add values...
    collapsed = ((SectionScreen) useProc).collapse(this, coins);
    
    return super.tickButton();
  }
  
}


public class Coin extends Panel{
  
  
  public void extractData(String data){
    String[] sp = data.split(":");
    
    name = sp[0];
    value = Integer.parseInt(sp[1]);
    amount = Integer.parseInt(sp[2]);
  }
  
  public Coin(String data){
    extractData(data);
    
  }
  
  
  
  String name;
  int value;
  int amount;
  
  public int getValue(){
    return round(amount * value);
  }
  
  
  public float getTextSize(float now, float step){
    float xS = xSize / 3.0 - 3.0 * xPosOffset;
    now = calcTextSize(maxAmountTxt, now, step, xS, ySize);
    
    xS = xSize / 3.0 + xPosOffset;
    now = calcTextSize(name + ": ", now, step, xS, ySize);
    
    xS = xSize / 3.0 - xPosOffset;
    return calcTextSize(maxCoinTxt, now, step, xS, ySize);
  }
  
  public float getYOff(){
    return xPosOffset * 1.5;
  }
  
  public void render(){
    fill(245);
    stroke(normalFrameCol);
    rect(xPos, yPos, xSize, ySize);
    
    
    float yOff = getYOff();
    stroke(blackFrameCol);
    rect(xPos + xPosOffset, yPos + yOff, xSize / 3.0 - 2.0 * xPosOffset, ySize - 2.0 * yOff);
    
    fill(0);
    String txt = amount + "";
    float xP = xPos + xSize / 3.0 - 1.5 * xPosOffset - textWidth(txt);
    float yP = yPos + ySize / 2.0 + (textAscent() - textDescent()) / 2.0;
    text(txt, xP, yP);
    
    txt = name + ": ";
    xP = xPos + xSize / 3.0;
    text(txt, xP, yP);
    
    txt = makeCurrency(getValue());
    xP = xPos + xSize - textWidth(txt);
    text(txt, xP, yP);
    
  }
  
  
  @Override
  public boolean tickButton(){
    ((SectionScreen) useProc).enableNumPad(this);
    
    return super.tickButton();
  }
  
}


