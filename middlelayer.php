<?php

// Create connection
$con=mysqli_connect("localhost","root","lol","lahman2016");

// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
// SQL Queries
$fname = $_GET['FN'];
$lname = $_GET['LN'];
$yr = $_GET['YR'];
//$tb = $_GET['TB'];

/*if($tb == 1)
{

  $sql = "SELECT nameFirst, nameLast, teamID, (IFNULL((IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)), 1)/((PO + A) - E)), (((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)))) as RCPPS, IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),1) as RC, ((PO + A) - E) as RP, bwar, pwar from FullStats where nameFirst = '$fname' and nameLast = '$lname' and yearID = $yr";
}
*/

//if($tb == 2){

    $sql = "SELECT nameFirst, nameLast, teamID, (IFNULL((IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)), 1)/((PO + A) - E)), (((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)))) as RCPPS, IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),1) as RC, ((PO + A) - E) as RP, bwar, pwar from FinalStats2 where nameFirst = '$fname' and nameLast = '$lname' and yearID = $yr";
//}

// Check if there are results
if ($result = mysqli_query($con, $sql))
{

	// If so, then create a results array and a temporary one to hold the data
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
