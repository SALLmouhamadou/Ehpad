CREATE TABLE medicament(
   Id_medicament INT AUTO_INCREMENT,
   nom VARCHAR(70)  NOT NULL,
   fonction VARCHAR(50) ,
   stock INT NOT NULL,
   quantite_par_boite INT NOT NULL,
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
   telephone BIGINT NOT NULL,
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
   Id_employe INT,
   no_RPPS BIGINT NOT NULL,
   PRIMARY KEY(Id_employe),
   UNIQUE(no_RPPS),
   FOREIGN KEY(Id_employe) REFERENCES employe(Id_employe)
)ENGINE INNODB;

CREATE TABLE repas(
   Id_repas INT AUTO_INCREMENT,
   rang INT NOT NULL,
   date_repas DATE,
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
   Id_employe INT NOT NULL,
   PRIMARY KEY(Id_pensionnaire, Id_medicament, heure),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire),
   FOREIGN KEY(Id_medicament) REFERENCES medicament(Id_medicament),
   FOREIGN KEY(Id_employe) REFERENCES infirmiere(Id_employe)
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
   Id_employe INT,
   Id_medecin INT,
   Id_pensionnaire INT,
   jour DATE,
   PRIMARY KEY(Id_employe, Id_medecin, Id_pensionnaire, jour),
   FOREIGN KEY(Id_employe) REFERENCES infirmiere(Id_employe),
   FOREIGN KEY(Id_medecin, Id_pensionnaire, jour) REFERENCES ordonnance(Id_medecin, Id_pensionnaire, jour)
)ENGINE INNODB;
