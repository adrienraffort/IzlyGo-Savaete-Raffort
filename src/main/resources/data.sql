DROP TABLE IF EXISTS formation;
DROP TABLE IF EXISTS inventaire;
DROP TABLE IF EXISTS tirage;

DROP TABLE IF EXISTS succes;

DROP TABLE IF EXISTS reduction;
DROP TABLE IF EXISTS entreprise;

DROP TABLE IF EXISTS etudiant;
DROP TABLE IF EXISTS challenge;
DROP TABLE IF EXISTS gemme;





CREATE TABLE formation (
  ID INT PRIMARY KEY,
  LIBELLE VARCHAR(250) NOT NULL,
  CHEMIN VARCHAR(250) NOT NULL
);

CREATE TABLE etudiant (
   NUMERO INT PRIMARY KEY,
   NOM VARCHAR(250) NOT NULL,
   PRENOM VARCHAR(250) NOT NULL,
   MAIL VARCHAR(250) NOT NULL,
   FORMATION_ID INT NOT NULL,
   FOREIGN KEY (FORMATION_ID) REFERENCES formation(ID),
   NOMBRE_POINTS INT NOT NULL DEFAULT 0
);

CREATE TABLE gemme (
    ID INT PRIMARY KEY,
    NOM VARCHAR (50) NOT NULL,
    COULEUR VARCHAR (30) NOT NULL,
    PROBA FLOAT NOT NULL,
    PROBA_MIN FLOAT NOT NULL,
    PROBA_MAX FLOAT NOT NULL,
    PERSONNE_MAX INT NOT NULL,
    VALEUR INT NOT NULL,
    CHEMIN_IMAGE VARCHAR(100) NOT NULL
);

CREATE TABLE inventaire
(
    ID INT PRIMARY KEY,
    ID_ETUDIANT INT NOT NULL,
    ID_GEMME    INT NOT NULL,
    QUANTITE    INT NOT NULL DEFAULT 0,
    VALEUR_POINT INT NOT NULL DEFAULT 0,
    VALEUR_EURO INT NOT NULL DEFAULT 0,

    FOREIGN KEY (ID_ETUDIANT) REFERENCES etudiant(NUMERO)
);


CREATE TABLE tirage
(
    ID INT PRIMARY KEY,
    JOUR VARCHAR(30) NOT NULL,
    HEURE INT NOT NULL,
    MINUTE INT NOT NULL,
    ID_GEMME INT NOT NULL,
    NOMBRE_RECUPERE INT NOT NULL,
    LATITUDE FLOAT NOT NULL,
    LONGITUDE FLOAT NOT NULL,
    CHAINE VARCHAR(100) NOT NULL,

    FOREIGN KEY (ID_GEMME) REFERENCES gemme(ID)
);

CREATE TABLE entreprise
(
    ID INT PRIMARY KEY,
    NUM_SIRET INT NOT NULL,
    NOM VARCHAR(100) NOT NULL
);

CREATE TABLE reduction
(
    ID INT PRIMARY KEY,
    POINTS_REQUIS INT NOT NULL,
    ID_ENTREPRISE INT NOT NULL,
    LIBELLE VARCHAR(100) NOT NULL,

    FOREIGN KEY (ID_ENTREPRISE) REFERENCES entreprise(ID)
);

CREATE TABLE challenge
(
    ID INT PRIMARY KEY,
    LIBELLE VARCHAR(200) NOT NULL,
    ID_CHALLENGE_PRECEDENT INT NULL,
    ID_GEMME INT NOT NULL,
    QUANTITE INT NOT NULL,
    TEMPS INT NOT NULL,
    ID_GEMME_RECOMPENSE INT NOT NULL,
    QUANTITE_RECOMPENSE INT NOT NULL,

    FOREIGN KEY (ID_CHALLENGE_PRECEDENT) REFERENCES challenge(ID),
    FOREIGN KEY (ID_GEMME) REFERENCES gemme(ID),
    FOREIGN KEY (ID_GEMME_RECOMPENSE) REFERENCES gemme(ID)
);

CREATE TABLE succes
(
    ID INT PRIMARY KEY,
    ID_ETUDIANT INT NOT NULL,
    ID_CHALLENGE INT NOT NULL,
    ETAT VARCHAR(30) NOT NULL,
    AVANCEMENT INT NOT NULL DEFAULT 0,

    FOREIGN KEY (ID_ETUDIANT) REFERENCES etudiant(NUMERO),
    FOREIGN KEY (ID_CHALLENGE) REFERENCES challenge(ID)
);



INSERT INTO formation (ID, LIBELLE, CHEMIN) VALUES
  (1, 'M1 INFO Groupe 1', 'M1/INFO/1'),
  (2, 'M1 INFO Groupe 2', 'M1/INFO/2');

INSERT INTO etudiant (NUMERO, NOM, PRENOM, MAIL, FORMATION_ID) VALUES
(123, 'RAFFORT', 'Adrien', 'adrien73400@icloud.com', 2),
(456, 'RAFFORT', 'Adrien', 'adrien73400@icloud.com', 2);


INSERT INTO gemme(id, nom, couleur, proba, proba_min, proba_max, personne_max, valeur, CHEMIN_IMAGE) VALUES
(1, 'Rubis', 'E86967', 0.07, 94, 100, 10, 100, 'rubis'), /*TODO 0.07 au lieu de 0.05 en attendant les objets*/
(2, 'Saphir', '80C6F1', 0.1, 84, 93, 20, 80, 'saphir'),
(3, 'Emeraude', '61D6B9', 0.15, 69, 83, 50, 50, 'emeraude'),
(4, 'Améthyste', 'B58CE7', 0.18, 51, 68, 5000, 10, 'amethyste'),
(5, 'Tourmaline', '363F4A', 0.3, 21, 50, 5000, 5, 'tourmaline'),
(6, 'Ambre', 'EAAE7B', 0.2, 1, 20, 5000, 1, 'ambre');



INSERT INTO inventaire(id, id_etudiant, id_gemme, quantite) VALUES
(1, 123, 1, 1),
(2, 123, 2, 2),
(3, 123, 3, 5),
(4, 123, 4, 6),
(5, 123, 5, 6),
(6, 123, 6, 20),

(7,456, 1, 0),
(8, 456, 2, 1),
(9, 456, 3, 8),
(10, 456, 4, 0),
(11, 456, 5, 9),
(12, 456, 6, 11);


INSERT INTO entreprise(id, num_siret, nom) VALUES
(1, 156516, 'Boulangerie La Panière'),
(2, 256272, 'Bar La Flouz');

INSERT INTO reduction(id, points_requis, id_entreprise, libelle) VALUES
(1, 1700, 1, '37% de remise sur les pains aux chocolats'),
(2, 800, 1, 'Un panini offert pour 3 pains achetés'),
(3, 400, 2, '15% sur un large produit de bière');


INSERT INTO challenge(ID, LIBELLE, ID_CHALLENGE_PRECEDENT, ID_GEMME, QUANTITE, TEMPS, ID_GEMME_RECOMPENSE, QUANTITE_RECOMPENSE) VALUES
(1, 'Récupérer 1 rubis', NULL, 1, 1, 10000, 4, 1),
(2, 'Récupérer 10 rubis', 1, 1, 10, 10000, 3, 3),
(3, 'Récupérer 30 rubis', 2, 1, 30, 10000, 2, 3),

(4, 'Récupérer 5 saphirs', NULL, 2, 5, 10000, 3, 1),
(5, 'Récupérer 25 saphirs', 4, 2, 25, 10000, 1, 1),
(6, 'Récupérer 50 saphirs', 5, 2, 50, 10000, 1, 2),

(7, 'Récupérer 10 émeraudes', NULL, 3, 10, 10000, 3, 1),
(8, 'Récupérer 30 émeraudes', 7, 3, 30, 10000, 1, 1),
(9, 'Récupérer 50 émeraudes', 8, 3, 50, 10000, 1, 2),

(10, 'Récupérer 15 améthystes', NULL, 4, 15, 10000, 3, 1),
(11, 'Récupérer 40 améthystes', 10, 4, 40, 10000, 1, 1),
(12, 'Récupérer 75 améthystes', 11, 4, 75, 10000, 1, 2);

INSERT INTO succes(ID, ID_ETUDIANT, ID_CHALLENGE, ETAT, AVANCEMENT) VALUES
(1, 123, 1, 'EN_COURS',0),
(2, 123, 2, 'BLOQUE', 0),
(3, 123, 3, 'BLOQUE', 0),

(4, 123, 4, 'FINI', 5),
(5, 123, 5, 'EN_COURS', 8),
(6, 123, 6, 'BLOQUE', 0),

(7, 123, 7, 'FINI', 10),
(8, 123, 8, 'FINI', 30),
(9, 123, 9, 'EN_COURS', 9),

(10, 123, 10, 'FINI', 15),
(11, 123, 11, 'FINI', 40),
(12, 123, 12, 'TERMINE', 75);