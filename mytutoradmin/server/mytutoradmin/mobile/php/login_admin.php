<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("config.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);
$stmt = $conn->prepare("SELECT * FROM tbl_admins WHERE admin_email = '$email' AND admin_pass = '$password'");
$stmt->execute();
$number_of_rows = $stmt->rowCount();
$result = $stmt->setFetchMode(PDO::FETCH_ASSOC);
$rows = $stmt->fetchAll();

if ($number_of_rows  > 0) {
    foreach ($rows as $ad) {
        $id = $ad['admin_id'];
        $ademail = $ad['admin_email'];
        $adname = $ad['admin_name'];
        $phone = $ad['admin_phone'];
        $address = $ad['admin_addr'];
        $datereg = $ad['admin_datereg'];
    }

    $admin['id'] = $id;
    $admin['email'] = $ademail;
    $admin['name'] = $adname;
    $admin['phone'] = $phone;
    $admin['address'] = $address;
    $admin['datereg'] = $datereg;

    $response = array('status' => 'success', 'data' => $admin);
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
