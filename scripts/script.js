		
function updateBalance(){
	var i;
	userInfo.balance =100;
	for(i=0;i<userInfo.team.length;i++){
		userInfo.balance-=userInfo.team[i].price;
	}
	document.getElementById("balance").innerHTML = userInfo.balance;
}

function updateComposition(){
	userInfo.composition = {batsman:0,bowler:0,wicketkeeper:0,allrounder:0};
	for(var i=0;i<userInfo.team.length;i++){
		userInfo.composition[userInfo.team[i].role]++;
	}
	if(((userInfo.composition.batsman == 3 && userInfo.composition.wicketkeeper==1 && userInfo.composition.allrounder== 2&& userInfo.composition.bowler==2)
		||(userInfo.composition.batsman == 3 && userInfo.composition.wicketkeeper==1 && userInfo.composition.allrounder== 1&& userInfo.composition.bowler==3)
		||(userInfo.composition.batsman == 4 && userInfo.composition.wicketkeeper==1 && userInfo.composition.allrounder== 1&& userInfo.composition.bowler==2))
		&& userInfo.balance >= 0){
		document.getElementById("team-submit").style.backgroundColor = "#2ec866";
		document.getElementById("team-submit").disabled = false ;
		document.getElementById("team-submit").style.cursor = "pointer";
		//console.log(userInfo.balance);
	}
	else{
		document.getElementById("team-submit").style.backgroundColor = "#555";
		document.getElementById("team-submit").disabled = true;
		document.getElementById("team-submit").style.cursor = 'not-allowed';
	}
	//console.log(userInfo.composition);
	document.getElementById("composition-banner").innerHTML = userInfo.composition.batsman+" BATSMEN "+userInfo.composition.wicketkeeper+" WICKETKEEPER "+userInfo.composition.allrounder+" ALLROUNDER "+userInfo.composition.bowler+" BOWLER";
}

function displayNotif(message){
	var notif =document.createElement('div');
	notif.className = "notification";
	notif.id = "notification";
	notif.innerHTML = message;
	document.body.appendChild(notif);
	$(notif).fadeIn();
	$(notif).fadeOut(4000);

}

function searchTeam(playerId){
	for(var i=0;i<userInfo.team.length;i++){
		if(userInfo.team[i].playerId == playerId){
			return i;
		}
	}
	return -1;
}

function playerInfo(playerId,playerList){
	for(var i=0;i< playerList.length;i++){
		if(playerList[i].playerId == playerId)
			return playerList[i];
	}
	
}
function addToPlayerBox(playerObj){
	var playerRow = document.createElement('div');
	playerRow.className = "player-row";
	playerRow.id= playerObj.playerId;
	var playerAdd =  document.createElement('div');
	playerAdd.className ="player-add";
	
	var playerName =  document.createElement('div');
	playerName.className ="player-name";
	playerName.innerHTML = playerObj.name;
	var playerRole =  document.createElement('div');
	playerRole.className ="player-role";
	playerRole.innerHTML = playerObj.role;
	var playerPrice =  document.createElement('div');
	playerPrice.className ="player-price";
	playerPrice.innerHTML = playerObj.price;
	playerRow.appendChild(playerAdd);
	playerRow.appendChild(playerName);
	playerRow.appendChild(playerRole);
	playerRow.appendChild(playerPrice);
	var playersBox = document.getElementById("players-box");
	playersBox.appendChild(playerRow);
	playerRow.addEventListener("click",function(event){
		userInfo.team.push( playerInfo(parseInt(event.target.parentNode.id) , playerList ) );
		document.getElementById("players-box").removeChild(event.target.parentNode);
		updateBalance();
		updateComposition();
		
		addToTeamBox(playerObj);
	});	
}
function addToTeamBox(playerObj){
	var node = document.createElement('div');
	node.className = "player-profile";
	node.style.backgroundImage = "url("+playerObj.imageUrl+")";
	node.id = playerObj.playerId;
	
	var banner = document.createElement('span');
	banner.className = "heading-banner";
	banner.innerHTML = playerObj.name+"<br>"+playerObj.role+" $"+playerObj.price+"mn";
	banner.style.fontSize = "10px";
	banner.style.backgroundColor="black";
	banner.style.bottom="0px";
	banner.style.right = "0px";
	banner.style.fontSize = "12px";
	banner.style.position = "absolute";
	node.appendChild(banner);
	var removePlayer = document.createElement('img');
	removePlayer.id = "close";
	removePlayer.style.float = "right";
	removePlayer.setAttribute("src","/images/remove.png");
	node.appendChild(removePlayer);
	
	document.getElementById("team-box").appendChild(node);
	removePlayer.addEventListener("click",function(event){
		userInfo.team.splice(searchTeam(event.target.parentNode.id),1);
		updateBalance();
		updateComposition();
		
		document.getElementById('team-box').removeChild(event.target.parentNode);
		addToPlayerBox(playerObj);
	});
}
