unit cadre_menu;

interface

procedure affi_cadre(score : integer);
procedure affiCJ;
FUNCTION deplacement(x, y,y_max,opt_max : INTEGER) : INTEGER;
PROCEDURE Bienvenue;
PROCEDURE sortie;
procedure affiMen_1;
procedure lancer_jeu;
procedure affi_jouer;
procedure premier_ecr;
PROCEDURE affi_gameOver(score : INTEGER);
procedure affi_modeJeu;
procedure affi_cadre_murs(score : integer);
procedure affi_modeCadre;
PROCEDURE affi_gameOverHS(score : INTEGER);
procedure affi_classement;
procedure affi_serp_2();
procedure affiClassement_mode;







implementation
uses
	crt;
///////////////////////////////////Cadre////////////////////////////////////////
procedure affi_cadre(score : integer);
begin
	clrscr;
	textcolor(10);
	writeln('                                  Score : ',score);
	writeln();
	writeln('  ____________________________________________________________________________');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  ----------------------------------------------------------------------------');
end;


procedure affi_cadre_murs(score : integer);
begin
	clrscr;
	textcolor(10);
	writeln('                                  Score : ',score);
	writeln();
	writeln('  ____________________________________________________________________________');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                 ._____                           ______.                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |                                      |                 |');
	writeln('  |                 |_____                            _____|                 |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  |                                                                          |');
	writeln('  ----------------------------------------------------------------------------');
end;
//////////////////////////////////////Jeu du Serpent////////////////////////////
procedure affi_serp_1();
begin
gotoxy(6,7); writeln('     _                  _         ____                             _');
gotoxy(6,8); writeln('    | | ___ _   _    __| |_   _  / ___|  ___ _ __ _ __   ___ _ __ | |_');
gotoxy(6,9); writeln(' _  | |/ _ \ | | |  / _` | | | | \___ \ / _ \ ''__| ''_ \ / _ \ ''_ \| __|');
gotoxy(6,10); writeln('| |_| |  __/ |_| | | (_| | |_| |  ___) |  __/ |  | |_) |  __/ | | | |_');
gotoxy(6,11); writeln(' \___/ \___|\__,_|  \__,_|\__,_| |____/ \___|_|  | .__/ \___|_| |_|\__|');
gotoxy(6,12); writeln('																			      |_|');
end;

procedure affi_serp_2();
begin
	ClrScr;
gotoxy(6,1); writeln('     _                  _         ____                             _');
gotoxy(6,2); writeln('    | | ___ _   _    __| |_   _  / ___|  ___ _ __ _ __   ___ _ __ | |_');
gotoxy(6,3); writeln(' _  | |/ _ \ | | |  / _` | | | | \___ \ / _ \ ''__| ''_ \ / _ \ ''_ \| __|');
gotoxy(6,4); writeln('| |_| |  __/ |_| | | (_| | |_| |  ___) |  __/ |  | |_) |  __/ | | | |_');
gotoxy(6,5); writeln(' \___/ \___|\__,_|  \__,_|\__,_| |____/ \___|_|  | .__/ \___|_| |_|\__|');
gotoxy(6,6); writeln('																			      |_|');
end;


PROCEDURE affi_gameOver(score : INTEGER);
begin
	clrscr;
	textcolor(7);
	gotoxy(15,3); writeln('  ____                         ___');
	gotoxy(15,4); writeln(' / ___| __ _ _ __ ___   ___   / _ \__   _____ _ __');
	gotoxy(15,5); writeln('| |  _ / _` | ''_ ` _ \ / _ \ | | | \ \ / / _ \ ''__|');
	gotoxy(15,6); writeln('| |_| | (_| | | | | | |  __/ | |_| |\ V /  __/ |');
	gotoxy(15,7); writeln(' \____|\__,_|_| |_| |_|\___|  \___/  \_/ \___|_|');
	WRITELN();
	writeln('Vous avez perdu avec un score de : ',score);
	WRITELN('Veuillez choisir l''option que vous voulez :');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Rejouer');
	WRITELN('   2. Retour à l''accueil');
	WRITELN('   3. Quitter');
end;

PROCEDURE affi_gameOverHS(score : INTEGER);
begin
	clrscr;
	textcolor(7);
	gotoxy(15,3); writeln('  ____                         ___');
	gotoxy(15,4); writeln(' / ___| __ _ _ __ ___   ___   / _ \__   _____ _ __');
	gotoxy(15,5); writeln('| |  _ / _` | ''_ ` _ \ / _ \ | | | \ \ / / _ \ ''__|');
	gotoxy(15,6); writeln('| |_| | (_| | | | | | |  __/ | |_| |\ V /  __/ |');
	gotoxy(15,7); writeln(' \____|\__,_|_| |_| |_|\___|  \___/  \_/ \___|_|');
	WRITELN();
	writeln('Vous avez perdu avec un score de : ',score);
	writeln();
end;
//////////////////////////////////////Commnet Jouer/////////////////////////////
// Taille terminal horizontal : 80 charactères
// Taille terminal vertical : 26 lignes
procedure affiCJ;
BEGIN
	affi_serp_2;
	WRITELN();
	textcolor(4);
	writeln('                              -- Comment Jouer --');
	textcolor(7);
	writeln('       Après avoir séléctionner le mode de jeu au quel vous voulez ');
	writeln('       jouer, pour naviguer votre serpent il faudra vous aider des ');
	writeln('       flèches directionnels. Selon le mode de jeu choisis vous ');
	writeln('       avez la possibilité de passer à travers les murs, d''autre non.');
	writeln('       Quand il y a les murs dans le cadre, il ne faut en aucun cas');
	writeln('       entrer dans un des murs car cela vous fera perdre. Le but du');
	writeln('       jeu est de manger le plus de pomme, et ainsi grandir et avoir');
	writeln('       le plus de points possible, car celui la pourrait être parmis');
	writeln('       les 10 premiers meilleurs score du jeu.');



END;
////////////////////////////////Lancer jeu//////////////////////////////////////
procedure lancer_jeu;
BEGIN
	gotoxy(18,13);
	textcolor(4);
	write('Saississez une touche pour commencer à jouer');
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
begin
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
procedure premier_ecr;
begin
	textcolor(7);
	ClrScr;
	affi_serp_1;
	writeln();
	writeln();
	writeln();
	gotoxy(18,16);writeln('Saississez une touche pour accéder à l''accueil');
	gotoxy(1,25);
end;

PROCEDURE Bienvenue;
BEGIN
	textcolor(7);
  WRITELN('Bonjour et bienvenue dans le jeu du serpent');
END;

PROCEDURE sortie;
BEGIN
  ClrScr;
	textcolor(7);
	writeln();
	writeln();
	affi_serp_2;
	writeln();
	writeln();
	writeln();
  WRITELN('Merci d''avoir joué au serpent');
  WRITELN('Créé par David RIGAUX');
  halt;
END;

procedure affi_jouer;
begin
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
end;

procedure affi_modeJeu;
begin
textcolor(7);
affi_serp_2;
WRITELN('Veuillez choisir le mode de jeu avec le quel vous voulez jouer :');
WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
WRITELN('   1. Vous pouvez passer à travers le cadre');
WRITELN('   2. Vous ne pouvez pas passer à travers le cadre');
WRITELN('   3. Retour');
WRITELN('   4. Quitter');
end;

procedure erreur_lecture;
begin
	affi_serp_2;
	writeln();
	writeln('Une erreur c''est produite en lisant le fichier du classement.');
	writeln();
	writeln('Saississez une touche pour retourner au menu précédent...');
	readkey;
end;

procedure affiClassement_mode;
begin
	writeln('*(CNT : Cadre Non Traversable, CT : Cadre traversable, M : Présence de murs');
	writeln('L : Lent, N : Normal, R : Rapide, TR : Très Rapide, C : Rapiditée croissante)');

end;
procedure affi_classement;
begin
clrscr;
textcolor(7);
gotoxy(15,1);writeln('  ____ _                                         _   ');
gotoxy(15,2);writeln(' / ___| | __ _ ___ ___  ___ _ __ ___   ___ _ __ | |_');
gotoxy(15,3);writeln('| |   | |/ _` / __/ __|/ _ \ ''_ ` _ \ / _ \ ''_ \| __|');
gotoxy(15,4);writeln('| |___| | (_| \__ \__ \  __/ | | | | |  __/ | | | |_');
gotoxy(15,5);writeln(' \____|_|\__,_|___/___/\___|_| |_| |_|\___|_| |_|\__|');

end;

procedure affi_modeCadre;
begin
textcolor(7);
affi_serp_2;
WRITELN('Veuillez choisir le mode de jeu avec le quel vous voulez jouer :');
WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
WRITELN('   1. Cadre sans murs');
WRITELN('   2. Cadre avec murs');
WRITELN('   3. Retour à l''accueil');
WRITELN('   4. Quitter');
end;

procedure affiMen_1;
BEGIN
	textcolor(7);
	affi_serp_2;
	Bienvenue;
	WRITELN('Veuillez choisir l''option que vous voulez :');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Jouer');
	WRITELN('   2. Comment jouer');
	writeln('   3. Classement');
	WRITELN('   4. Quitter');
	WRITELN();
	END;
END.
