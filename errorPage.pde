//Page shown if incorrect summoner or region is inputted.
void errorPage()
{
       fill(17,43,115);
      rect(0,0,width,height/3*2);
      
     textSize(26); 
  fill(0, 0, 0);
  textAlign(CENTER,BOTTOM);
  text("Choose a different Region or Summoner",width/2,150);
}