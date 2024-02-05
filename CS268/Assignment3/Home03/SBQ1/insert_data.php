<?php

// Create a query for the database


// Get a response from the database by sending the connection
// and the query
   if( $_GET["origin"] && $_GET["destination"] && $_GET["duration"] ) {
      echo "Welcome ". $_GET['name']. "<br />";
      echo "You are ". $_GET['age']. " years old.";
      
      exit();
   }
?>

<html>
<body>
<form action="insert.php" method="post">
<h1><p align ='center'><u>ENTER DETAILS</u></p></h1><br><br>
<h2><b>Enter your origin: </b><input type="text" name="origin" required><br><br>
<b>Enter your destination: </b><input type = "text" name="destination" required><br><br>
<b>Enter your duration: </b><input type = "text" name="duration" required><br><br>
<input type ="submit">
</h2>
</form>
</body>
</html>
