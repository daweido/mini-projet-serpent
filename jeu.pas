PROGRAM game;
uses
	crt,cadre_menu,serpent;

type
	coordonnees = record
		x,y : integer;
	end;
//////////////////////////////Menus/////////////////////////////////////////////
PROCEDURE accueil; Forward;

function aleatoire(): coordonnees;
var
	cord : coordonnees;
begin
	cord.x := (random(74)+4);
	cord.y := (random(20)+4);
	aleatoire := cord;
end;

procedure nourriture(cod : coordonnees);
begin
	gotoxy(cod.x,cod.y);
	write('*');
end;

procedure jouer_lent;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score : INTEGER;
begin
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire;
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire;
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
		      72 : snake.direction := 0;
					75 : snake.direction := 3;
					77 : snake.direction := 1;
		      80 : snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175);
	end;
	accueil;
end;

procedure jouer_normal;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score : INTEGER;
begin
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire;
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire;
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
		      72 : snake.direction := 0;
					75 : snake.direction := 3;
					77 : snake.direction := 1;
		      80 : snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(115);
	end;
	accueil;
end;

procedure jouer_rapide;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score : INTEGER;
begin
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire;
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire;
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
		      72 : snake.direction := 0;
					75 : snake.direction := 3;
					77 : snake.direction := 1;
		      80 : snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(100);
	end;
	accueil;
end;

procedure jouer_tresRapide;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score : INTEGER;
begin
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire;
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire;
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
		      72 : snake.direction := 0;
					75 : snake.direction := 3;
					77 : snake.direction := 1;
		      80 : snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(50);
	end;
	accueil;
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
procedure jouer;
	VAR
	  dep_1 : INTEGER;
	BEGIN
	  affi_jouer;
	  dep_1 := deplacement(1,3,9,7);
	  IF (dep_1 = 1) THEN BEGIN
	    jouer_lent;
	  END
	  ELSE IF (dep_1 = 2) THEN BEGIN
	    jouer_normal;
	  END
		ELSE IF (dep_1 = 3) THEN BEGIN
	    jouer_rapide;
	  END
		ELSE IF (dep_1 = 4) THEN BEGIN
	    jouer_tresRapide;
	  END
		ELSE IF (dep_1 = 5) THEN BEGIN
	    write('Rapidité croissante');
	  END
		ELSE IF (dep_1 = 6) THEN BEGIN
	    accueil;
	  END
	  ELSE sortie;
end;

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
	RANDOMIZE;
	premier_ecr;
	readkey;
	accueil;
END.
