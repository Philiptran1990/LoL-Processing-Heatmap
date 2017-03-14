//asks for summoner name. code modfified from previous tutorial.
void startPage()
{
    fill(17,43,115);
  rect(0,0,width,height/3*2);
  
  fill(0,0,0);
  textFont(font);
  textAlign(CENTER,BOTTOM);
  text("Type in a summoner",width/2,150);
  
  stroke(204, 102, 0);
  rect(width/2-150, height/3-5, 300, 50);
  
  fill(255, 255, 255);
  summonerInput.draw((width-textWidth(summonerInput.getText()))/2, height/3);  
  noStroke();
}