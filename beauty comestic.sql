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