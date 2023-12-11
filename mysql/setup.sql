DROP USER IF EXISTS 'passwords_user'@'localhost';
CREATE USER 'passwords_user'@'localhost' IDENTIFIED BY 'Iamthe1';

DROP DATABASE IF EXISTS student_passwords;
CREATE DATABASE student_passwords;

GRANT ALL PRIVILEGES ON student_passwords.* TO 'passwords_user'@'localhost';
FLUSH PRIVILEGES;

DROP TABLE IF EXISTS Passwords;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Websites;

SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('Shmooba', 512));
SET @init_vector = RANDOM_BYTES(16);

USE student_passwords;

CREATE TABLE Users (
                     UserID INT PRIMARY KEY AUTO_INCREMENT,
                     FirstName VARCHAR(255) NOT NULL,
                     LastName VARCHAR(255) NOT NULL,
                     Username VARCHAR(255) NOT NULL,
                     Email VARCHAR(255) NOT NULL
);

CREATE TABLE Websites (
                        WebsiteID INT PRIMARY KEY AUTO_INCREMENT,
                        WebsiteName VARCHAR(255) NOT NULL,
                        WebsiteURL VARCHAR(255) NOT NULL
);

CREATE TABLE Passwords (
                         PasswordID INT PRIMARY KEY AUTO_INCREMENT,
                         UserID INT,
                         WebsiteID INT,
                         Password VARBINARY(255) NOT NULL,
                         Comment TEXT,
                         Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
                         FOREIGN KEY (WebsiteID) REFERENCES Websites(WebsiteID) ON DELETE CASCADE
);


INSERT INTO Websites (WebsiteName, WebsiteURL) VALUES
  ('Youtube', 'https://www.youtube.com'),
  ('Google', 'https://www.google.com'),
  ('Twitter','http://www.twitter.com'),
  ('Tiktok','https://www.tiktok.com'),
  ('Twitch','http://www.twitch.tv'),
  ('Quaver','https://www.quavergame.com'),
  ('Steam','http://www.store.steampowered.com'),
  ('Microsoft','https://www.microsoft.com'),
  ('Outlook','http://www.outlook.live.com'),
  ('Spotify','https://www.open.spotify.com');

INSERT INTO Users (FirstName, LastName, Username, Email) VALUES
  ('Toby', 'Amita', 'TobyA21', 'TAmita88@gmail.com'),
  ('Elina', 'Zahi', 'ElinaZ33', 'EZahi42@outlook.com'),
  ('Ember', 'Marjory', 'EmberM28', 'EMajory09@gmail.com'),
  ('Julius', 'Norton', 'JuliusN22', 'JNorton12@gmail.com'),
  ('Rona', 'Alysha', 'RonaA128', 'RAlysha52@yahoo.com'),
  ('Lizzie', 'Emmitt', 'LizzieE23', 'LEmitt73@outlook.com'),
  ('Daniella', 'Aaron', 'DaniellaA5', 'DAaron99@outlook.com'),
  ('Erica', 'Jaz', 'EricaJ12', 'Ejaz48@yahoo.com'),
  ('Cora', 'Rocky', 'CoraR91', 'CRocky71@outlook.com'),
  ('Tiara', 'Riordan', 'TiaraR02', 'TRiordan03@yahoo.com');

INSERT INTO Passwords (UserID, WebsiteID, Password, Comment) VALUES
  (1, 1, AES_ENCRYPT('CoolDogs322', @key_str, @init_vector), 'My youtube addiction'),
  (2, 2, AES_ENCRYPT('YellowKitten426', @key_str, @init_vector), 'My google account'),
  (3, 3, AES_ENCRYPT('Crazyfrog501', @key_str, @init_vector), 'My twitter problem'),
  (4, 4, AES_ENCRYPT('GummyBear092', @key_str, @init_vector), 'shameful tiktok account'),
  (5, 5, AES_ENCRYPT('SweetCaroline111', @key_str, @init_vector), 'catch up on the vtubers'),
  (6, 6, AES_ENCRYPT('RhythmGod129', @key_str, @init_vector), 'look at my states and placement'),
  (7, 7, AES_ENCRYPT('IWillSurvive88', @key_str, @init_vector), 'What is the point of gamestop'),
  (8, 8, AES_ENCRYPT('HMBaby1MTime', @key_str, @init_vector), 'microsoft is slowly taking over'),
  (9, 9, AES_ENCRYPT('D0ntSt0pBel1even', @key_str, @init_vector), 'everyone is using outlook'),
  (10,10, AES_ENCRYPT('ATS1ngleLad1es', @key_str, @init_vector), 'I have an interesting taste in music');

