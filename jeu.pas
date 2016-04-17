PROGRAM game;
uses
	crt,cadre_menu,serpent,classement;

type
	coordonnees = record
		x,y : integer;
	end;
//////////////////////////////Menus/////////////////////////////////////////////
PROCEDURE accueil; Forward;
procedure jouer; Forward;
procedure modeJeu; Forward;
procedure modeCadre; Forward;

function aleatoire(snake : viper): coordonnees;
var
	cord : coordonnees;
	test : pnoeud;
begin
	test := snake.tete;
	cord.x := (random(74)+4);
	cord.y := (random(20)+4);
	while test <> nil do begin
		if (cord.x = test^.x) and (cord.y = test^.y) then begin
			test := snake.tete;
			cord.x := (random(74)+4);
			cord.y := (random(20)+4);
		end;
		test := test^.suivant;
	end;
	aleatoire := cord;
end;

function aleatoireMurs(snake : viper): coordonnees;
var
	cord : coordonnees;
	test : pnoeud;
	cond1, cond2, cond3, cond4, cond5, cond6, cond7 : Boolean;
begin
	cond7 := false;
	test := snake.tete;
	while (cond7 = False) do begin
		cord.x := (random(74)+4);
		cord.y := (random(20)+4);
		while test <> nil do begin
			if (cord.x = test^.x) and (cord.y = test^.y) then begin
				test := snake.tete;
				cord.x := (random(74)+4);
				cord.y := (random(20)+4);
			end;
			test := test^.suivant;
		end;
		cond1 := (((cord.x > 20) and (cord.x < 27)) and (cord.y = 6)); //premiere ligne de gauche
		cond2 := ((cord.x = 21) and ((cord.y >= 6) and (cord.y <= 20))); // ligne vertical de gauche
		cond3 := ((cord.y = 20) and ((cord.x > 20 ) and (cord.x < 27))); //deuxieme ligne de gauche
		cond4 := (((cord.x > 54) and (cord.x < 61)) and (cord.y = 6)); // premiere ligne de droite
		cond5 := ((cord.x = 60) and ((cord.y >= 6) and (cord.y <= 20))); // ligne vertical de droite
		cond6 := ((cord.y = 20) and ((cord.x > 54) and (cord.x < 61))); //deuxieme ligne de droite
		if not(cond1) or not(cond2) or not(cond3) or not(cond4) or not(cond5) or not(cond6) then cond7 := true;
	end;
	aleatoireMurs := cord;
end;

procedure nourriture(cod : coordonnees);
begin
	textcolor(3);
	gotoxy(cod.x,cod.y);
	write('O');
end;

procedure gameOver(score : integer);
	VAR
	  dep_1 : INTEGER;
	BEGIN
	  affi_gameOver(score);
	  dep_1 := deplacement(1,12,14,3);
	  IF (dep_1 = 1) THEN BEGIN
	    modeCadre;
	  END
	  ELSE IF (dep_1 = 2) THEN BEGIN
	    accueil;
	  END
	  ELSE sortie;
end;
///////////////////////////Jouer Collision Cadre////////////////////////////////
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
	mange := aleatoire(snake);
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
		      72 : if snake.direction <> 2 then snake.direction := 0;
					75 : if snake.direction <> 1 then snake.direction := 3;
					77 : if snake.direction <> 3 then snake.direction := 1;
		      80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175);
	end;
	fin_jeu(score,'CNTL');
	gameOver(score);
end;

procedure jouer_croissant;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score,i : INTEGER;
begin
	i := 0;
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			if i < 165 then i := i + 15;
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175-i);
	end;
	fin_jeu(score,'CNTC');
	gameOver(score);
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
	mange := aleatoire(snake);
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(115);
	end;
	fin_jeu(score,'CNTN');
	gameOver(score);
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
	mange := aleatoire(snake);
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(100);
	end;
	fin_jeu(score,'CNTR');
	gameOver(score);
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
	mange := aleatoire(snake);
	while (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(50);
	end;
	fin_jeu(score,'CNTTR');
	gameOver(score);
end;
///////////////////////////////Jouer Murs///////////////////////////////////////
procedure jouer_lentMurs;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score : INTEGER;
begin
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	while (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoireMurs(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
		      72 : if snake.direction <> 2 then snake.direction := 0;
					75 : if snake.direction <> 1 then snake.direction := 3;
					77 : if snake.direction <> 3 then snake.direction := 1;
		      80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175);
	end;
	fin_jeu(score,'ML');
	gameOver(score);
end;

procedure jouer_croissantMurs;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score,i : INTEGER;
begin
	i := 0;
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	while (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoireMurs(snake);
			if i < 165 then i := i + 15;
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175-i);
	end;
	fin_jeu(score,'MC');
	gameOver(score);
end;

procedure jouer_normalMurs;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score : INTEGER;
begin
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	while (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoireMurs(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(115);
	end;
	fin_jeu(score,'MN');
	gameOver(score);
end;

procedure jouer_rapideMurs;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score : INTEGER;
begin
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	while (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoireMurs(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(100);
	end;
	fin_jeu(score,'MR');
	gameOver(score);
end;

procedure jouer_tresRapideMurs;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score : INTEGER;
begin
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	while (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoireMurs(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(50);
	end;
	fin_jeu(score,'MTR');
	gameOver(score);
end;
///////////////////////////Jouer Non Collision Cadre////////////////////////////
procedure NCjouer_lent;
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
	mange := aleatoire(snake);
	while (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(175);
	end;
	fin_jeu(score,'CTL');
	gameOver(score);
end;

procedure NCjouer_croissant;
var
	snake : viper;
	mange : coordonnees;
	c : char;
	score,i : INTEGER;
begin
	i := 0;
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	while (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			if i < 165 then i := i + 15;
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(175-i);
	end;
	fin_jeu(score,'CTC');
	gameOver(score);
end;

procedure NCjouer_normal;
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
	mange := aleatoire(snake);
	while (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(115);
	end;
	fin_jeu(score,'CTN');
	gameOver(score);
end;

procedure NCjouer_rapide;
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
	mange := aleatoire(snake);
	while  (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(100);
	end;
	fin_jeu(score,'CTR');
	gameOver(score);
end;

procedure NCjouer_tresRapide;
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
	mange := aleatoire(snake);
	while (collision_corps(snake) = FALSE) do begin
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		if (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) then begin
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		end;
			if keypressed then begin
				c:=readkey;
				if c=#0 then begin c:=readkey;
				 CASE (ord(c)) OF
				 72 : if snake.direction <> 2 then snake.direction := 0;
				 75 : if snake.direction <> 1 then snake.direction := 3;
				 77 : if snake.direction <> 3 then snake.direction := 1;
				 80 : if snake.direction <> 0 then snake.direction := 2;
		      END;
				end;
			end;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(50);
	end;
	fin_jeu(score,'CTTR');
	gameOver(score);
end;
////////////////////////////////////////////////////////////////////////////////
procedure comment_jouer;
BEGIN
	affiCJ;
	writeln();
	writeln();
	writeln('Saississez une touche pour retourner à l''accueil');
	readkey;
	accueil;
END;


procedure jouerMurs;
	VAR
	  dep_1 : INTEGER;
	BEGIN
	  affi_jouer;
	  dep_1 := deplacement(1,9,15,7);
	  IF (dep_1 = 1) THEN BEGIN
	    jouer_lentMurs;
	  END
	  ELSE IF (dep_1 = 2) THEN BEGIN
	    jouer_normalMurs;
	  END
		ELSE IF (dep_1 = 3) THEN BEGIN
	    jouer_rapideMurs;
	  END
		ELSE IF (dep_1 = 4) THEN BEGIN
	    jouer_tresRapideMurs;
	  END
		ELSE IF (dep_1 = 5) THEN BEGIN
	    jouer_croissantMurs;
	  END
		ELSE IF (dep_1 = 6) THEN BEGIN
	    modeCadre;
	  END
	  ELSE sortie;
end;

procedure jouerNC;
	VAR
	  dep_1 : INTEGER;
	BEGIN
	  affi_jouer;
	  dep_1 := deplacement(1,9,15,7);
	  IF (dep_1 = 1) THEN BEGIN
	    NCjouer_lent;
	  END
	  ELSE IF (dep_1 = 2) THEN BEGIN
	    NCjouer_normal;
	  END
		ELSE IF (dep_1 = 3) THEN BEGIN
	    NCjouer_rapide;
	  END
		ELSE IF (dep_1 = 4) THEN BEGIN
	    NCjouer_tresRapide;
	  END
		ELSE IF (dep_1 = 5) THEN BEGIN
	    NCjouer_croissant;
	  END
		ELSE IF (dep_1 = 6) THEN BEGIN
	    modeJeu;
	  END
	  ELSE sortie;
end;

procedure jouer;
	VAR
	  dep_1 : INTEGER;
	BEGIN
	  affi_jouer;
	  dep_1 := deplacement(1,9,15,7);
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
	    jouer_croissant;
	  END
		ELSE IF (dep_1 = 6) THEN BEGIN
	    modeJeu;
	  END
	  ELSE sortie;
end;

procedure modeJeu;
VAR
  dep_1 : INTEGER;
BEGIN
  affi_modeJeu;
  dep_1 := deplacement(1,9,12,4);
  IF (dep_1 = 1) THEN BEGIN
    jouerNC;
  END
  ELSE IF (dep_1 = 2) THEN BEGIN
    jouer;
  END
	ELSE IF (dep_1 = 3) THEN BEGIN
    modeCadre;
  END
  ELSE sortie;
END;


procedure modeCadre;
VAR
  dep_1 : INTEGER;
BEGIN
  affi_modeCadre;
  dep_1 := deplacement(1,9,12,4);
  IF (dep_1 = 1) THEN BEGIN
    modeJeu;
  END
  ELSE IF (dep_1 = 2) THEN BEGIN
    jouerMurs;
  END
	ELSE IF (dep_1 = 3) THEN BEGIN
    accueil;
  END
  ELSE sortie;
END;

procedure classement;
BEGIN
  affi_classement;
	writeln();
	writeln();
	affichage_complet;
	writeln();
	writeln('Saississez une touche pour retourner au menu principal');
	readkey;
	accueil;
END;

procedure accueil;
VAR
  dep_1 : INTEGER;
BEGIN
  affiMen_1;
  dep_1 := deplacement(1,10,13,4);
  IF (dep_1 = 1) THEN BEGIN
    modeCadre;
  END
  ELSE IF (dep_1 = 2) THEN BEGIN
    comment_jouer;
  END
	ELSE IF (dep_1 = 3) THEN BEGIN
    classement;
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
