-- Création de la base de données AquaPlage
CREATE DATABASE AquaPlage;

-- Utilisation de la base de données AquaPlage
USE AquaPlage;

-- Création de la table Commune
CREATE TABLE Commune (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    code_postal VARCHAR(10) NOT NULL
);

-- Création de la table Plage
CREATE TABLE Plage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    description TEXT,
    commune_id INT,
    adresse1 VARCHAR(255),
    adresse2 VARCHAR(255),
    adresse3 VARCHAR(255),
    conditions_visite TEXT,
    ouverture VARCHAR(255),
    labels VARCHAR(255),
    handicap_acces VARCHAR(255),
    handicap_label VARCHAR(255),
    tarifs TEXT,
    activites TEXT,
    equipements TEXT,
    groupes_acceptees VARCHAR(255),
    animaux_acceptes BOOLEAN,
    url VARCHAR(255),
    FOREIGN KEY (commune_id) REFERENCES Commune(id)
);

-- Création de la table Contact
CREATE TABLE Contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plage_id INT,
    telephone VARCHAR(20),
    telephone_mobile VARCHAR(20),
    telephone_complet VARCHAR(20),
    email VARCHAR(255),
    FOREIGN KEY (plage_id) REFERENCES Plage(id)
);

-- Création de la table Langue
CREATE TABLE Langue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plage_id INT,
    langue_visite VARCHAR(255),
    langue_parlee VARCHAR(255),
    FOREIGN KEY (plage_id) REFERENCES Plage(id)
);

-- Création de la table Service
CREATE TABLE Service (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plage_id INT,
    service VARCHAR(255),
    FOREIGN KEY (plage_id) REFERENCES Plage(id)
);

-- Création de la table Gestion
CREATE TABLE Gestion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plage_id INT,
    gestion_sociale VARCHAR(255),
    FOREIGN KEY (plage_id) REFERENCES Plage(id)
);
