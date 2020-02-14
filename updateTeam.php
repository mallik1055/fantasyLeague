<?php
    session_start();
    error_reporting(0);
    header("Access-Control-Allow-Origin:*");
    header("Access-Control-Allow-Methods:POST");    
    require "dbSettings.php";

      
    $con=mysqli_connect(db_host,db_user,db_password,db_name);
    if(mysqli_connect_errno()){
       echo "Could not connect to DB";
       return;
    }
    //$userId = $_POST["userId"];
    $userId = intval($_SESSION["userId"]);
    $method =$_POST["method"];
    $response = new stdClass();

    if($method == "updateTeamname"){    //Update team name only
        $teamname = $_POST["teamname"];
        $sql = "UPDATE user_lines SET teamname = '$teamname' WHERE user_id= $userId ";
        
        if (mysqli_query($con, $sql)) {
            $response->message = "Updated Successfully";
        } 
        else {
            $response->message ="Error Updating!";
            echo json_encode($response);
            return;
        }

    }

    else if($method == "updateTeam"){ //Update team members
        $team = $_POST["team"];
        $balance = $_POST['balance'];

        $sql = "DELETE FROM user_team WHERE user_id=$userId";
        if (mysqli_query($con, $sql)) {
            $response->message ="Updated Successfully";
        } 
        else {
            $response->message ="Error Updating!";
            echo json_encode($response);
            return;
        }

        $sql = "UPDATE user_lines SET balance = $balance WHERE user_id=$userId ";
        if (mysqli_query($con, $sql)) {
            $response->message ="Updated Successfully";
        } 
        else {
            $response->message ="Error Updating!";
            echo json_encode($response);
            return;
        }

        $sql = "UPDATE user_lines SET last_updated_on = now()";
        if (mysqli_query($con, $sql)) {
            $response->message ="Updated Successfully";
        } 
        else {
            $response->message ="Error Updating!";
            echo json_encode($response);
            return;
        }


        for($i=0;$i<count($team);$i++){
            
            $sql = "INSERT INTO user_team VALUES ($userId,".$team[$i].")";
            if (mysqli_query($con, $sql)) {
                $response->message ="Updated Successfully";
            } 
            else {
                $response->message ="Error Updating!";
                echo json_encode($response);
                return;
                
            }

            
        }

    }

    $sql = "SELECT last_updated_on FROM user_lines WHERE user_id = $userId"; //Get last_updated_on column for the user
    $result = mysqli_query($con, $sql);
    $row = mysqli_fetch_assoc($result);
    $response->lastUpdatedOn =$row['last_updated_on'];    
    mysqli_close($con);
    echo json_encode($response);
    
    

    
?>
