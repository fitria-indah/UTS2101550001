# WebService
Tugas UTS MATKUL WebService
#### Nama Fitria Indah Mutia Rini
#### NIM : 21.01.55.0001
#### Tujuan : Membuat dan menguji web service REST untuk manajemen cosmetics AlaMutea menggunakan PHP dan MySQL.
#### Tema : Komestik/Comestics
#### Tabel cosmetics AlaMutea
- id (PK)
- name
- brand
- price
- stock
## Deskripsi Tugas
Buatlah Web Service REST untuk sistem manajemen sesuai objek yang ditentukan menggunakan PHP dan MySQL. Web Service harus mendukung operasi CRUD (Create, Read, Update, Delete) dan diuji menggunakan Postman.

## LANGKAH-LANGKAH
### 1. Persiapan Bahan Tools
1. Buka XAMPP lalu klik start pada Apache dan mySQL
2. Buat folder baru bernama comestics di dalam direktori htdocs XAMPP

### 2. Membuat Database
1. Buka php My Admin (http://localhost/phpmyadmin)
2. Buat database baru bernama Beauty Cosmetics
3. Pilih database Beauty Cosmetics, lalu buka tab SQL
4. Jalankan query SQL berikut untuk membuat tabel dan menambahkan data sampel:

   # Cosmetics Database SQL Script

This SQL script creates a `cosmetics` table and inserts some sample data.

## SQL Code

Below is the SQL code to create and populate the `cosmetics` table.

```sql
CREATE TABLE cosmetics (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  brand VARCHAR(255) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL
);

INSERT INTO cosmetics (name, brand, price, stock) VALUES
('Lipstick Matte', 'Maybelline', 100000, 50),
('Foundation', 'Revlon', 150000, 30),
('Mascara', 'L''Oreal', 80000, 20),
('Eyeshadow Palette', 'MAC', 250000, 15);
```

![alt text](https://github.com/user-attachments/assets/c7eb74cb-d90e-4cf6-8287-28969bb054cf?raw=true)

### 3. Membuat file PHP untuk Web Service
1. Buka vs code
2. Buat file baru dan simpan sebagai `comestics.php` di dalam folder `cosmetics`.
3. Salin dan tempel kode berikut dalam `comestics.php`:

```sql
<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$method = $_SERVER['REQUEST_METHOD'];
$request = [];

if (isset($_SERVER['PATH_INFO'])) {
    $request = explode('/', trim($_SERVER['PATH_INFO'], '/'));
}

function getConnection() {
    $host = 'localhost';
    $db = 'database_komestik';
    $user = 'root';
    $pass = ''; // Ganti dengan password MySQL Anda jika ada
    $charset = 'utf8mb4';

    $dsn = "mysql:host=$host;dbname=$db;charset=$charset";
    $options = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    try {
        return new PDO($dsn, $user, $pass, $options);
    } catch (PDOException $e) {
        throw new PDOException($e->getMessage(), (int)$e->getCode());
    }
}

function response($status, $data = NULL) {
    header("HTTP/1.1 " . $status);
    if ($data) {
        echo json_encode($data);
    }
    exit();
}

$db = getConnection();

switch ($method) {
    case 'GET':
        if (!empty($request) && isset($request[0])) {
            // Get specific cosmetic item
            $id = $request[0];
            $stmt = $db->prepare("SELECT * FROM cosmetics WHERE id = ?");
            $stmt->execute([$id]);
            $item = $stmt->fetch();
            if ($item) {
                response(200, $item);
            } else {
                response(404, ["message" => "Item not found"]);
            }
        } else {
            // Get all cosmetic items
            $stmt = $db->query("SELECT * FROM cosmetics");
            $items = $stmt->fetchAll();
            response(200, $items);
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));
        if (!isset($data->name, $data->brand, $data->price, $data->stock)) {
            response(400, ["message" => "Invalid input"]);
        }
        $sql = "INSERT INTO cosmetics (name, brand, price, stock) VALUES (?, ?, ?, ?)";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$data->name, $data->brand, $data->price, $data->stock])) {
            response(201, ["message" => "Item created", "id" => $db->lastInsertId()]);
        } else {
            response(500, ["message" => "Failed to create item"]);
        }
        break;

    case 'PUT':
        if (empty($request) || !isset($request[0])) {
            response(400, ["message" => "Item ID is required"]);
        }
        $id = $request[0];
        $data = json_decode(file_get_contents("php://input"));
        if (!isset($data->name, $data->brand, $data->price, $data->stock)) {
            response(400, ["message" => "Invalid input"]);
        }
        $sql = "UPDATE cosmetics SET name = ?, brand = ?, price = ?, stock = ? WHERE id = ?";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$data->name, $data->brand, $data->price, $data->stock, $id])) {
            response(200, ["message" => "Item updated"]);
        } else {
            response(500, ["message" => "Failed to update item"]);
        }
        break;

    case 'DELETE':
        if (empty($request) || !isset($request[0])) {
            response(400, ["message" => "Item ID is required"]);
        }
        $id = $request[0];
        $sql = "DELETE FROM cosmetics WHERE id = ?";
        $stmt = $db->prepare($sql);
        if ($stmt->execute([$id])) {
            response(200, ["message" => "Item deleted"]);
        } else {
            response(500, ["message" => "Failed to delete item"]);
        }
        break;

    default:
        response(405, ["message" => "Method not allowed"]);
        break;
}
?>
```
### 4. Pengujian dengan Postman
#### *GET* `/api/[objek]`

 Menampilkan semua data

Method: GET
URL: http://localhost/comestic/comestic.php

Klik *"Send"*

### CONTOH PUNYA SAYA
http://localhost/comestic/comestic.php

![image](https://github.com/user-attachments/assets/12ce487f-5be7-48ec-8f91-780a5340b33e)

#### *GET* `/api/[objek]/{id}`
 Menampilkan detail data berdasarkan ID

Method: GET
URL: http://localhost/comestic/comestic.php/3

Klik *"Send"*

![image](https://github.com/user-attachments/assets/62409a86-c67f-47b8-8e9c-d8b16778098f)


### *POST* `/api/[objek]`
A. Menambah data baru

- Method: POST
- URL: http://localhost/comestic/comestic.php
- Headers:
  - Key: Content-Type
  - Value: application/json
- Body :
    - Pilih "raw" dan "JSON"
Masukkan:
```sql
{
    "id": 5,
    "name": "Makeup Remover",
    "brand": "SoftTouch",
    "price": "40000.00",
    "stock": 20
}
```
- Klik *SEND*
![image](https://github.com/user-attachments/assets/17010b98-4278-427e-be37-a81460cd8156)

B. Validasi Input

- Method: POST
- URL: http://localhost/comestic/comestic.php
- Headers:
   - Key: Content-Type
    - Value: application/json
- Body:
     - Pilih "raw" dan "JSON"
Masukkan:
```sql
{
    "id": 5,
    "name": "Makeup Remover",
    "brand": "SoftTouch",
    "price": "40000.00",
    "stock": 20
}
```
- Klik *"Send"*
- Akan menghasilkan eror karena category tidak valid/tidak diisi

### PUT `/api/[objek]/{id}`
Mengupdate data berdasarkan ID
- Method: PUT
- URL: http://localhost/comestic/comestic.php/3 (asumsikan ID menus baru adalah 3)
- Headers:
   - Key: Content-Type
   - Value: application/json
- Body:
   - Pilih "raw" dan "JSON"
Masukkan :
dari produk ID `3` 
```sql
{
    "id": 3,
    "name": "Neutrogena Hydro Boost Water Gel",
    "brand": "Glad2Glow",
    "price": "80000.00",
    "stock": 20
}
```
menjadi 👇 👇 👇 

```sql
{
    "id": 5,
    "name": "Noola Dew Moisturizer",
    "brand": "Glad2Glow",
    "price": "30000.00",
    "stock": 20
}
```
KLIK "SEND"
![image](https://github.com/user-attachments/assets/8c8b2774-480a-48b8-a0fb-3d6de18f9527)


### DELETE `/api/[objek]/{id}`

Menghapus data berdasarkan ID

- Method: DELETE
- URL: http://localhost/comestic/comestic.php/8 (untuk menghapus data item komestik dengan ID 8)
- Klik "Send"
![image](https://github.com/user-attachments/assets/c51d8cbd-f1cc-4d4f-bdda-8b5f26d4a2dd)


### Spesifikasi Teknis

#### 1. Database
- Buat 1 tabel sesuai dengan struktur yang telah ditentukan
- Gunakan tipe data yang sesuai untuk setiap kolom
- ID menggunakan auto_increment

#### 2. Endpoint API
Implementasikan endpoint berikut:

1. *GET* /api/[objek]
   - Menampilkan semua data
   - Mendukung pencarian berdasarkan nama/title

2. *GET* /api/[objek]/{id}
   - Menampilkan detail data berdasarkan ID
   - Response 404 jika data tidak ditemukan

3. *POST* /api/[objek]
   - Menambah data baru
   - Validasi input
   - Response 201 jika berhasil

4. *PUT* /api/[objek]/{id}
   - Mengupdate data berdasarkan ID
   - Validasi input
   - Response 404 jika data tidak ditemukan

5. *DELETE* /api/[objek]/{id}
   - Menghapus data berdasarkan ID
   - Response 404 jika data tidak ditemukan

### Format Response
json
{
    "status": "success|error",
    "message": "Pesan informatif",
    "data": {
        // Data response
    }
}

