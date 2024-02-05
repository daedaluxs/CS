<!DOCTYPE html>
<html>
<body>
<align ='center'>
<h1><U>Surname and corresponding I.D.</U></h1>
</align>
<?php
$id = array("Gomes"=>"29", 
			"Archer"=>"48", 
			"Johnson"=>"23", 
			"Jackson"=>"61", 
			"Rozario"=>"18");
echo '<br>';
echo "Successfully entered five names and corresponding id";
echo '<br>';
echo "Gomes's id is " . $id['Gomes'] . " .";
echo '<br>';
echo "Johnson's id is " .$id['Johnson']. " .";
?>
</body>
</html>
