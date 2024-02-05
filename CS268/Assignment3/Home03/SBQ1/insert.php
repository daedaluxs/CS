<?php
require_once('sql_conn.php');

 $origin = $_POST["origin"];
 $destination = $_POST["destination"];
 $duration = $_POST["duration"];


$query = "INSERT INTO flights (origin, destination, duration) 
VALUES ('$origin', '$destination', '$duration')";

$response = @mysqli_query($dbc, $query);

echo '<br> Successfully Inserted';

?>
<html>
<body>
<br>
<a href="index.php">Home</a> 
</body>
</html>