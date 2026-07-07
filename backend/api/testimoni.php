<?php
// backend/api/testimoni.php
require_once '../config/db.php';
 
$result = $conn->query(
    "SELECT * FROM testimonials ORDER BY created_at DESC"
);
$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode(['status' => 'success', 'data' => $data]);
$conn->close();
?>