<?php
	class player{
		function __construct(){
			$this->playerId = 0 ;
			$this->name = "" ;
			$this->price = 0 ;
			$this->role ="";
			
		}
	}

	class user{
		function __construct($id){
			$this->userId =$id;
			$this->username = "";
			$this->teamName ="" ;
			$this->team = array();
			$this->balance = 100;
			$this->lastUpdatedOn = null;

		}
		public function getUserInfo(){
				
			$sql = "SELECT * FROM user_lines INNER JOIN user_team ON user_lines.user_id = user_team.user_id WHERE user_lines.user_id = $this->userId ";
			$con=mysqli_connect(db_host,db_user,db_password,"fantasyLeague");
			$result=mysqli_query($con,$sql);
			if (mysqli_connect_errno()) {
	  			echo "Failed to connect to MySQL: " . mysqli_connect_error();
	 		}
			while($row = mysqli_fetch_assoc($result)){
				$this->userId = $row['user_id'];
				$this->username = $row['username'];
				$this->teamName = $row['teamname'];
				array_push( $this->team , getPlayerInfo( intval($row['player_id']) ) );
				$this->lastUpdatedOn = $row['last_updated_on'];
			}
			
		}

	}
	

?>