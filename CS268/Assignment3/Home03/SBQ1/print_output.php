<?php
// Get a connection for the database
require_once('sql_conn.php');

// Create a query for the database
$query = "SELECT id, origin, destination, duration FROM flights";

// Get a response from the database by sending the connection
// and the query
$response = @mysqli_query($dbc, $query);

// If the query executed properly proceed
if($response){

echo '<table align="left" cellspacing="5" cellpadding="8">
	<tr>
		<td align="left"><b>Flight Id</b></td>
		<td align="left"><b>Flight Origin</b></td>
		<td align="left"><b>Flight Destination</b></td>
		<td align="left"><b>Flight Duration</b></td>
	</tr>';

// mysqli_fetch_array will return a row of data from the query
// until no further data is available
while($row = mysqli_fetch_array($response)){

echo '<tr><td align="left">' . 
$row['id'] . '</td><td align="left">' .
$row['origin'] . '</td><td align="left">' . 
$row['destination'] . '</td><td align="left">' .
$row['duration'] . '</td><td align="left">';

echo '</tr>';
}

echo '</table>';

} else {

echo "Couldn't issue database query<br />";

echo mysqli_error($dbc);

}

// Close connection to the database
mysqli_close($dbc);

?>