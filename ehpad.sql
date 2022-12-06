CREATE TABLE chambre(
   Id_chambre INT AUTO_INCREMENT,
   PRIMARY KEY(Id_chambre)
);

CREATE TABLE medicament(
   Id_medicament INT AUTO_INCREMENT,
   PRIMARY KEY(Id_medicament)
);

CREATE TABLE fonction(
   Id_fonction INT AUTO_INCREMENT,
   PRIMARY KEY(Id_fonction)
);

CREATE TABLE plat(
   Id_plat INT AUTO_INCREMENT,
   PRIMARY KEY(Id_plat)
);

CREATE TABLE allergene(
   Id_allergene INT AUTO_INCREMENT,
   PRIMARY KEY(Id_allergene)
);

CREATE TABLE medecin(
   Id_medecin INT AUTO_INCREMENT,
   PRIMARY KEY(Id_medecin)
);

CREATE TABLE personne(
   Id_personne INT AUTO_INCREMENT,
   PRIMARY KEY(Id_personne)
);

CREATE TABLE statut_candidature(
   Id_statut_candidature INT AUTO_INCREMENT,
   PRIMARY KEY(Id_statut_candidature)
);

CREATE TABLE pensionnaire(
   Id_pensionnaire INT AUTO_INCREMENT,
   Id_chambre INT NOT NULL,
   Id_personne INT NOT NULL,
   PRIMARY KEY(Id_pensionnaire),
   UNIQUE(Id_personne),
   FOREIGN KEY(Id_chambre) REFERENCES chambre(Id_chambre),
   FOREIGN KEY(Id_personne) REFERENCES personne(Id_personne)
);

CREATE TABLE employe(
   Id_employe INT AUTO_INCREMENT,
   Id_fonction INT NOT NULL,
   Id_personne INT NOT NULL,
   PRIMARY KEY(Id_employe),
   UNIQUE(Id_personne),
   FOREIGN KEY(Id_fonction) REFERENCES fonction(Id_fonction),
   FOREIGN KEY(Id_personne) REFERENCES personne(Id_personne)
);

CREATE TABLE infirmiere(
   Id_employe INT,
   PRIMARY KEY(Id_employe),
   FOREIGN KEY(Id_employe) REFERENCES employe(Id_employe)
);

CREATE TABLE repas(
   jour DATE,
   Id_repas INT AUTO_INCREMENT,
   rang INT AUTO_INCREMENT NOT NULL,
   PRIMARY KEY(jour, Id_repas)
);

CREATE TABLE ordonnance(
   Id_medecin INT,
   Id_pensionnaire INT,
   jour DATE,
   PRIMARY KEY(Id_medecin, Id_pensionnaire, jour),
   FOREIGN KEY(Id_medecin) REFERENCES medecin(Id_medecin),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire)
);

CREATE TABLE demande_une_admission(
   Id_personne INT,
   jour DATE,
   Id_statut_candidature INT NOT NULL,
   PRIMARY KEY(Id_personne, jour),
   FOREIGN KEY(Id_personne) REFERENCES personne(Id_personne),
   FOREIGN KEY(Id_statut_candidature) REFERENCES statut_candidature(Id_statut_candidature)
);

CREATE TABLE administre(
   Id_pensionnaire INT,
   Id_medicament INT,
   heure DATETIME,
   Id_employe INT NOT NULL,
   PRIMARY KEY(Id_pensionnaire, Id_medicament, heure),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire),
   FOREIGN KEY(Id_medicament) REFERENCES medicament(Id_medicament),
   FOREIGN KEY(Id_employe) REFERENCES infirmiere(Id_employe)
);

CREATE TABLE repas_plat(
   jour DATE,
   Id_repas INT,
   Id_plat INT,
   PRIMARY KEY(jour, Id_repas, Id_plat),
   FOREIGN KEY(jour, Id_repas) REFERENCES repas(jour, Id_repas),
   FOREIGN KEY(Id_plat) REFERENCES plat(Id_plat)
);

CREATE TABLE allergene_plat(
   Id_plat INT,
   Id_allergene INT,
   PRIMARY KEY(Id_plat, Id_allergene),
   FOREIGN KEY(Id_plat) REFERENCES plat(Id_plat),
   FOREIGN KEY(Id_allergene) REFERENCES allergene(Id_allergene)
);

CREATE TABLE service_repas(
   Id_pensionnaire INT,
   jour DATE,
   Id_repas INT,
   PRIMARY KEY(Id_pensionnaire, jour, Id_repas),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire),
   FOREIGN KEY(jour, Id_repas) REFERENCES repas(jour, Id_repas)
);

CREATE TABLE sensibilite_allergene(
   Id_pensionnaire INT,
   Id_allergene INT,
   PRIMARY KEY(Id_pensionnaire, Id_allergene),
   FOREIGN KEY(Id_pensionnaire) REFERENCES pensionnaire(Id_pensionnaire),
   FOREIGN KEY(Id_allergene) REFERENCES allergene(Id_allergene)
);

CREATE TABLE prescription(
   Id_medicament INT,
   Id_medecin INT,
   Id_pensionnaire INT,
   jour DATE,
   posologie VARCHAR(50)  NOT NULL,
   PRIMARY KEY(Id_medicament, Id_medecin, Id_pensionnaire, jour),
   FOREIGN KEY(Id_medicament) REFERENCES medicament(Id_medicament),
   FOREIGN KEY(Id_medecin, Id_pensionnaire, jour) REFERENCES ordonnance(Id_medecin, Id_pensionnaire, jour)
);

CREATE TABLE doit_administrer(
   Id_employe INT,
   Id_medecin INT,
   Id_pensionnaire INT,
   jour DATE,
   PRIMARY KEY(Id_employe, Id_medecin, Id_pensionnaire, jour),
   FOREIGN KEY(Id_employe) REFERENCES infirmiere(Id_employe),
   FOREIGN KEY(Id_medecin, Id_pensionnaire, jour) REFERENCES ordonnance(Id_medecin, Id_pensionnaire, jour)
);
