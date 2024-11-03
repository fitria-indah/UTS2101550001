# WebService
Tugas UTS MATKUL WebService
#### Nama Fitria Indah Mutia Rini
#### NIM : 21.01.55.0001
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
2. Buat folder baru bernama rest_menus di dalam direktori htdocs XAMPP

### 2. Membuat Database
1. Buka php My Admin (http://localhost/phpmyadmin)
2. Buat database baru bernama culinary
3. Pilih database culinary, lalu buka tab SQL
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


![Screenshot 2024-11-03 122204](https://github.com/user-attachments/assets/c7eb74cb-d90e-4cf6-8287-28969bb054cf)



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


