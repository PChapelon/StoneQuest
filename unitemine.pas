unit uniteMine;



interface

uses
    gestionnaire,GestionEcran;


procedure mine(var personnage : heros); //procédure ouvrant différentes possibilités au joueur
function recoltFer(): Integer; //fonction générant le fer récoltée s'il en trouve
function recoltPierre(): Integer; //fonction générant la pierre récoltée par le joueur
procedure cbt(var personnage : heros; var monstre : monster); //procédure lançant un combat contre un ennemi
procedure affichageStat(personnage:heros; monstre : monster); //procédure permettant d'afficher en combat les statistiques du joueur et du monstre
procedure tourPerso(var stop, victoire : boolean; var personnage:heros; var monstre: monster); //procédure simulant l'attaque du joueur
procedure tourMonstre(var stop, victoire : boolean; var personnage:heros; var monstre: monster); //procédure simulant l'attaque du monstre




implementation


procedure mine(var personnage : heros ); //procédure ouvrant différentes possibilités au joueur



var
	choix : Integer; //variable numérique de type entier contenant le choix de l'utilisateur
	quitter : Boolean; //variable numérique de type booléen permettant d'entrer dans la répétitive


begin
	quitter := true; //permet de rentrer dans la répétitive
        writeln('Vous entrez dans la mine. Il fait tres sombre par ici.');
        readln;
	while quitter do //répétitive affichant les différents choix au joueur a chaque fois qu'il en fait un
	begin
        effacerEcran;
        writeln('Stock de pierre : ',personnage.pierre); //affiche le stock du pierre
		writeln('Stock de fer : ',personnage.fer); //affiche le stock du fer
		writeln('Que voulez-vous faire?'); //affiche les choix proposés pour le joueur
		writeln('1 - Recolter de la pierre');
		writeln('2 - Essayer de trouver du fer');
		writeln('3 - S''aventurer dans la mine');
		writeln('4 - Sortir de la mine');
		readln(choix); //lecture du choix de l'utilisateur
		case choix of
			1 : personnage.pierre := personnage.pierre + recoltPierre(); //choix de récolter de la pierre
			2 : personnage.fer := personnage.fer + recoltFer (); //récolter du fer
			3 : cbt(personnage,monstre); //choix de lancer un combat
			4 : quitter := false; //on sort de la mine
		end;
        if personnage.mort then  //alternative permettant de remonter toutes les procédures jusqu'à l'écran titre si le personnage meurt
	begin
		quitter := false;//on sort de la répétitive
	end;
	end;

end;
//**************************FIN mine*****************************************
//**************************DEBUT recoltFer*****************************************



function recoltFer(): Integer; //fonction générant le fer récoltée s'il en trouve

var
	prob : Integer; //variable numérique de type entier simulant la possibilité ou non de trouver du fer

begin
	randomize;
	prob := random(100); //génération de la probabilité
	if prob > 50 then
	begin   //le joueur trouve du fer
		randomize;
		recoltFer := (random(2)+1); //génération du fer trouvé
                writeln('Vous avez trouve ',recoltFer,' morceaux de fer');
	end
	else
	begin  //il n'en trouve pas
		writeln('Vous n''avez pas trouve de fer');
		recoltFer := 0; //on renvoie 0 fer
	end;
        readln;
end;

//**************************FIN recoltFer*****************************************
//**************************DEBUT recoltPierre*****************************************

function recoltPierre(): Integer; //fonction générant la pierre récoltée par le joueur

begin
	randomize;
	recoltPierre := (random(2)+1); //génération de la pierre récoltée
end;

//**************************FIN recoltPierre**************************************
//**************************DEBUT cbt*****************************************


procedure cbt(var personnage : heros ; var monstre : monster); //procédure lançant un combat contre un ennemi


var
	choix: Integer;//variable numérique de type entier contenant le choix de l'utilisateur
	stop : boolean; //variable numérique de type booléenne arrêtant la boucle du combat
	victoire : boolean; //variable numérique de type booléenne contenant le résultat du combat


begin
	writeln('Un énorme goblin se dresse devant vous');
	stop := true; //permet d'entrer dans la boucle
	monstre.nom := 'Goblin'; //initialisation des statistiques de l'ennemi
	monstre.defense := 0;
  monstre.vie := 50;
  monstre.force := 0;
  monstre.arme := 1;
	while stop do
	begin
		effacerEcran;
		affichageStat(personnage,monstre); //on affiche en haut de l'écran les statistiques du monstre et du joueur
    writeln('Que voulez vous faire?'); //choix porposés à l'utilisateur
    writeln('1 - Attaquer');
    writeln('2 - Attendre');
    readln(choix); //lecture du choix fait par le joueur
    case choix of //gestion du choix
      1 : begin //il choisit d'attaquer
            tourPerso(stop, victoire,personnage,monstre); //le joueur attaque
            tourMonstre(stop, victoire, personnage, monstre); //le monstre attaque
          end;
      2 : begin   //il choisit de ne rien faire
            writeln('Vous attendez'); //message qui signale l'attente
            tourMonstre (stop, victoire,personnage,monstre); //le monstre attaque
            attendre(300); //temps pour lire le message
          end;
    end;
	end;
	if victoire then   //gestion de la victoire ou non du joueur
	begin
		writeln(monstre.nom,' a ete battu.');//le joueur a gagné
    personnage.argent := personnage.argent + 20; //il reçoit un peu d'argent
    personnage.fer := personnage.fer + 10; //il reçoit du fer
	end
	else
	begin
		writeln('Vous avez ete vaincu.');//le joueur a perdu
		writeln('Game Over!!!!!!!!');
		personnage.mort := true; //la variable gérant la mort du personnage passe a vrai
	end;
  attendre(250);
end;

//**************************FIN cbt***********************************************
//**************************DEBUT affichageStat***********************************

procedure affichageStat(personnage : heros; monstre : monster); //procédure permettant d'afficher en combat les statistiques du joueur et du monstre

begin
	writeln('< ',monstre.nom,' >');  //nom du monstre
	writeln('Point de vie : ', monstre.vie);  //ses points de vie
	writeln('');
	writeln('< ',personnage.nom,' >'); //nom du joueur
	writeln('Point de vie : ',personnage.vie); //sa vie
  writeln('');
end;

//**************************FIN affichageStat*****************************************
//**************************DEBUT tourPerso*****************************************

procedure tourPerso(var stop, victoire : boolean; var personnage : heros; var monstre : monster);
//procédure simulant l'attaque du joueur


begin
	randomize;
	personnage.force := random(4)+1;//génération des dégâts du joueur
	monstre.vie := monstre.vie -((personnage.force + personnage.arme) - monstre.defense); //soustraction des dégâts (modifiés) au point de vie du monstre
        {paramètres : l'arme du joueur et l'armure du monstre}
	if monstre.vie<=0 then //cas où le monstre n'a plus de vie
	begin
		stop := false; //on arrète le combat
		victoire := true; //le joueur a gagné
	end
end;

//**************************FIN tourPerso*****************************************
//**************************DEBUT tourMonstre**************************************


procedure tourMonstre(var stop, victoire : boolean; var personnage : heros; var monstre : monster);
//procédure simulant l'attaque du monstre


begin
	randomize;
	monstre.force := random(2)+1;//génère un nombre aléatoire pour les dégâts infligés par l'ennemi
	personnage.vie := personnage.vie -((monstre.force + monstre.arme) - personnage.armure);//on soustrait les dégâts (modifiés par des paramètres)  à la vie du joueur
        {paramètres : l'arme du monstre et l'armure du joueur}
	if personnage.vie<=0 then //cas où le personnage n'a plus de vie
	begin
		stop := false; //le combat s'arrète
    victoire := false; //le joueur a perdu et est mort
  end
end;

//**************************FIN tourMonstre*****************************************
end.

