PROGRAM game;
uses
	crt,cadre_menu,serpent;
//////////////////////////////Menus/////////////////////////////////////////////
PROCEDURE accueil; Forward;

procedure jouer;
var
	snake : viper;
begin
	affi_cadre;
	lancer_jeu;
	readkey;
	ClrScr;
	affi_cadre;
	snake := initialiser;
	affi_serpent(snake);
end;

procedure comment_jouer;
BEGIN
	affiCJ;
	writeln();
	writeln();
	writeln('Saississez une touche pour retourner à l''accueil');
	readkey;
	accueil;
END;

procedure accueil;
VAR
  dep_1 : INTEGER;
BEGIN
  affiMen_1;
  dep_1 := deplacement(1,4,6,3);
  IF (dep_1 = 1) THEN BEGIN
    jouer;
  END
  ELSE IF (dep_1 = 2) THEN BEGIN
    comment_jouer;
  END
  ELSE sortie;
END;

////////////////////////////////////////////////////////////////////////////////
BEGIN
	premier_ecr;
	readkey;
	accueil;
END.
