import org.gicentre.utils.gui.*;     // For text input.

String api = "2c94c33b-1dd0-450a-b551-4544775954ae";

int gameSize; //Number of games searched PROLLY NOT NEEDED IF LIST USED

//String mySummoner;//Summoner name
long iD;//summoner id
JSONObject values;// delete?
JSONObject matches;// holds recent matches
long [] matchIDList;
int [] championIdList;
int [] kills;
int [] deaths;
int [] assists;
IntList teamId;

int gameButtonX, gameButtonY, gameButtonWidth, gameButtonHeight, champButtonX, champButtonY, champButtonWidth, champButtonHeight, buttonWidth, buttonHeight, buttonX, buttonY ;
//For the text input
TextInput summonerInput;
TextInput regionInput;
String region;
PFont font;
boolean isFinished;
int pageNumber;
int cGN;
JSONObject position;
Table [] matchTable;
//Table dTable;


float minLng, maxLng, minLat, maxLat;
PImage summonerRiftImage;
PImage backgroundImage; // background image
PImage heatmapBrush; // radial gradient used as a brush. Only the blue channel is used.
PImage heatmapColors; // single line bmp containing the color gradient for the finished heatmap, from cold to hot
PImage clickmapBrush; // bmp of the little marks used in the clickmap
PImage gradientMap; // canvas for the intermediate map
PImage heatmap; // canvas for the heatmap
PImage clickmap; // canvas for the clickmap
float maxValue = 0; // variable storing the current maximum value in the gradientMap
boolean hasRun;
int getGame;
int currentGame;
PImage championImage;

void setup()
{
  size (828, 512);

  buttonWidth = 80;
  buttonHeight = 30;
  buttonX = width/2;
  buttonY = 180;

  font = createFont("Serif", 32);
  gameSize = 10;
  hasRun = false;
  matchIDList = new long [gameSize];
  kills = new int [gameSize];
  assists = new int [gameSize];
  deaths = new int [gameSize];
  championIdList = new int [gameSize];
  teamId = new IntList();

  pageNumber = 0;
  
  summonerInput = new TextInput(this, font, 32);
  isFinished = false;

  //Values for rift map min max co  ords
  minLng = -120;    
  maxLng = 14870;   
  minLat = 14980;
  maxLat = -120;

  //Button values
  gameButtonX = 520;
  gameButtonY = 46;
  gameButtonWidth = 300;
  gameButtonHeight = 45;
  champButtonX = 10;
  champButtonY = 46;
  champButtonWidth = 140;
  champButtonHeight = 45;

  heatmapColors = loadImage("heatmapColors.png");
  heatmapBrush = loadImage("heatmapBrush2.png");
  clickmapBrush = loadImage("clickmapBrush.png");
  summonerRiftImage = loadImage("map11.png");
  clickmap = createImage(summonerRiftImage.width, summonerRiftImage.height, ARGB);
  gradientMap = createImage(summonerRiftImage.width, summonerRiftImage.height, ARGB);
  heatmap = createImage(summonerRiftImage.width, summonerRiftImage.height, ARGB);
  gradientMap.loadPixels();
  for (int i=0; i<gradientMap.pixels.length; i++) {
    gradientMap.pixels[i] = 0;
  }
  heatmap.loadPixels();
  heatmapBrush.loadPixels();
  heatmapColors.loadPixels();
  currentGame =10;
}

void draw()
{

  background (255, 255, 255);
  noStroke();
  //First page shown is region select page
  if (pageNumber == 0)
  {
    regionPage();
  } 
  //second page is summoner name input page
  else if (pageNumber ==1)
  {
    startPage();
  } 
  //runs query to fetch recent matches played using summonername and region provded
  else if (pageNumber ==2)
  {
    doQuery(summonerInput.getText(), region);
    if (cGN == 0)
    {
      pageNumber = 4;
      errorPage();
    } else if (cGN > 1) {

      if (hasRun == false) {
        matchTable = new Table[cGN];
        UI(10);

        hasRun = true;
        pageNumber=3;
      }
    }
  } 
  //Creates viewable UI. pulls detailed match report depending on which button is selected and then displays the heatmap which is updated with these match details.
  else if (pageNumber ==3)
  {
    UI(getGame);
    image(summonerRiftImage, 0, 0);
    tint(255, 255, 255, 132);
    image(heatmap, 0, 0);
    noTint();
    if (currentGame != getGame)
    {

      getMatchStats(getGame);
      currentGame = getGame;
    }
  }
  noLoop();
}



void keyPressed()
{
  //Summoner names are greater then 3 characters and less than 16
  if (((key == RETURN) || (key == ENTER)) && pageNumber == 1 && ((summonerInput.getText().length() > 3) && (summonerInput.getText().length() < 16)))
  {
    pageNumber = 2;
  } else if (((key == RETURN) || (key == ENTER)) && pageNumber == 1 && ((summonerInput.getText().length() < 3 || summonerInput.getText().length() > 16)))
  {
    println("badname");
  } //doesnt allow spaces to be used in summoner names
  else if (key == ' ')
  {
  } else if (pageNumber == 1)
  {
    summonerInput.keyPressed();
  }
  loop();
}

void mousePressed()
{
  //EUW BUTTON
  if (pageNumber == 0 && ((mouseX > buttonX-15-buttonWidth*2) && mouseX < (buttonX-15-buttonWidth)) && ((mouseY > buttonY) && (mouseY <buttonY+buttonHeight)))
  {
    region = "euw";
    pageNumber =1;
  }
  //NA BUTTON
  else if (pageNumber == 0 && ((mouseX > buttonX-5-buttonWidth) && mouseX < (buttonX-5)) && ((mouseY > buttonY) && (mouseY <buttonY+buttonHeight)))
  {
    region = "NA";
    pageNumber =1;
  }
  //EUNE BUTTON
  else if (pageNumber == 0 && ((mouseX > buttonX+5) && mouseX < (buttonX+buttonWidth+5)) && ((mouseY > buttonY) && (mouseY <buttonY+buttonHeight)))
  {
    region = "EUNE";
    pageNumber =1;
  }
  //KR BUTTON
  else if (pageNumber == 0 && ((mouseX > buttonX+15+buttonWidth) && mouseX < (buttonX+15+buttonWidth*2)) && ((mouseY > buttonY) && (mouseY <buttonY+buttonHeight)))
  {
    region = "KR";
    pageNumber =1;
  }
  //Checks if the Game buttons on the right have been clicked and depending on the one clicked change which game should be called next.
  else if (pageNumber == 3 && mouseX > gameButtonX && mouseX < gameButtonX+gameButtonWidth)
  {
    if (cGN>0 && (mouseY > gameButtonY) && (mouseY < gameButtonY+gameButtonHeight))
    {
      getGame = 0;
    }
    if (cGN>1 && (mouseY > gameButtonY*2) && (mouseY < gameButtonY*2+gameButtonHeight))
    {
      getGame = 1;
    }
    if (cGN>2 && (mouseY > gameButtonY*3) && (mouseY < gameButtonY*3+gameButtonHeight))
    {
      getGame = 2;
    }
    if (cGN>3 && (mouseY > gameButtonY*4) && (mouseY < gameButtonY*4+gameButtonHeight))
    {
      getGame = 3;
    }
    if (cGN>4 && (mouseY > gameButtonY*5) && (mouseY < gameButtonY*5+gameButtonHeight))
    {
      getGame = 4;
    }
    if (cGN>5 &&(mouseY > gameButtonY*6) && (mouseY < gameButtonY*6+gameButtonHeight))
    {
      getGame = 5;
    }
    if (cGN>6 && (mouseY > gameButtonY*7) && (mouseY < gameButtonY*7+gameButtonHeight))
    {
      getGame = 6;
    }
    if (cGN>7 && (mouseY > gameButtonY*8) && (mouseY < gameButtonY*8+gameButtonHeight))
    {
      getGame = 7;
    }
    if (cGN>8 && (mouseY > gameButtonY*9) && (mouseY < gameButtonY*9+gameButtonHeight))
    {
      getGame = 8;
    }
    if (cGN>9 && (mouseY > gameButtonY*10) && (mouseY < gameButtonY*10+gameButtonHeight))
    {
      getGame = 9;
    }
  }
  else if (pageNumber == 4)
  {
   pageNumber = 0; 
  }
  loop();
}

//drawToGradient and updateHeatmap methods are taken from http://philippseifried.com/blog/2011/09/30/generating-heatmaps-from-code/.
//Heatmap code created by Philipp Seifried and has provided an open licence for anyone to reuse and modify his code
void drawToGradient(int x, int y)
{
  // find the top left corner coordinates on the target image
  int startX = x-heatmapBrush.width/2;
  int startY = y-heatmapBrush.height/2;

  for (int py = 0; py < heatmapBrush.height; py++)
  {
    for (int px = 0; px < heatmapBrush.width; px++) 
    {
      // for every pixel in the heatmapBrush:

      // find the corresponding coordinates on the gradient map:
      int hmX = startX+px;
      int hmY = startY+py;
      /*
      The next if-clause checks if we're out of bounds and skips to the next pixel if so.
       
       Note that you'd typically optimize by performing clipping outside of the for loops!
       */
      if (hmX < 0 || hmY < 0 || hmX >= gradientMap.width || hmY >= gradientMap.height)
      {
        continue;
      }

      // get the color of the heatmapBrush image at the current pixel.
      int col = heatmapBrush.pixels[py*heatmapBrush.width+px]; // The py*heatmapBrush.width+px part would normally also be optimized by just incrementing the index.
      col = col & 0xff; // This eliminates any part of the heatmapBrush outside of the blue color channel (0xff is the same as 0x0000ff)

      // find the corresponding pixel image on the gradient map:
      int gmIndex = hmY*gradientMap.width+hmX;

      if (gradientMap.pixels[gmIndex] < 0xffffff-col) // sanity check to make sure the gradient map isn't "saturated" at this pixel. This would take some 65535 clicks on the same pixel to happen. :)
      {
        gradientMap.pixels[gmIndex] += col; // additive blending in our 24-bit world: just add one value to the other.
        if (gradientMap.pixels[gmIndex] > maxValue) // We're keeping track of the maximum pixel value on the gradient map, so that the heatmap image can display relative click densities (scroll down to updateHeatmap() for more)
        {
          maxValue = gradientMap.pixels[gmIndex];
        }
      }
    }
  }
  gradientMap.updatePixels();
}

/*
Updates the heatmap from the gradient map.
 */
void updateHeatmap()
{
  // for all pixels in the gradient:
  for (int i=0; i<gradientMap.pixels.length; i++)
  {
    // get the pixel's value. Note that we're not extracting any channels, we're just treating the pixel value as one big integer.
    // cast to float is done to avoid integer division when dividing by the maximum value.
    float gmValue = gradientMap.pixels[i];

    // color map the value. gmValue/maxValue normalizes the pixel from 0...1, the rest is just mapping to an index in the heatmapColors data.
    int colIndex = (int) ((gmValue/maxValue)*(heatmapColors.pixels.length-1));
    int col = heatmapColors.pixels[colIndex];

    // update the heatmap at the corresponding position
    heatmap.pixels[i] = col;
  }
  // load the updated pixel data into the PImage.
  heatmap.updatePixels();
}