package uml;

public class PlantUML {
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
	 * 
	 * @startuml 
	 * participant Navigateur 
	 * participant Vue
	 * 
	 *           Navigateur -> Controleur: /administration_medicament\n+parametres 
	 *           Controleur -> Dao: EHPAD.getPensionnaires()
	 *           Controleur -> Dao: EHPAD.getOrdonnances()
	 *           Dao -> SGBD: SQL SELECT id_pensionnaire, id_medicament, posologie, jour\n FROM prescription\n GROUP BY id_pensionnaire\nWHERE date_fin_traitement<NOW()
	 *           SGBD --> Dao: id_pensionnaire, id_medicament, posologie, jour
	 *           Dao --> Controleur: new Ordonnance
	 *           Controleur -> Vue: ordonnances.jsp 
	 *           Vue --> Navigateur: HTML genere
	 * @enduml
	 */
}
