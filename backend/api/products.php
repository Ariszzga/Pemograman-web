<?php
// backend/api/products.php
require_once '../config/db.php';
 
// Ambil semua produk dari database
$result   = $conn->query("SELECT * FROM products ORDER BY created_at DESC");
$products = [];
 
while ($row = $result->fetch_assoc()) {
    $products[] = $row;
}
 
echo json_encode([
    'status' => 'success',
    'total'  => count($products),
    'data'   => $products
]);
 
$conn->close();
?>