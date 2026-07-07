<?php
$conn = new mysqli("localhost", "root", "", "PW");

if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

echo "Database PW berhasil terhubung!";
?>
