<?php

// Create connection
$con=mysqli_connect("localhost","root","lol","test");

// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
// SQL Queries
//$fname = mysqli_real_escape_string($con, $_GET['FN']);
$fname = $_GET['FN'];
$lname = $_GET['LN'];
//$lname = mysqli_real_escape_string($con, $_GET['LN']);
//$sql = "SELECT * FROM location where FirstName = '$fname'";
$sql = "SELECT * FROM location";
// Check if there are results
if ($result = mysqli_query($con, $sql))
{
	// If so, then create a results array and a temporary one
	// to hold the data
	$resultArray = array();
	$tempArray = array();

	// Loop through each row in the result set
	while($row = $result->fetch_object())
	{
		// Add each row into our results array
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}

	// Finally, encode the array to JSON and output the results
	echo json_encode($resultArray);
}
// Close connections
mysqli_close($con);
?>
