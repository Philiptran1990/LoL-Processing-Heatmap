//Checks what region you want. Only EUW KR NA and EUNE are provded though support can be extended to other regions.
void regionPage()
{
  fill(17,43,115);
  rect(0,0,width,height/3*2);
  
  textSize(26); 
  fill(0, 0, 0);
  textAlign(CENTER,BOTTOM);
  text("Select a region",width/2,150);
  

  fill(0,0,0);
  noStroke();
  rect(buttonX-175, buttonY,buttonWidth,buttonHeight); 
  rect(buttonX-85, buttonY,buttonWidth,buttonHeight); 
  rect(buttonX+5, buttonY,buttonWidth,buttonHeight); 
  rect(buttonX+95, buttonY,buttonWidth,buttonHeight); 
 
 textAlign(CENTER,TOP);
  fill(100,170,164);
  text("EUW",buttonX-135,buttonY); 
  text("NA",buttonX-45,buttonY); 
  text("EUNE",buttonX+45,buttonY); 
  text("KR",buttonX+135,buttonY); 
}