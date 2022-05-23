<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("config.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);
$stmt = $conn->prepare("SELECT * FROM tbl_users WHERE user_email = '$email' AND user_pass = '$password'");
$stmt->execute();
$number_of_rows = $stmt->rowCount();
$result = $stmt->setFetchMode(PDO::FETCH_ASSOC);
$rows = $stmt->fetchAll();

if ($number_of_rows  > 0) {
    foreach ($rows as $us) {
        $id = $us['user_id'];
        $useremail = $us['user_email'];
        $username = $us['user_name'];
        $phone = $us['user_phone'];
        $address = $us['user_addr'];
        $datereg = $us['user_datereg'];
    }

    $user['id'] = $id;
    $user['email'] = $useremail;
    $user['name'] = $username;
    $user['phone'] = $phone;
    $user['address'] = $address;
    $user['datereg'] = $datereg;

    $response = array('status' => 'success', 'data' => $user);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
