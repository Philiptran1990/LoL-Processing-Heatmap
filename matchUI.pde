//creates the viewable UI for the final page
void UI (int cGame)
{
  background(0, 0, 0);
  textSize(16); 
  fill(255, 255, 255);
  textAlign(LEFT, BOTTOM);
  text("Recent Games", gameButtonX+7, 25);
  
  noStroke();
  
  fill(100, 175, 164);
  if (cGame == 0){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 1){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*2, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 2){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*3, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 3){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*4, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 4){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*5, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 5){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*6, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 6){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*7, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 7){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*8, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 8){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*9, gameButtonWidth, gameButtonHeight); 
  fill(100, 175, 164);
  if (cGame == 9){fill(200, 275, 264);}
  rect(gameButtonX, gameButtonY*10, gameButtonWidth, gameButtonHeight); 

  textAlign(CENTER, TOP);
  fill(0, 0, 0);
  //text("1", gameButtonX+gameButtonWidth/2, gameButtonY+gameButtonHeight/2); 
  //text("2", gameButtonX+gameButtonWidth/2, gameButtonY*2+gameButtonHeight/2); 
  //text("3", gameButtonX+gameButtonWidth/2, gameButtonY*3+gameButtonHeight/2); 
  //text("4", gameButtonX+gameButtonWidth/2, gameButtonY*4+gameButtonHeight/2); 
  //text("5", gameButtonX+gameButtonWidth/2, gameButtonY*5+gameButtonHeight/2); 
  //text("6", gameButtonX+gameButtonWidth/2, gameButtonY*6+gameButtonHeight/2); 
  //text("7", gameButtonX+gameButtonWidth/2, gameButtonY*7+gameButtonHeight/2); 
  //text("8", gameButtonX+gameButtonWidth/2, gameButtonY*8+gameButtonHeight/2); 
  //text("9", gameButtonX+gameButtonWidth/2, gameButtonY*9+gameButtonHeight/2); 
  //text("10", gameButtonX+gameButtonWidth/2, gameButtonY*10+gameButtonHeight/2);
  
  //textSize(16); 
  //fill(255, 255, 255);
  //textAlign(LEFT, BOTTOM);
  //text("Select a game", champButtonX+20, 25);
  //fill(100, 175, 164);
  //noStroke();
  //rect(champButtonX, champButtonY, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*2, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*3, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*4, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*5, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*6, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*7, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*8, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*9, champButtonWidth, champButtonHeight); 
  //rect(champButtonX, champButtonY*10, champButtonWidth, champButtonHeight); 

  //textAlign(CENTER, TOP);
  //fill(255, 255, 255);
  //text("1", champButtonX+champButtonWidth/2, champButtonY+champButtonHeight/2); 
  //text("2", champButtonX+champButtonWidth/2, champButtonY*2+champButtonHeight/2); 
  //text("3", champButtonX+champButtonWidth/2, champButtonY*3+champButtonHeight/2); 
  //text("4", champButtonX+champButtonWidth/2, champButtonY*4+champButtonHeight/2); 
  //text("5", champButtonX+champButtonWidth/2, champButtonY*5+champButtonHeight/2); 
  //text("6", champButtonX+champButtonWidth/2, champButtonY*6+champButtonHeight/2); 
  //text("7", champButtonX+champButtonWidth/2, champButtonY*7+champButtonHeight/2); 
  //text("8", champButtonX+champButtonWidth/2, champButtonY*8+champButtonHeight/2); 
  //text("9", champButtonX+champButtonWidth/2, champButtonY*9+champButtonHeight/2); 
  //text("10", champButtonX+champButtonWidth/2, champButtonY*10+champButtonHeight/2);
  
  for (int i = 0; i<cGN;i++)
  {
  JSONObject imageRequestUrl = loadJSONObject ("https://global.api.pvp.net/api/lol/static-data/euw/v1.2/champion/"+championIdList[i]+"?champData=image&api_key="+api);
 // String imageUrl = "http://ddragon.leagueoflegends.com/cdn/6.9.1/img/champion/";
  String championName = imageRequestUrl.getString("name");
  
  championImage = loadImage("/champions/"+championName+"_Square_0.png");
  image(championImage, gameButtonX, gameButtonY*i+gameButtonHeight, 30, 30);
  
    textAlign(CENTER, TOP);
   text(kills[i]+"/"+deaths[i]+"/"+assists[i], gameButtonX+gameButtonWidth/2, gameButtonY*i+gameButtonHeight); 
     textAlign(LEFT, TOP);
  if (teamId.get(i) == 100)
  {
   text("Blue Side", gameButtonX+(gameButtonWidth/4)*3, gameButtonY*i+gameButtonHeight); 
  }
  else
  {
       text("Red Side", gameButtonX+(gameButtonWidth/4)*3, gameButtonY*i+gameButtonHeight);
  }
  }
  
  }