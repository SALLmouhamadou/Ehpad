package ehpad.employes;

/**
 * @startuml
 * participant Infirmiere
 * participant Medicament
 * participant Pensionnaire

 * Infirmiere -> Medicament: Prend une dose de Medicament
 * Medicament -> Pensionnaire: est administré à Pensionnaire Now()
 * @enduml
 */
public class Infirmiere implements Employe {
	
}
