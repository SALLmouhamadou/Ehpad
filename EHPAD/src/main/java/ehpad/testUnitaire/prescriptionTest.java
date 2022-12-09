package ehpad.testUnitaire;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class prescriptionTest {

	@Test
    public void testPullPrescriptions() {
        //Given
        // On va chercher toutes les prescriptions disponibles.
		EHPAD instance = new EHPAD();
		instance.getPatients();
        //When
        instance.pullPrescriptions();

        //Then
        assertTrue(instance.getPrescriptions.size() > 0);
    }
	
	@Test
    public void testCommitAdministrer() {
        //Given
        // On va chercher toutes les prescriptions disponibles.
		Infirmiere infirmiere = new Infirimiere();
		Pensionnaire pensionnaire = new Pensionnaire();
        //When
        instance.commitAdministrer(infirmiere, pensionnaire);

        //Then
        EHPAD instance = new EHPAD();
		instance.getPatients();
        instance.pullPrescriptions();
        assertTrue(instance.pullAdministrer.size() > 0);
    }
	

}
