-- ============================================
-- DATABASE: PW
-- Jalankan file ini di phpMyAdmin tab SQL
-- ============================================

CREATE DATABASE IF NOT EXISTS PW
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE PW;

-- TABEL PRODUK
CREATE TABLE IF NOT EXISTS products (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(150) NOT NULL,
  category   ENUM('bokoran','sokasi','tas') NOT NULL,
  price      INT NOT NULL,
  price_old  INT DEFAULT NULL,
  badge      VARCHAR(50) DEFAULT NULL,
  image_url  VARCHAR(255) NOT NULL,
  rating     DECIMAL(2,1) DEFAULT 0.0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABEL BLOG
CREATE TABLE IF NOT EXISTS blogs (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(255) NOT NULL,
  excerpt     TEXT,
  tag         ENUM('style','tips','trend','news') NOT NULL,
  author      VARCHAR(100) NOT NULL,
  image_url   VARCHAR(255) NOT NULL,
  is_featured TINYINT(1) DEFAULT 0,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABEL TESTIMONI
CREATE TABLE IF NOT EXISTS testimonials (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  city       VARCHAR(100) NOT NULL,
  rating     TINYINT NOT NULL,
  message    TEXT NOT NULL,
  avatar_url VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABEL NEWSLETTER
CREATE TABLE IF NOT EXISTS newsletter_subscribers (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  email         VARCHAR(150) NOT NULL UNIQUE,
  subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- DATA AWAL PRODUK (sesuai asset/ website "Bokor Anyaman")
-- ============================================
INSERT INTO products (name, category, price, price_old, badge, image_url, rating) VALUES
('Bokoran Bulat Penyalin',   'bokoran', 290000, NULL,   'Best Seller', 'asset/bokoran-bulat-penyalin.png', 4.8),
('Bokoran Kotak Penyalin',   'bokoran', 320000, NULL,   NULL,          'asset/bokoran-kotak-penyalin.png', 4.7),
('Bokoran Penyalin Kecil',   'bokoran', 185000, 220000, 'Sale',        'asset/bokoran-penyalin-kecil.png', 4.6),
('Sokasi Bola Besar',        'sokasi',  350000, NULL,   NULL,          'asset/sokasi-bola-besar.png', 4.8),
('Sokasi Bola Kecil',        'sokasi',  220000, NULL,   'New',         'asset/sokasi-bola-kecil.png', 4.7),
('Sokasi Kulit Sintetis',    'sokasi',  260000, NULL,   NULL,          'asset/sokasi-kulit-sintetis.png', 4.5),
('Sokasi Penyalin Kecil',    'sokasi',  185000, 210000, 'Sale',        'asset/sokasi-penyalin-kecil.png', 4.6),
('Tas Aban-aban Finil',      'tas',     150000, NULL,   NULL,          'asset/tas-abanaban-finil.png', 4.5),
('Tas Aban-aban Gold',       'tas',     210000, NULL,   'New',         'asset/tas-abanaban-gold.png', 4.9),
('Tas Aban-aban Silver',     'tas',     195000, NULL,   NULL,          'asset/tas-abanaban-silver.png', 4.7),
('Tas Kwangen Bola',         'tas',     175000, NULL,   NULL,          'asset/tas-kwangen-bola.png', 4.6),
('Tas Set 2 Kerang Bola',    'tas',     280000, 310000, 'Sale',        'asset/tas-set2-kerang-bola.png', 4.8),
('Tas Set 2 Penyalin',       'tas',     240000, NULL,   'Best Seller', 'asset/tas-set2-penyalin.png', 4.9);

-- DATA AWAL TESTIMONI
INSERT INTO testimonials (name, city, rating, message, avatar_url) VALUES
('Sari Dewi',    'Jakarta',    5, 'Kualitas anyamannya rapi banget, cocok buat upacara maupun dekorasi rumah.', 'https://i.pravatar.cc/100?img=5'),
('Mira Kusuma',  'Surabaya',   5, 'Pengiriman cepat dan packaging aman, bokorannya nggak ada yang rusak.', 'https://i.pravatar.cc/100?img=9'),
('Rina Amalia',  'Bandung',    4, 'Sudah 3 kali beli sokasi di sini, kualitasnya konsisten bagus.', 'https://i.pravatar.cc/100?img=25'),
('Ayu Lestari',  'Yogyakarta', 5, 'Tas aban-abannya cantik, detail anyamannya halus dan kuat.', 'https://i.pravatar.cc/100?img=47'),
('Nadia Putri',  'Medan',      5, 'Harga sepadan dengan kualitas, produk kerajinan Bali asli.', 'https://i.pravatar.cc/100?img=20');

-- DATA AWAL BLOG
INSERT INTO blogs (title, excerpt, tag, author, image_url, is_featured) VALUES
('Sejarah dan Makna Bokoran dalam Upacara Bali', 'Mengenal fungsi bokoran dalam tradisi masyarakat Bali.', 'trend', 'Rania S.', 'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?w=900', 1),
('Cara Merawat Anyaman Bambu Agar Tahan Lama',    'Tips menjaga sokasi dan bokoran tetap awet.', 'tips', 'Dira A.', 'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=300', 0),
('Perbedaan Sokasi, Bokoran, dan Tas Anyaman',    'Panduan mengenal jenis-jenis kerajinan anyaman Bali.', 'style', 'Sinta R.', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300', 0),
('Kolaborasi Bersama Pengrajin Anyaman Lokal',    'Kolaborasi eksklusif bersama pengrajin anyaman Bali.', 'news', 'Tim Bokor Anyaman', 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300', 0);
