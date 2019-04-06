

public float calcTextSize(String txt, float size, float maxDif, float xSize, float ySize){
  if(fits(txt, size, xSize, ySize))
    return size;
  
  float above = size;
  float below = 0;
  float cur;
  while(above - below > maxDif){
    cur = below + (above - below) / 2.0;
    
    if(fits(txt, cur, xSize, ySize)){
      below = cur;
    } else {
      above = cur;
    }
  }
  
  return below;
}

public boolean fits(String txt, float size, float xSize, float ySize){
  textSize(size);
  
  float xS = textWidth(txt);
  if(xS > xSize)
    return false;
  
  float yS = textAscent() + textDescent();
  if(yS > ySize)
    return false;
  return true;
}