<?php
// ป้องกันการแสดง error/warning
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
    $method = $_SERVER['REQUEST_METHOD'];

    if ($method == 'POST') {
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
        if (empty($data['firstName']) || empty($data['lastName']) || 
            empty($data['phone']) || empty($data['username']) || 
            empty($data['password'])) {
            echo json_encode([
                "success" => false, 
                "message" => "กรุณากรอกข้อมูลให้ครบถ้วน"
            ]);
            exit;
        }

        // ตรวจสอบว่า username ซ้ำหรือไม่
        $checkStmt = $conn->prepare("SELECT customer_id FROM customers WHERE username = :username");
        $checkStmt->bindParam(':username', $data['username']);
        $checkStmt->execute();
        
        if ($checkStmt->rowCount() > 0) {
            echo json_encode([
                "success" => false, 
                "message" => "ชื่อผู้ใช้นี้ถูกใช้งานแล้ว"
            ]);
            exit;
        }

        // เพิ่มข้อมูลลูกค้าใหม่
        $stmt = $conn->prepare("INSERT INTO customers (firstName, lastName, phone, username, password) 
                               VALUES (:firstName, :lastName, :phone, :username, :password)");
        
        $stmt->bindParam(':firstName', $data['firstName']);
        $stmt->bindParam(':lastName', $data['lastName']);
        $stmt->bindParam(':phone', $data['phone']);
        $stmt->bindParam(':username', $data['username']);
        
        $hashedPassword = password_hash($data['password'], PASSWORD_BCRYPT);
        $stmt->bindParam(':password', $hashedPassword);

        if ($stmt->execute()) {
            echo json_encode([
                "success" => true, 
                "message" => "ลงทะเบียนสำเร็จ!"
            ]);
        } else {
            echo json_encode([
                "success" => false, 
                "message" => "เกิดข้อผิดพลาดในการบันทึกข้อมูล"
            ]);
        }
    } else {
        echo json_encode([
            "success" => false, 
            "message" => "Method not allowed"
        ]);
    }
} catch (PDOException $e) {
    echo json_encode([
        "success" => false, 
        "message" => "เกิดข้อผิดพลาด: " . $e->getMessage()
    ]);
}
?>