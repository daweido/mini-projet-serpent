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


implementation
uses
	crt;
///////////////////////////////////Cadre////////////////////////////////////////
procedure affi_cadre(score : integer);
begin
	clrscr;
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
//////////////////////////////////////Jeu du Serpent////////////////////////////
procedure affi_serp();
begin
writeln('     _                  _         ____                             _');
writeln('    | | ___ _   _    __| |_   _  / ___|  ___ _ __ _ __   ___ _ __ | |_');
writeln(' _  | |/ _ \ | | |  / _` | | | | \___ \ / _ \ ''__| ''_ \ / _ \ ''_ \| __|');
writeln('| |_| |  __/ |_| | | (_| | |_| |  ___) |  __/ |  | |_) |  __/ | | | |_');
writeln(' \___/ \___|\__,_|  \__,_|\__,_| |____/ \___|_|  | .__/ \___|_| |_|\__|');
writeln('																								 |_|');
end;



{
  ____                         ___
 / ___| __ _ _ __ ___   ___   / _ \__   _____ _ __
| |  _ / _` | '_ ` _ \ / _ \ | | | \ \ / / _ \ '__|
| |_| | (_| | | | | | |  __/ | |_| |\ V /  __/ |
 \____|\__,_|_| |_| |_|\___|  \___/  \_/ \___|_|


 ____              _
|  _ \ ___ _ __ __| |_   _
| |_) / _ \ '__/ _` | | | |
|  __/  __/ | | (_| | |_| |
|_|   \___|_|  \__,_|\__,_|
                           
                                                   }
//////////////////////////////////////Commnet Jouer/////////////////////////////
// Taille terminal horizontal : 80 charactères
// Taille terminal vertical : 26 lignes
procedure affiCJ;
BEGIN
	ClrScr;
	WRITELN();
	writeln('                              -- Comment Jouer --');
	writeln('   Voici commet on joue etc etc etc etc etc etc etc etc etc ');
	writeln('   Voici commet on joue etc etc etc etc etc etc etc etc etc ');
	writeln('   Voici commet on joue etc etc etc etc etc etc etc etc etc ');
	writeln('   Voici commet on joue etc etc etc etc etc etc etc etc etc ');
	writeln('   Voici commet on joue etc etc etc etc etc etc etc etc etc ');
	writeln('   Voici commet on joue etc etc etc etc etc etc etc etc etc ');

END;
////////////////////////////////Lancer jeu//////////////////////////////////////
procedure lancer_jeu;
BEGIN
	gotoxy(18,13);
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
	ClrScr;
	affi_serp;
	writeln();
	writeln();
	writeln();
	writeln('Saississez une touche pour accéder à l''accueil');
end;

PROCEDURE Bienvenue;
BEGIN
  ClrScr;
  WRITELN('Bonjour et bienvenue dans le jeu du serpent');
END;

PROCEDURE sortie;
BEGIN
  ClrScr;
  WRITELN('Merci d''avoir joué au serpent');
  WRITELN('Créé par David RIGAUX');
  halt;
END;

procedure affi_jouer;
begin
	ClrScr;
	WRITELN('Veuillez choisir rapidité avec la quelle vous voulez jouer :');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Lent');
	WRITELN('   2. Normal');
	WRITELN('   3. Rapide');
	WRITELN('   4. Très rapide');
	WRITELN('   5. Rapidité croissante');
	WRITELN('   6. Retour à l''accueil');
	WRITELN('   7. Quitter');
	WRITELN();
end;
procedure affiMen_1;
BEGIN
	Bienvenue;
	WRITELN('Veuillez choisir l''option que vous voulez:');
	WRITELN('(Navigation faite à l''aide des flèches ainsi que le touche ENTER)');
	WRITELN('   1. Jouer');
	WRITELN('   2. Comment jouer');
	WRITELN('   3. Quitter');
	WRITELN();
	END;
END.
