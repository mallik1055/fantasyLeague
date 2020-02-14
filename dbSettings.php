<?php


$url = parse_url(getenv("CLEARDB_DATABASE_URL"));

$server = $url["host"];
$username = $url["user"];
$password = $url["pass"];
$db = substr($url["path"], 1);

define("db_host",$server);
define("db_user",$username);	
define("db_password",$password);
define("db_name",$db)
  
?>
