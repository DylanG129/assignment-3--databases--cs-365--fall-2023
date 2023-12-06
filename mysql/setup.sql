DROP DATABASE IF EXISTS student_passwords;


CREATE DATABASE student_passwords;
USE student_passwords;

CREATE USER 'passwords_user'@'localhost' IDENTIFIED BY 'Iamthe1';
GRANT ALL PRIVILEGES ON student_passwords.* TO 'passwords_user'@'localhost';

                                               

DROP TABLE IF EXISTS Passwords;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Websites;

SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('my secret passphrase', 512));
SET @init_vector = RANDOM_BYTES(16);

CREATE TABLE Websites (
                        WebsiteID INT PRIMARY KEY AUTO_INCREMENT,
                        WebsiteName VARCHAR(255) NOT NULL,
                        WebsiteURL VARCHAR(255) NOT NULL
);

CREATE TABLE Users (
                     UserID INT PRIMARY KEY AUTO_INCREMENT,
                     FirstName VARCHAR(255) NOT NULL,
                     LastName VARCHAR(255) NOT NULL,
                     Username VARCHAR(255) NOT NULL,
                     Email VARCHAR(255) NOT NULL
);

CREATE TABLE Passwords (
                         PasswordID INT PRIMARY KEY AUTO_INCREMENT,
                         UserID INT,
                         WebsiteID INT,
                         Password VARBINARY(255) NOT NULL,
                         Comment TEXT,
                         Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (UserID) REFERENCES Users(UserID),
                         FOREIGN KEY (WebsiteID) REFERENCES Websites(WebsiteID)
);
