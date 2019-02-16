unit debuterJeu;

interface

uses
  GestionEcran,gestionnaire,croisementLieu,house;


procedure commencement(var personnage : heros; var coffre : stock);
procedure debutJeu();

implementation

procedure debutJeu();

var
  quitter : boolean; //permet de  sortir de la boucle
  choix : integer; //correspond à ce que choisit le joueur


begin
  quitter := true;
  while quitter do
  begin
    effacerEcran;
    writeln(' _____   _                               ____                         _ '); //affichage du titre du jeu
    writeln('/ ____| | |                             / __ \                       | |   ');
    writeln('|(___   | |_    ___    _ __     ___    | |  | |  _   _    ___   ___  | |_ ');
    writeln('\___ \  | __|  / _ \  | ''_ \   / _ \   | |  | | | | | |  / _ \ / __| | __|');
    writeln('____) | | |_  | (_) | | | | | |  __/   | |__| | | |_| | |  __/ \__ \ | |_ ');
    writeln('|_____/  \__|  \___/  |_| |_|  \___|    \___\_\  \__,_|  \___| |___/  \__|');
    writeln('');
    writeln('1 - Commencer une partie');
    writeln('2 - Quitter');
    writeln('');
    readln(choix);
    case choix of
        1 : commencement(personnage,coffre); //on lance le jeu
        2 : quitter := false; //le joueur quitte le jeu
    end;
  end;


end;




procedure commencement(var personnage : heros; var coffre : stock);

begin
     effacerEcran;
     writeln('Quel est votre nom aventurier?');
     readln(personnage.nom);   //enregistre le nom choisi par l'utilisateur
     personnage.mort := false; //initialisation des variables concernant le personnages
     personnage.vie := 100;    //initialisation de vie du personnage
     personnage.pierre := 0;   //initialisation du stock de pierre du personnage
     personnage.fer := 0;      //initialisation du stock de fer du personnage
     personnage.bois := 0;     //initialisation du stock de bois du personnage
     personnage.argent := 0;   //initialisation de l'argent du personnage
     personnage.arme := 0;     //initialisation a 0 de l'arme du personnage(il n'en a pas)
     personnage.armure := 0;   //initialisation a 0 de l'armure du personnage(il n'en a pas)
     coffre.pierre := 0;       //initialisation du stock de pierre du coffre
     coffre.fer := 0;          //initialisation du stock de fer du coffre
     coffre.bois := 0;         //initialisation du stock de bois du coffre
     maison(personnage,coffre);//fait appel a l'unité maison
     effacerEcran;             //efface l'écran pour afficher le prochain
     croisement(personnage );  //fait appel a l'unité croisement
     readln;
end;


end.

