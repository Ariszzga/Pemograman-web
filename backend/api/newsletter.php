<?php
// backend/api/newsletter.php
require_once '../config/db.php';
 
// Hanya terima method POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['status' => 'error', 'message' => 'Method not allowed']);
    exit;
}
 
// Ambil email dari request
$body  = json_decode(file_get_contents('php://input'), true);
$email = trim($body['email'] ?? '');
 
// Validasi email
if (!$email || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['status' => 'error', 'message' => 'Email tidak valid']);
    exit;
}
 
// Simpan ke database
$stmt = $conn->prepare(
    "INSERT IGNORE INTO newsletter_subscribers (email) VALUES (?)"
);
$stmt->bind_param('s', $email);
 
if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Berhasil subscribe!']);
} else {
    echo json_encode(['status' => 'exists', 'message' => 'Email sudah terdaftar']);
}
$conn->close();
?>