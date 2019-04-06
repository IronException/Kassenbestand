


//Sum sum;


int animationLen = 500;
float yUniversalSize = height / 6.0;
int smallPress = 200;

int normalFrameCol = 250;
int blackFrameCol = 50;

float xPosOffset;

String maxSumTxt = "1000,00 €";
String maxSectionTxt = "100,00 €";
String maxAmountTxt = "100";
String maxCoinTxt = "10,00 €";

void settings(){
  size(displayWidth, displayHeight);
}

void setup(){
  
  yUniversalSize = height / 6.0;
  xPosOffset = width / 16.0;
  
  String[] data = new String[]{
    "Scheine[{(5 €:500:0, 10 €:1000:1, 20 €:2000:0, 50 €:5000:0, 100 €:10000:0",
    "Münzen[{(1 ct:1:50, 2 ct:2:0, 5 ct:5:0, 10 ct:10:0, 20 ct:20:0, 50 ct:50:0, 1 €:100:0, 2 €:200:0",
    "Rollen[{(10 ct Rollen:400:0, 20 ct Rollen:800:57, 50 ct Rollen:2000:0, 1 € Rollen:2500:0, 2 € Rollen:5000:0"
    
  };
  
  Section[] secs = new Section[data.length];
  for(int i = 0; i < data.length; i ++){
    
    secs[i] = new Section(data[i]);
  }
  
  Sum sum = new Sum(secs);
  
  
  
  
  useProc(new SectionScreen(sum));
  
  
  stroke(50);
}


void draw(){
  
  useProc.drawHelper();
  
  
}


public String makeCurrency(int value){
  
  //if(value % 100 == 0)
    //return (value / 100) + " €";
  
  int after = value % 100;
  int first = (value - after) / 100;
  
  String a = after + "";
  if(a.length() == 1){
    a += "0";
  }
  
  return first + "," + a + " €";
}


public float cutDown(float x, float min, float max){
  
  if(x < min)
    return min;
  
  if(max < min)
    max = min;
    
  if(x > max)
    return max;
  
  return x;
}