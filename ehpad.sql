DROP SCHEMA IF EXISTS ehpad;
CREATE SCHEMA IF NOT EXISTS ehpad DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE ehpad;

CREATE TABLE medicament(
   Id_medicament INT AUTO_INCREMENT,
   nom VARCHAR(70)  NOT NULL,
   fonction VARCHAR(50)  NOT NULL,
   stock INT NOT NULL,
   PRIMARY KEY(Id_medicament)
)ENGINE INNODB;

CREATE TABLE fonction(
   Id_fonction INT AUTO_INCREMENT,
   nom VARCHAR(80)  NOT NULL,
   PRIMARY KEY(Id_fonction)
)ENGINE INNODB;

CREATE TABLE plat(
   Id_plat INT AUTO_INCREMENT,
   nom VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Id_plat)
)ENGINE INNODB;

CREATE TABLE allergene(
   Id_allergene INT AUTO_INCREMENT,
   nom VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Id_allergene)
)ENGINE INNODB;

CREATE TABLE personne(
   Id_personne INT AUTO_INCREMENT,
   nom VARCHAR(50)  NOT NULL,
   prenom VARCHAR(50)  NOT NULL,
   date_naissance DATE,
   date_arrivee DATE NOT NULL,
   date_depart DATE,
   email VARCHAR(70)  NOT NULL,
   telephone VARCHAR(15)  NOT NULL,
   PRIMARY KEY(Id_personne),
   UNIQUE(email),
   UNIQUE(telephone)
)ENGINE INNODB;

CREATE TABLE statut_candidature(
   Id_statut_candidature INT AUTO_INCREMENT,
   PRIMARY KEY(Id_statut_candidature)
)ENGINE INNODB;

CREATE TABLE etage(
   Id_etage INT AUTO_INCREMENT,
   etage_securise BOOLEAN NOT NULL,
   PRIMARY KEY(Id_etage)
)ENGINE INNODB;

CREATE TABLE chambre(
   Id_chambre INT AUTO_INCREMENT,
   no_chambre SMALLINT,
   chambre_double BOOLEAN NOT NULL,
   Id_etage INT NOT NULL,
   PRIMARY KEY(Id_chambre),
   FOREIGN KEY(Id_etage) REFERENCES etage(Id_etage)
)ENGINE INNODB;

CREATE TABLE employe(
   Id_employe INT AUTO_INCREMENT,
   no_secu BIGINT NOT NULL,
   Id_fonction INT NOT NULL,
   Id_personne INT NOT NULL,
   PRIMARY KEY(Id_employe),
   UNIQUE(Id_personne),
   UNIQUE(no_secu),
   FOREIGN KEY(Id_fonction) REFERENCES fonction(Id_fonction),
   FOREIGN KEY(Id_personne) REFERENCES personne(Id_personne)
)ENGINE INNODB;

CREATE TABLE infirmiere(
   no_RPPS VARCHAR(11) ,
   Id_employe INT NOT NULL,
   PRIMARY KEY(no_RPPS),
   UNIQUE(Id_employe),
   FOREIGN KEY(Id_employe) REFERENCES employe(Id_employe)
)ENGINE INNODB;

CREATE TABLE repas(
   Id_repas INT AUTO_INCREMENT,
   rang INT NOT NULL,
   jour DATE NOT NULL,
   PRIMARY KEY(Id_repas)
)ENGINE INNODB;

CREATE TABLE medecin(
   Id_medecin INT AUTO_INCREMENT,
   Id_personne INT NOT NULL,
   PRIMARY KEY(Id_medecin),
   UNIQUE(Id_personne),
   FOREIGN KEY(Id_personne) REFERENCES personne(Id_personne)
)ENGINE INNODB;

CREATE TABLE pensionnaire(
   Id_pensionnaire INT AUTO_INCREMENT,
   no_secu BIGINT NOT NULL,
   Id_chambre INT NOT NULL,
   Id_personne INT NOT NULL,
   PRIMARY KEY(Id_pensionnaire),
   UNIQUE(Id_personne),
   UNIQUE(no_secu),
   FOREIGN KEY(Id_chambre) REFERENCES chambre(Id_chambre),
   FOREIGN KEY(Id_personne) REFERENCES personne(Id_personne)
)ENGINE INNODB;

CREATE TABLE ordonnance(
   Id_medecin INT,
   Id_pensionnaire INT,
   jour DATE,
   PRIMARY KEY(Id_medecin, Id_pensionnaire, jour),
   FOREIGN KEY(Id_medecin) REFERENCES medecin(Id_medecin),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire)
)ENGINE INNODB;

CREATE TABLE demande_une_admission(
   Id_personne INT,
   jour DATE,
   commentaire TEXT,
   Id_statut_candidature INT NOT NULL,
   PRIMARY KEY(Id_personne, jour),
   FOREIGN KEY(Id_personne) REFERENCES personne(Id_personne),
   FOREIGN KEY(Id_statut_candidature) REFERENCES statut_candidature(Id_statut_candidature)
)ENGINE INNODB;

CREATE TABLE administre(
   Id_pensionnaire INT,
   Id_medicament INT,
   heure DATETIME,
   no_RPPS VARCHAR(11)  NOT NULL,
   PRIMARY KEY(Id_pensionnaire, Id_medicament, heure),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire),
   FOREIGN KEY(Id_medicament) REFERENCES medicament(Id_medicament),
   FOREIGN KEY(no_RPPS) REFERENCES infirmiere(no_RPPS)
)ENGINE INNODB;

CREATE TABLE repas_plat(
   Id_repas INT,
   Id_plat INT,
   PRIMARY KEY(Id_repas, Id_plat),
   FOREIGN KEY(Id_repas) REFERENCES repas(Id_repas),
   FOREIGN KEY(Id_plat) REFERENCES plat(Id_plat)
)ENGINE INNODB;

CREATE TABLE allergene_plat(
   Id_plat INT,
   Id_allergene INT,
   PRIMARY KEY(Id_plat, Id_allergene),
   FOREIGN KEY(Id_plat) REFERENCES plat(Id_plat),
   FOREIGN KEY(Id_allergene) REFERENCES allergene(Id_allergene)
)ENGINE INNODB;

CREATE TABLE service_repas(
   Id_pensionnaire INT,
   Id_repas INT,
   PRIMARY KEY(Id_pensionnaire, Id_repas),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire),
   FOREIGN KEY(Id_repas) REFERENCES repas(Id_repas)
)ENGINE INNODB;

CREATE TABLE sensibilite_allergene(
   Id_pensionnaire INT,
   Id_allergene INT,
   en_cas_de_crise TEXT NOT NULL,
   PRIMARY KEY(Id_pensionnaire, Id_allergene),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire),
   FOREIGN KEY(Id_allergene) REFERENCES allergene(Id_allergene)
)ENGINE INNODB;

CREATE TABLE prescription(
   Id_medicament INT,
   Id_medecin INT,
   Id_pensionnaire INT,
   jour DATE,
   posologie VARCHAR(50)  NOT NULL,
   date_debut_traitement DATE NOT NULL,
   date_fin_traitement DATE NOT NULL,
   PRIMARY KEY(Id_medicament, Id_medecin, Id_pensionnaire, jour),
   FOREIGN KEY(Id_medicament) REFERENCES medicament(Id_medicament),
   FOREIGN KEY(Id_medecin, Id_pensionnaire, jour) REFERENCES ordonnance(Id_medecin, Id_pensionnaire, jour)
)ENGINE INNODB;

CREATE TABLE doit_administrer(
   no_RPPS VARCHAR(11) ,
   Id_medecin INT,
   Id_pensionnaire INT,
   jour DATE,
   PRIMARY KEY(no_RPPS, Id_medecin, Id_pensionnaire, jour),
   FOREIGN KEY(no_RPPS) REFERENCES infirmiere(no_RPPS),
   FOREIGN KEY(Id_medecin, Id_pensionnaire, jour) REFERENCES ordonnance(Id_medecin, Id_pensionnaire, jour)
)ENGINE INNODB;


-- DEBUT DES VALEURS DE TEST
INSERT INTO personne(id_personne, nom, prenom, date_naissance, date_arrivee, email, telephone) VALUES 
    (1, 'HADDOCK', 'Archibald', '1920-06-01', CURDATE(), 'archibald.haddock@lemans.fr', '+33659847264'),
	(2, 'ISTIS', 'Larme', '1918-11-11', CURDATE(), 'larme.istis@pastis.fr', '+33688888888'),
    (3, 'TERIEUR', 'Alex', '1932-12-24', CURDATE(), 'papa.noel@pole-nord.com', '+3966598482530'),
    (4, 'TERIEUR', 'Alain', '1938-02-14', CURDATE(), 'cupidon@love.com', '+33662984715'),
    (5, 'CURRY', 'Marie', '1960-09-21', CURDATE(), 'marieeaucurry@infirmiere.fr', '+33666666666'),
    (6, 'BRETON', 'Anna', '1991-11-11', CURDATE(), 'bretagnelibre@insoumis.fr', '+33699999999'),
    (7, 'BEBOU', 'Amelie', '1975-05-05', CURDATE(), 'bebou@docteur.fr', '+33611111111');

		INSERT INTO etage(etage_securise)
		VALUES (false),
		(true),
		(false),
		(false);

		INSERT INTO chambre(no_chambre, chambre_double, id_etage)
		VALUES (201, false, 2),
		(202, false, 2),
		(203, false, 2),
		(204, false, 2);

		INSERT INTO chambre(no_chambre, chambre_double, id_etage)
		VALUES (301, false, 3),
		(302, true, 3),
		(303, true, 3),
		(304, false, 3),
		(401, false, 4),
		(402, true, 4),
		(403, true, 4),
		(404, false, 4);

		INSERT INTO pensionnaire(no_secu, id_chambre, id_personne)
		VALUES (120069135923302, 1, 1),
		(118119135923555, 2, 2),
		(132069135923666, 4, 3),
		(138069135923777, 3, 4);

		INSERT INTO fonction(nom)
		VALUES ('infirmiere'),
		('cuisinier'),
		("personnel_administratif"),
		('comptable');

		INSERT INTO employe(no_secu, id_fonction, id_personne)
		VALUES (160099135923888, 1, 5);

		INSERT INTO infirmiere(no_RPPS, id_employe)
		VALUES (12345678901, 1);

		INSERT INTO medicament(nom, fonction, stock)
		VALUES ("Doliprane", 'antalgique', 50),
		("Aspegic", 'antalgique', 80),
		("céphalexine", 'antibiotique', 5);

		INSERT INTO medecin(id_personne)
		VALUES (7);

		INSERT INTO ordonnance(id_medecin, id_pensionnaire, jour)
		VALUES (1,3, CURDATE());

		INSERT INTO prescription(id_medicament, id_medecin, id_pensionnaire, jour, posologie, date_debut_traitement, date_fin_traitement)
		VALUES (1, 1,3, CURDATE(), "- Paracétamol 1000mg : 3 comprimés par jour", curdate(), '2023-07-14');

		INSERT INTO doit_administrer(id_medecin, id_pensionnaire, jour, no_RPPS)
		VALUES (1, 3, CURDATE(), 12345678901);

		INSERT INTO allergene(nom)
		VALUES ("gluten"),
		("soja"),
		("arachide"),
		("lait"),
		("moutarde"),("céleri");

		INSERT INTO plat(nom)
		VALUES ("steak-frites"),
		("moules-frites"),
		("tomates farcies"),
		("lasagnes"),
		("couscous"),
		("purée cabillaud"),
		("pâtes carbonara"),
		("gratin de brocolis"),
		("salade de pâtes"),
		("chèvre chaud"),
		("gaspacho"),
		("tomate mozzarella"),
		("velouté de légumes"),
		("mousse au chocolat"),
		("salade de fruits"),
		("tarte aux poires"),
		("tiramisu"),
		("fromage blanc"),
		("crumble aux pommes");

		INSERT INTO repas(rang, jour)
		VALUES (1, '2022-12-26'),
		(2, '2022-12-26'),
		(3, '2022-12-26'),
		(1, '2022-12-27'),
		(2, '2022-12-27'),
		(3, '2022-12-27'),
		(1, '2022-12-28'),
		(2, '2022-12-28'),
		(3, '2022-12-28'),
		(1, '2022-12-29'),
		(2, '2022-12-29'),
		(3, '2022-12-29'),
		(1, '2022-12-30'),
		(2, '2022-12-30'),
		(3, '2022-12-30'),
		(1, '2022-12-31'),
		(2, '2022-12-31'),
		(3, '2022-12-31'),
		(1, '2023-01-01'),
		(2, '2023-01-01'),
		(3, '2023-01-01');