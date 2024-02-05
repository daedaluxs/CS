<?php
require_once('sql_conn.php');

$id = preg_replace( '/[^0-9]/', '', $_POST["id"] );

if(strlen($id) > 0){
    $query = "DELETE FROM flights WHERE id='$id'";

    $response = @mysqli_query($dbc, $query);
    echo "<br> Successfully Deleted Records of ID $id";
}
else{
    echo "<br> Deletion Failed No Valid Input";
}


?>
<html>
<body>
<br>
<a href="index.php">Home</a> 
</body>
</html>