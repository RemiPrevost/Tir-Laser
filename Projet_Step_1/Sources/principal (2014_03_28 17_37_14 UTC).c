#include "gassp72.h"
#include "etat.h"

extern int LongueurSon;
extern short Son[];
extern int PeriodeSonMicroSec ;

	type_etat etat;

void Carre2(void);

void timer_callback (void) ;

short Calibrage(short son) {
	return (short)(0.0055 * son) + 180;
}

int main(void)
{
	int periode_pwm = 360 ;
	
	etat.position=0;
	etat.taille=LongueurSon;
	etat.son=Son;

	
// activation de la PLL qui multiplie la fréquence du quartz par 9
CLOCK_Configure();
	
// config port PB1 pour être utilisé en sortie
GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);
	
// config port PB0 pour être utilisé par TIM3-CH3
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	
// config TIM3-CH3 en mode PWM
etat.resolution = PWM_Init_ff( TIM3, 3, periode_pwm );
	
// initialisation du timer 4
// INTERVALLE doit fournir la durée entre interruptions,
// exprimée en périodes de l'horloge CPU (72 MHz)
Timer_1234_Init_ff(TIM4, 72000000);
// enregistrement de la fonction de traitement de l'interruption timer
// ici le 2 est la priorité, timer_callback est l'adresse de cette fonction, a créér en asm,
// cette fonction doit être conforme à l'AAPCS
Active_IT_Debordement_Timer( TIM4, 2, timer_callback );
// lancement du timer
Run_Timer( TIM4 );

while (etat.position < etat.taille)	; // empêche l'arret immédiat du programme

}