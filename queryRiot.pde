//Uses the summoner and region provided on first two pages to query riot's api for recent matches played by the summoner. 
//Places these matches and other info such as champion played into lists for later access.
void doQuery (String summonerName, String regionName)
{
 // dTable = new Table();
 // dTable.addColumn("x");
 // dTable.addColumn("y");
  //Gets summoner id
  //summonerName = summonerName.replace(' ', '%');
  JSONObject query;//Query object with summonername, id, level

  try {
    
    query = loadJSONObject ("https://"+regionName+".api.pvp.net/api/lol/"+regionName+"/v1.4/summoner/by-name/"+summonerName+"/?api_key="+api);
    iD = query.getJSONObject(summonerName).getInt("id");
    matches = loadJSONObject ("https://"+regionName+".api.pvp.net/api/lol/"+regionName+"/v1.3/game/by-summoner/"+iD+"/recent?api_key="+api);
     //current game number
    cGN = 0;
    
    //goes through the recent game list looking for rift matches
    for (int m = 0; m< matches.getJSONArray("games").size(); m++)
    {
      //checks game mode is rift
      if ((matches.getJSONArray("games").getJSONObject(m).getString("gameMode")).equals("CLASSIC"))
      {
        teamId.append(matches.getJSONArray("games").getJSONObject(m).getInt("teamId"));
        //JSONArray matchlist = matches.getJSONArray("games"); 
        // for (int i = 0; i<matchIDlist.size(); i++) {
        // JSONObject InMatch = matchlist.getJSONObject(i);

        // long matchID = matchlist.getJSONObject(i).getLong("matchId");
        championIdList [cGN] = matches.getJSONArray("games").getJSONObject(m).getInt("championId");
        kills [cGN] = matches.getJSONArray("games").getJSONObject(m).getJSONObject("stats").getInt("championsKilled");
        deaths [cGN] = matches.getJSONArray("games").getJSONObject(m).getJSONObject("stats").getInt("numDeaths");
        assists [cGN] = matches.getJSONArray("games").getJSONObject(m).getJSONObject("stats").getInt("assists");
      //  println(matches.getJSONArray("games").getJSONObject(m).getJSONObject("stats").getInt("assists"));
        matchIDList [cGN] = matches.getJSONArray("games").getJSONObject(m).getLong("gameId");
        
        //println(matches.getJSONArray("games").getJSONObject(m).getInt("teamId"));
        cGN ++;
      }
    }
  } 
  catch(Exception e) {
    println("choose different summoner name or region");
  } 
}