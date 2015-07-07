<?php 
	session_start();
	error_reporting(0);
	$_SESSION["userId"] = "1";	// Taken as 1 for GUEST user.
	require "dbSettings.php";
	include_once "model.php";
	

		
	function fetchPlayerList(){		// Fetches details of the user in JSON
		$arrOfPlayerObj = array();
		
		$sql = "SELECT * FROM players";
		$con=mysqli_connect(db_host,db_user,db_password,"fantasyLeague");
		if (mysqli_connect_errno()) {
  			echo "Failed to connect to MySQL: " . mysqli_connect_error();
 		}
		$result=mysqli_query($con,$sql);
		while($row = mysqli_fetch_assoc($result)){
			$player = new player();
			$player->playerId = $row['player_id'];
			$player->name = $row['name'];
			$player->role = $row['role'];
			$player->price = $row['price'];
			$player->imageUrl = $row['image_url'];
			array_push($arrOfPlayerObj,$player);
		}
		return $arrOfPlayerObj;

	}
	function getPlayerInfo($playerId){ //Fetches the player info in JSON for a specified playerId
		$playerList = $GLOBALS['playerList'];

		for($i=0;$i<count($playerList);$i++){
			if($playerList[$i]->playerId == $playerId){
				return $playerList[$i];
			}
		}

	}

	$playerList = fetchPlayerList(); 
	$userInfo = new user(intval($_SESSION['userId']));
	$userInfo->getUserInfo();
	


?>
<html>
	<head>
		<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.css">
 		<link rel = "stylesheet" type = "text/css" href = "/fantasyLeague/css/stylesheet.css">
	</head>
 	<body>
 		<div class = "masthead">
 			<div class = "logo">
 				FANTASY LEAGUE 2015
 			</div>
 			<span class="login-welcome" id = "login-welcome">WELCOME </span>
 		</div>
 		<div class = "wrapper">
 			<div class = "team-name">
 				Team <input id = "teamname-input" value = "" readonly></input>
 				<span style = "float:right;padding:0 10px 0 0">
 					<button class = "submit" id = "teamname-submit">Edit</button>
 				</span>
 			</div>
 			<div class = "balance-box" id = "balance-box">
 				<span class= "heading-banner"> BALANCE($mn)</span>
 				<span id = "balance" style = "line-height:44px;"></span>

 			</div>
 			<div class = "rules-box">
 				<span class= "heading-banner"> RULES</span>
 				<ul>
 					<li>3 batsmen, 1 wicketkeeper, 2 all rounders, 2 bowlers</li>
					<li>3 batsmen, 1 wicketkeeper, 1 all rounders, 3 bowlers</li>
					<li>4 batsmen, 1 wicketkeeper, 1 all rounders, 2 bowlers</li>
				</ul>
 			</div>
 			<div class = "team-box" id = "team-box">
 				 				
 			</div>
 			
 			<div class = "players-box" id ="players-box">
 				<div class = "player-row" style = "color:white;background-color:#434a54;">
 					<div class= 'player-add' style = "opacity:0;"></div>
 					<div class = 'player-name'>NAME</div>
 					<div class = 'player-role'>ROLE</div>
 					<div class = 'player-price'>PRICE</div>
 				</div>
 			</div>
 			<span class = "heading-banner" id = "composition-banner" style = "float:left;width:500px;height:20px;margin-bottom:5px;font-size:18px">
 			</span>
 			<button class = "submit" id = "team-submit"> Save Team</button>
 			<span style ="float:right;color:#4679bd;font-size:15px;">
 				Last updated on : <span id = "last-updated-on"></span>
 			</span>
	

 			
 		</div>
 		<div class="footer">
 			<span style="color:white;">
 				created by mallikarjuna -- mallik.1231@gmail.com
 			</span>

 		</div>
 		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
 		<script src = "/fantasyLeague/scripts/script.js"></script>
 	<script>
 		
 		var playerList = <?php
			echo json_encode($playerList);
		?>;

		var userInfo = <?php
			echo json_encode($userInfo);
		?>;

		updateBalance(); //Display the balance for the first time the user logs in
		updateComposition(); //Dispay the team composition for the first time the user logs in
		document.getElementById("login-welcome").innerHTML+=userInfo.username;	//Display the username
		document.getElementById("teamname-input").setAttribute("value",userInfo.teamName); // Display the teamName
		document.getElementById("last-updated-on").innerHTML = userInfo.lastUpdatedOn;	//Display last_updated_on
		
		for(var i=0;i<playerList.length;i++){	// Traverse through all players
			if(searchTeam(playerList[i].playerId) ==-1) {
				
				addToPlayerBox(playerList[i]);	//Add player to box on RHS
			}
			else{
				addToTeamBox(playerList[i]);	//Add player to block on LHS
			}
		}

		document.getElementById("team-submit").addEventListener("click",function(){ // Add event listener to the SAVE button of team members
			
				document.getElementById("team-submit").innerHTML ="Saving..";
				var xmlhttp;
				//var params = "userId="+userInfo.userId+"&method=updateTeam&balance="+userInfo.balance;
				var params = "method=updateTeam&balance="+userInfo.balance;

				for(var i=0;i<userInfo.team.length;i++){
					params+="&team[]="+userInfo.team[i].playerId;
				}
				if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				}
				else {// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				xmlhttp.open("POST","/fantasyLeague/updateTeam.php",true);
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.onreadystatechange=function(){
					if (xmlhttp.readyState==4 && xmlhttp.status==200){
				    	document.getElementById("team-submit").innerHTML = "Save Team";
				    	var response = JSON.parse(xmlhttp.responseText);
				    	displayNotif(response.message);
				    	if(response.message.search("Error")==-1){
				    		document.getElementById("last-updated-on").innerHTML = response.lastUpdatedOn;
				    		userInfo.lastUpdatedOn = response.lastUpdatedOn;
				    	}
				    }
				}
				
				xmlhttp.send(params);
			
		});

		document.getElementById("teamname-submit").addEventListener("click",function(){ //Add event listeners to the SAVE button of team name
			if(document.getElementById("teamname-input").readOnly == true){
				document.getElementById("teamname-input").readOnly = false;
				document.getElementById("teamname-input").focus();
				//document.getElementById("teamname-input").select();
				document.getElementById("teamname-submit").innerHTML="Save";
			}
			else{			
				document.getElementById("teamname-submit").innerHTML ="Saving..";
				userInfo.teamName = document.getElementById("teamname-input").value;
				var xmlhttp;
				//var params = "userId="+userInfo.userId+"&method=updateTeamname&teamname="+userInfo.teamName;
				var params = "method=updateTeamname&teamname="+userInfo.teamName;
				if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
					xmlhttp=new XMLHttpRequest();
				}
				else {// code for IE6, IE5
					xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				}
				xmlhttp.open("POST","/fantasyLeague/updateTeam.php",true);
				xmlhttp.onreadystatechange=function(){
					if (xmlhttp.readyState==4 && xmlhttp.status==200){
				    	document.getElementById("teamname-submit").innerHTML="Edit";
				    	var response = JSON.parse(xmlhttp.responseText);
				    	displayNotif(response.message);
				    	if(response.message.search("error")==-1){
				    		document.getElementById("last-updated-on").innerHTML = response.lastUpdatedOn;
				    		userInfo.lastUpdatedOn = response.lastUpdatedOn;
				    	}

				    }
				}
				
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.send(params);
				document.getElementById("teamname-input").readOnly = true;

			}

		});
		



		
		 
 	</script>

 	</body>

</html>




