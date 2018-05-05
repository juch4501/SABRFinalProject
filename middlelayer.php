<?php

// Create connection
$con=mysqli_connect("localhost","root","lol","lahman2016");

// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
// SQL Queries

//$fname = mysqli_real_escape_string($con, $_GET['FN']);
$fname = $_GET['FN'];
$lname = $_GET['LN'];
$yr = $_GET['YR'];
$sql;
//$lname = mysqli_real_escape_string($con, $_GET['LN']);
//$sql = "SELECT * FROM location where FirstName = '$fname'";
if ($yr == 2013){
  $sql = "select nameFirst, nameLast, teamID, (IFNULL((IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),
  1)/((PO + A) - E)), (((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)))) as RCPPS, IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),1) as RC, ((PO + A) - E) as RP from AllStats
  where nameFirst = '$fname' and nameLast = '$lname' and yearID = '$yr'";
}
elseif ($yr == 2014){
  $sql = "select nameFirst, nameLast, teamID, (IFNULL((IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),
  1)/((PO + A) - E)), (((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)))) as RCPPS, IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),1) as R, ((PO + A) - E) as RPfrom AllStats
  where nameFirst = '$fname' and nameLast = '$lname' and yearID = '$yr'";
}

elseif ($yr == 2015){
  $sql = "select nameFirst, nameLast, teamID, (IFNULL((IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),
  1)/((PO + A) - E)), (((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)))) as RCPPS, IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),1) as RC, ((PO + A) - E) as RP from AllStats
  where nameFirst = '$fname' and nameLast = '$lname' and yearID = '$yr'";
}

elseif ($yr == 2016){
  $sql = "select nameFirst, nameLast, teamID, (IFNULL((IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),
  1)/((PO + A) - E)), (((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)))) as RCPPS, IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),1) as RC, ((PO + A) - E) as RP from AllStats
  where nameFirst = '$fname' and nameLast = '$lname' and yearID = '$yr'";
}

elseif ($yr == 2017){
  $sql = "select nameFirst, nameLast, teamID, (IFNULL((IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),
  1)/((PO + A) - E)), (((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)))) as RCPPS, IFNULL((((H+`2B`+(`3B`*2)+(HR*3))*((H+BB+HBP)-CS - GIDP))/(AB+BB)),1) as RC, ((PO + A) - E) as RP from AllStats
  where nameFirst = '$fname' and nameLast = '$lname' and yearID = '$yr'";
}

// Check if there are results
if ($result = mysqli_query($con, $sql))
{
  // Hold Data
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
else{
  $resultArray = array(["nameFirst" => "Null", "nameLast" => "Null","teamID" => "Null","RCPPS" => "Null","RC" => "Null","RP" => "Null"]);
  // Finally, encode the array to JSON and output the results
  echo json_encode($resultArray);
}
// Close connections
mysqli_close($con);
?>
