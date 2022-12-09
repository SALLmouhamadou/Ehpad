package uml;

public class UMLPrescriptions {
	/**
	 * afficher prescriptions
	 * @startuml 
	 * participant Navigateur 
	 * participant Vue
	 * 
	 *           Navigateur -> Controleur: GET /prescriptions/\n?no_patient
	 *           Controleur -> Controleur: idPatient complet ?
	 *           Controleur -> Dao: PrescriptionDAO.getPrescriptions(noPatient)
	 *           Dao -> SGBD: SELECT ...
	 *           SGBD --> Dao: lignes
	 *           Dao --> Controleur: List<Prescription>
	 *           Controleur -> Vue: prescriptions.jsp
	 *           Vue --> Navigateur: HTML genere
	 * @enduml
	 */
	
	/**
	 * administrer médicament
	 * @startuml 
	 * participant Navigateur 
	 * participant Vue
	 * 
	 *           Navigateur -> Controleur: POST /administration_medicament\n+parametres 
	 *           Controleur -> Controleur: Check integrity\n+non-null\n+Check id_medicament
	 *           Controleur -> Dao: Infirmiere.setAdministre()
	 *           Dao -> SGBD: SQL INSERT ...
	 *           SGBD --> Dao: lignes (ou erreurs)
	 *           Dao --> Controleur: Status
	 *           Controleur -> Vue: administration_medicament.jsp 
	 *           Vue --> Navigateur: HTML genere
	 * @enduml
	 */
}
