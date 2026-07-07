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
  category   ENUM('atasan','bawahan','outer','dress') NOT NULL,
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
-- DATA AWAL PRODUK
-- ============================================
INSERT INTO products (name, category, price, price_old, badge, image_url, rating) VALUES
('Blouse Linen Premium',  'atasan',  185000, 230000, 'New',
 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500', 4.8),
('Midi Wrap Dress',       'dress',   295000, NULL,   'Best Seller',
 'https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=500', 4.9),
('Oversized Blazer',      'outer',   350000, NULL,   NULL,
 'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=500', 4.7),
('Wide Leg Trousers',     'bawahan', 220000, 280000, 'Sale',
 'https://images.unsplash.com/photo-1594938298603-e8d9b6a2c61b?w=500', 4.6),
('Kemeja Batik Modern',   'atasan',  265000, NULL,   NULL,
 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=500', 4.8),
('Floral Mini Dress',     'dress',   245000, NULL,   'New',
 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?w=500', 4.9),
('Knit Cardigan',         'outer',   195000, NULL,   NULL,
 'https://images.unsplash.com/photo-1548126032-079a0fb0099d?w=500', 4.7),
('Pleated Midi Skirt',    'bawahan', 175000, NULL,   NULL,
 'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=500', 4.5);

-- DATA AWAL TESTIMONI
INSERT INTO testimonials (name, city, rating, message, avatar_url) VALUES
('Sari Dewi',    'Jakarta',    5, 'Kualitas bahannya jauh di atas ekspektasi saya. Blazer yang saya beli terasa premium banget!', 'https://i.pravatar.cc/100?img=5'),
('Mira Kusuma',  'Surabaya',   5, 'Pengiriman cepat banget! Packaging cantik, berasa dapat hadiah.',                              'https://i.pravatar.cc/100?img=9'),
('Rina Amalia',  'Bandung',    4, 'Sudah 3 kali beli dan selalu puas. Size guide-nya akurat!',                                    'https://i.pravatar.cc/100?img=25'),
('Ayu Lestari',  'Yogyakarta', 5, 'Koleksi VESTI selalu bikin kalap. Desainnya timeless tapi tetap modern!',                     'https://i.pravatar.cc/100?img=47'),
('Nadia Putri',  'Medan',      5, 'Harga sepadan kualitas. Produk VESTI melebihi ekspektasi saya. Recommended!',                  'https://i.pravatar.cc/100?img=20');

-- DATA AWAL BLOG
INSERT INTO blogs (title, excerpt, tag, author, image_url, is_featured) VALUES
('Palette Warna yang Mendominasi Fashion 2025', 'Dari earthy tone hingga bold jewel tones.', 'trend', 'Rania S.', 'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?w=900', 1),
('Cara Mix & Match Outfit Monokrom',            'Tips agar tetap stylish dan tidak membosankan.', 'style', 'Dira A.', 'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=300', 0),
('Tips Merawat Baju Berbahan Linen',            'Panduan agar linen tahan lama dan tetap rapi.', 'tips', 'Sinta R.', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300', 0),
('VESTI x Designer Lokal: Kolaborasi Spesial',  'Kolaborasi eksklusif bersama desainer berbakat.', 'news', 'Tim VESTI', 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300', 0);
