UNIT cadre_menu;

INTERFACE

PROCEDURE affi_cadre(score : integer);
PROCEDURE affiCJ;
FUNCTION deplacement(x, y,y_max,opt_max : INTEGER) : INTEGER;
PROCEDURE Bienvenue;
PROCEDURE sortie;
PROCEDURE affiMen_1;
PROCEDURE lancer_jeu;
PROCEDURE affi_jouer;
PROCEDURE premier_ecr;
PROCEDURE affi_gameOver(score : INTEGER);
PROCEDURE affi_modeJeu;
PROCEDURE affi_cadre_murs(score : integer);
PROCEDURE affi_modeCadre;
PROCEDURE affi_gameOverHS(score : INTEGER);
PROCEDURE affi_classement;
PROCEDURE affi_serp_2();
PROCEDURE affiClassement_mode;

IMPLEMENTATION
USES
	crt;
///////////////////////////////////Cadre////////////////////////////////////////
PROCEDURE affi_cadre(score : integer);
BEGIN
	ClrScr;
	textcolor(10);
	WRITELN('                                  Score : ',score);
	WRITELN();
	WRITELN('  ____________________________________________________________________________');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  ----------------------------------------------------------------------------');
END;


PROCEDURE affi_cadre_murs(score : integer);
BEGIN
	ClrScr;
	textcolor(10);
	WRITELN('                                  Score : ',score);
	WRITELN();
	WRITELN('  ____________________________________________________________________________');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                 ._____                           ______.                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |                                      |                 |');
	WRITELN('  |                 |_____                            _____|                 |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  |                                                                          |');
	WRITELN('  ----------------------------------------------------------------------------');
END;

//////////////////////////////////////Jeu du Serpent////////////////////////////
PROCEDURE affi_serp_1();
BEGIN
	gotoxy(6,7); WRITELN('     _                  _         ____                             _');
	gotoxy(6,8); WRITELN('    | | ___ _   _    __| |_   _  / ___|  ___ _ __ _ __   ___ _ __ | |_');
	gotoxy(6,9); WRITELN(' _  | |/ _ \ | | |  / _` | | | | \___ \ / _ \ ''__| ''_ \ / _ \ ''_ \| __|');
	gotoxy(6,10); WRITELN('| |_| |  __/ |_| | | (_| | |_| |  ___) |  __/ |  | |_) |  __/ | | | |_');
	gotoxy(6,11); WRITELN(' \___/ \___|\__,_|  \__,_|\__,_| |____/ \___|_|  | .__/ \___|_| |_|\__|');
	gotoxy(6,12); WRITELN('																			      |_|');
END;

PROCEDURE affi_serp_2();
BEGIN
	ClrScr;
	gotoxy(6,1); WRITELN('     _                  _         ____                             _');
	gotoxy(6,2); WRITELN('    | | ___ _   _    __| |_   _  / ___|  ___ _ __ _ __   ___ _ __ | |_');
	gotoxy(6,3); WRITELN(' _  | |/ _ \ | | |  / _` | | | | \___ \ / _ \ ''__| ''_ \ / _ \ ''_ \| __|');
	gotoxy(6,4); WRITELN('| |_| |  __/ |_| | | (_| | |_| |  ___) |  __/ |  | |_) |  __/ | | | |_');
	gotoxy(6,5); WRITELN(' \___/ \___|\__,_|  \__,_|\__,_| |____/ \___|_|  | .__/ \___|_| |_|\__|');
	gotoxy(6,6); WRITELN('																			      |_|');
END;


PROCEDURE affi_gameOver(score : INTEGER);
BEGIN
	ClrScr;
	textcolor(7);
	gotoxy(15,3); WRITELN('  ____                         ___');
	gotoxy(15,4); WRITELN(' / ___| __ _ _ __ ___   ___   / _ \__   _____ _ __');
	gotoxy(15,5); WRITELN('| |  _ / _` | ''_ ` _ \ / _ \ | | | \ \ / / _ \ ''__|');
	gotoxy(15,6); WRITELN('| |_| | (_| | | | | | |  __/ | |_| |\ V /  __/ |');
	gotoxy(15,7); WRITELN(' \____|\__,_|_| |_| |_|\___|  \___/  \_/ \___|_|');
	WRITELN();
	WRITELN('Vous avez perdu avec un score de : ',score);
	WRITELN('Veuillez choisir l''option que vous voulez :');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Rejouer');
	WRITELN('   2. Retour à l''accueil');
	WRITELN('   3. Quitter');
END;

PROCEDURE affi_gameOverHS(score : INTEGER);
BEGIN
	ClrScr;
	textcolor(7);
	gotoxy(15,3); WRITELN('  ____                         ___');
	gotoxy(15,4); WRITELN(' / ___| __ _ _ __ ___   ___   / _ \__   _____ _ __');
	gotoxy(15,5); WRITELN('| |  _ / _` | ''_ ` _ \ / _ \ | | | \ \ / / _ \ ''__|');
	gotoxy(15,6); WRITELN('| |_| | (_| | | | | | |  __/ | |_| |\ V /  __/ |');
	gotoxy(15,7); WRITELN(' \____|\__,_|_| |_| |_|\___|  \___/  \_/ \___|_|');
	WRITELN();
	WRITELN('Vous avez perdu avec un score de : ',score);
	WRITELN();
END;

//////////////////////////////////////Comment Jouer/////////////////////////////
// Taille terminal horizontal : 80 charactères
// Taille terminal vertical : 26 lignes
PROCEDURE affiCJ;
BEGIN
	affi_serp_2;
	WRITELN();
	textcolor(4);
	WRITELN('                              -- Comment Jouer --');
	textcolor(7);
	WRITELN('       Après avoir séléctionner le mode de jeu au quel vous voulez ');
	WRITELN('       jouer, pour naviguer votre serpent il faudra vous aider des ');
	WRITELN('       flèches directionnels. Selon le mode de jeu choisis vous ');
	WRITELN('       avez la possibilité de passer à travers les murs, d''autre non.');
	WRITELN('       Quand il y a les murs dans le cadre, il ne faut en aucun cas');
	WRITELN('       entrer dans un des murs car cela vous fera perdre. Le but du');
	WRITELN('       jeu est de manger le plus de pomme, et ainsi grandir et avoir');
	WRITELN('       le plus de points possible, car celui la pourrait être parmis');
	WRITELN('       les 10 premiers meilleurs score du jeu.');

END;

////////////////////////////////Lancer jeu//////////////////////////////////////
PROCEDURE lancer_jeu;
BEGIN
	gotoxy(18,13);
	textcolor(4);
	WRITE('Saississez une touche pour commencer à jouer');
	gotoxy(1,1);
END;

/////////////////////////////Navigation Flèches/////////////////////////////////
{ x = toujours égal à 1;
  y = début de la liste par rapport au haut, numéro de la ligne à la quelle on commence;
  y_max = Fin de la liste par rapport au haut, numéro de la ligne à la quelle on finit les options
  opt_max = Le nombres d'options; opt_max = (y_max-y)+1
  }
FUNCTION deplacement(x, y,y_max,opt_max : INTEGER) : INTEGER;
VAR
    i,j,opt : INTEGER;
    fleches : CHAR;
    Ok : BOOLEAN;
BEGIN
  opt := 1;
  i := x;
  j := y;
  Ok := FALSE;
  fleches := #0;
  gotoxy(i,j); WRITE('>'); gotoxy(i+1,j); WRITE('<');
  WHILE (NOT Ok) DO BEGIN
    fleches := readkey;
    IF (fleches = #13) THEN BEGIN  //ENTER
    deplacement := opt;
    OK := TRUE;
    END;
    IF (fleches = #0) THEN BEGIN
      gotoxy(i,j); WRITE(' ');
      gotoxy (i+1,j); WRITE(' ');
      fleches := readkey;
      CASE (ord(fleches)) OF
        72 :  BEGIN {Flèche du haut, direction : bas}
                opt := opt-1;
                j := j-1;
              END;
        80 :  BEGIN {Flèche du bas, direction : haut}
                opt := opt+1;
                j := j+1;
              END;
      END;
    END;
    IF ( j = y_max+1 ) THEN BEGIN
      j := y;
      opt := 1;
    END;
    IF ( j = y-1 ) THEN BEGIN
      j := y_max;
      opt := opt_max
    END;
    gotoxy(i,j); WRITE('>'); gotoxy(i+1,j); WRITE('<');
  END;
  gotoxy(i,j); WRITE(' '); gotoxy(i+1,j); WRITE(' ');
END;

/////////////////////////////////menus//////////////////////////////////////////
PROCEDURE premier_ecr;
BEGIN
	textcolor(7);
	ClrScr;
	affi_serp_1;
	WRITELN();
	WRITELN();
	WRITELN();
	gotoxy(18,16);WRITELN('Saississez une touche pour accéder à l''accueil');
	gotoxy(1,25);
END;

PROCEDURE Bienvenue;
BEGIN
	textcolor(7);
  WRITELN('Bonjour et bienvenue dans le jeu du serpent');
END;

PROCEDURE sortie;
BEGIN
  ClrScr;
	textcolor(7);
	WRITELN();
	WRITELN();
	affi_serp_2;
	WRITELN();
	WRITELN();
	WRITELN();
  WRITELN('Merci d''avoir joué au serpent');
  WRITELN('Créé par David RIGAUX');
  halt;
END;

PROCEDURE affi_jouer;
BEGIN
	textcolor(7);
	affi_serp_2;
	WRITELN('Veuillez choisir rapidité avec la quelle vous voulez jouer :');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Lent');
	WRITELN('   2. Normal');
	WRITELN('   3. Rapide');
	WRITELN('   4. Très rapide');
	WRITELN('   5. Rapidité croissante');
	WRITELN('   6. Retour');
	WRITELN('   7. Quitter');
	WRITELN();
END;

PROCEDURE affi_modeJeu;
BEGIN
	textcolor(7);
	affi_serp_2;
	WRITELN('Veuillez choisir le mode de jeu avec le quel vous voulez jouer :');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Vous pouvez passer à travers le cadre');
	WRITELN('   2. Vous ne pouvez pas passer à travers le cadre');
	WRITELN('   3. Retour');
	WRITELN('   4. Quitter');
END;

PROCEDURE erreur_lecture;
BEGIN
	affi_serp_2;
	WRITELN();
	WRITELN('Une erreur c''est produite en lisant le fichier du classement.');
	WRITELN();
	WRITELN('Saississez une touche pour retourner au menu précédent...');
	readkey;
END;

PROCEDURE affiClassement_mode;
BEGIN
	WRITELN('*(CNT : Cadre Non Traversable, CT : Cadre traversable, M : Présence de murs');
	WRITELN('L : Lent, N : Normal, R : Rapide, TR : Très Rapide, C : Rapiditée croissante)');
END;

PROCEDURE affi_classement;
BEGIN
	ClrScr;
	textcolor(7);
	gotoxy(15,1);WRITELN('  ____ _                                         _   ');
	gotoxy(15,2);WRITELN(' / ___| | __ _ ___ ___  ___ _ __ ___   ___ _ __ | |_');
	gotoxy(15,3);WRITELN('| |   | |/ _` / __/ __|/ _ \ ''_ ` _ \ / _ \ ''_ \| __|');
	gotoxy(15,4);WRITELN('| |___| | (_| \__ \__ \  __/ | | | | |  __/ | | | |_');
	gotoxy(15,5);WRITELN(' \____|_|\__,_|___/___/\___|_| |_| |_|\___|_| |_|\__|');
END;

PROCEDURE affi_modeCadre;
BEGIN
	textcolor(7);
	affi_serp_2;
	WRITELN('Veuillez choisir le mode de jeu avec le quel vous voulez jouer :');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Cadre sans murs');
	WRITELN('   2. Cadre avec murs');
	WRITELN('   3. Retour à l''accueil');
	WRITELN('   4. Quitter');
END;

PROCEDURE affiMen_1;
BEGIN
	textcolor(7);
	affi_serp_2;
	Bienvenue;
	WRITELN('Veuillez choisir l''option que vous voulez :');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Jouer');
	WRITELN('   2. Comment jouer');
	WRITELN('   3. Classement');
	WRITELN('   4. Quitter');
	WRITELN();
END;

END.
