<?php
// ปิดการแสดง error
error_reporting(0);
ini_set('display_errors', 0);

header('Content-Type: application/json; charset=utf-8');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// จัดการ preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// เชื่อมต่อฐานข้อมูล
require_once 'condb.php';

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        echo json_encode([
            "success" => false,
            "message" => "Method not allowed"
        ]);
        exit;
    }

    // รับข้อมูลจาก Client
    $data = json_decode(file_get_contents("php://input"), true);

    // ตรวจสอบว่า JSON ถูกต้องหรือไม่
    if (json_last_error() !== JSON_ERROR_NONE) {
        echo json_encode([
            "success" => false,
            "message" => "Invalid JSON format"
        ]);
        exit;
    }

    // ตรวจสอบค่าที่จำเป็น
    if (empty($data['username']) || empty($data['password'])) {
        echo json_encode([
            "success" => false,
            "message" => "กรุณากรอกชื่อผู้ใช้และรหัสผ่าน"
        ]);
        exit;
    }

    $username = $data['username'];
    $password = $data['password'];

    // ค้นหาผู้ใช้จากฐานข้อมูล
    $stmt = $conn->prepare("SELECT customer_id, firstName, lastName, username, password 
                           FROM customers 
                           WHERE username = :username");
    $stmt->bindParam(':username', $username);
    $stmt->execute();

    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user['password'])) {
        // ✅ Login สำเร็จ
        echo json_encode([
            "success" => true,
            "message" => "เข้าสู่ระบบสำเร็จ",
            "customer_id" => $user['customer_id'],
            "username" => $user['username'],
            "firstName" => $user['firstName'],
            "lastName" => $user['lastName']
        ]);
    } else {
        // ❌ Login ไม่สำเร็จ
        echo json_encode([
            "success" => false,
            "message" => "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"
        ]);
    }

} catch (PDOException $e) {
    echo json_encode([
        "success" => false,
        "message" => "เกิดข้อผิดพลาด: " . $e->getMessage()
    ]);
}
?>