unit Unitforet;

interface

uses
    gestionnaire,GestionEcran,unitMarchand;


procedure foret(var personnage : heros); //procédure de la forêt
function recoltbois(): Integer;  //fonction de recolte de bois




implementation

//**************************DEBUT FORET****************************************
procedure foret(var personnage : heros ); //procédure de la forêt avec personnage en variable de référence



var
	choix : Integer;  //variable numérique de type entier contenant le choix de l'utilisateur
	quitter : Boolean; //variable de type boolean contenant la sortie de la procédure


begin
	quitter := true; //initialisation de la sortie sur vrai
  writeln('Vous entrez dans la foret. Elle est dense et de gigantesques arbres la peuple, sur votre droite vous apercevez un marchand.'); //Affichage d'une phrase de début
  readln;
	while quitter do //début de boucle tant que quitter n'a pas la valeur fausse
	begin
    effacerEcran;  //effacer l'écran pour afficher un autre
    writeln('Stock de bois : ',personnage.bois); //afficher le stock de bois du personnage
		writeln('Que voulez-vous faire?'); //on demande ce que veut faire le joueur
		writeln('1 - Recolter du bois');  //choix 1 recolter du bois
		writeln('2 - Parler au marchand'); //choix 2 parler au marchand
		writeln('3 - Sortir de la foret'); //choix 3 sortir de la forêt
		readln(choix);
		case choix of
			1 : personnage.bois := personnage.bois + recoltBois(); //ajout au stock de bois du personnage la fonction recoltBois()
			2 : marchand(personnage); //faire appel a la procédure marchand
			3 : quitter := false; //choix 3 partir(avec son TARDIS?)
		end;

	end;
end;

//**************************FIN FORET******************************************
//**************************DEBUT RECOLTBOIS***********************************
function recoltBois(): Integer; //fonction pour la récolte du bois

begin
	randomize; //appel de randomize
	recoltBois := (random(2)+1); //renvoie 1 ou 2
end;
//**************************FIN RECOLTBOIS*************************************
end.

