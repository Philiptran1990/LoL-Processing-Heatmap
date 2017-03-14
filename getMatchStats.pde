//using the list of match ids generated from queryriot this fetches detailed match reports depending on which recent game was selected
//If the game selected has already been pulled then it simply displays the details again rather then using the api
void getMatchStats (int gameNumber)
{

  for (int i=0; i<gradientMap.pixels.length; i++) {
    gradientMap.pixels[i] = 0;
  }


  if (matchTable[gameNumber] == null)
  {
    Table dTable = new Table();
      dTable.addColumn("x");
  dTable.addColumn("y");
    println("getting request");
    JSONObject matchdetails = loadJSONObject("https://"+region+".api.pvp.net/api/lol/"+region+"/v2.2/match/"+matchIDList[gameNumber]+"?includeTimeline=True&api_key="+api);
    JSONArray frames = matchdetails.getJSONObject("timeline").getJSONArray("frames");
    
    JSONArray particpantarr = matchdetails.getJSONArray("participants");
    int userId = 0;
    
    for (int p = 0; p < 10 ; p++)
    {
      if (championIdList[gameNumber] == particpantarr.getJSONObject(p).getInt("championId")){
        //println(particpantarr.getJSONObject(1).getInt("championId"));
      //  println(championIdList[gameNumber]);
      userId = particpantarr.getJSONObject(p).getInt("participantId");
    }
 
    }
    
    for (int i = 1; i<frames.size(); i++) {

      JSONArray eventsdet = frames.getJSONObject(i).getJSONArray("events");
      for (int j = 0; j<eventsdet.size(); j++) {
        String d = "CHAMPION_KILL";
        
        
        // && eventsdet.getJSONObject(j).getInt("victimId") == (iD)
        if (eventsdet.getJSONObject(j).getString("eventType").equals(d) && eventsdet.getJSONObject(j).getInt("victimId") == (userId)) {

          TableRow row = dTable.addRow();
          row.setFloat( "x", eventsdet.getJSONObject(j).getJSONObject("position").getFloat("x"));
          row.setFloat( "y", eventsdet.getJSONObject(j).getJSONObject("position").getFloat("y"));
        }
      }
    }
    matchTable[gameNumber] = dTable;
    for (int row=0; row<dTable.getRowCount(); row++)
    {

      float x = map(dTable.getFloat(row, "x"), minLng, maxLng, 0, 512);
      float y = map(dTable.getFloat(row, "y"), minLat, maxLat, 0, 512);
      drawToGradient((int)x, (int)y);
      updateHeatmap();
      //fill(255, 100, 100);
      //ellipse(x, y, 10, 10);
      image(summonerRiftImage, 0, 0);
      tint(255, 255, 255, 132);
      image(heatmap, 0, 0);
      noTint();
    }
  } else 
  {   
    println("reloading");
    Table dTable = new Table();
      dTable.addColumn("x");
  dTable.addColumn("y");
    dTable = matchTable[gameNumber];
    for (int row=0; row<dTable.getRowCount(); row++)
    {

      float x = map(dTable.getFloat(row, "x"), minLng, maxLng, 0, 512);
      float y = map(dTable.getFloat(row, "y"), minLat, maxLat, 0, 512);
      drawToGradient((int)x, (int)y);
      updateHeatmap();
      image(summonerRiftImage, 0, 0);
      tint(255, 255, 255, 132);
      image(heatmap, 0, 0);
      noTint();
    }
  }
}