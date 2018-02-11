PROGRAM game;
USES
	crt,cadre_menu,serpent,classement;

TYPE
	coorDOnnees = RECORD
		x,y : INTEGER;
	END;
//////////////////////////////Menus/////////////////////////////////////////////
PROCEDURE accueil; Forward;
PROCEDURE jouer; Forward;
PROCEDURE modeJeu; Forward;
PROCEDURE modeCadre; Forward;

FUNCTION aleatoire(snake : viper): coorDOnnees;
VAR
	cord : coorDOnnees;
	test : pnoeud;
BEGIN
	test := snake.tete;
	cord.x := (ranDOm(74)+4);
	cord.y := (ranDOm(20)+4);
	WHILE test <> NIL DO BEGIN
		IF (cord.x = test^.x) AND (cord.y = test^.y) THEN BEGIN
			test := snake.tete;
			cord.x := (ranDOm(74)+4);
			cord.y := (ranDOm(20)+4);
		END;
		test := test^.suivant;
	END;
	aleatoire := cord;
END;

FUNCTION aleatoireMurs(snake : viper): coorDOnnees;
VAR
	cord : coorDOnnees;
	test : pnoeud;
	cond1, cond2, cond3, cond4, cond5, cond6, cond7 : Boolean;
BEGIN
	cond7 := false;
	test := snake.tete;
	WHILE (cond7 = False) DO BEGIN
		cord.x := (ranDOm(74)+4);
		cord.y := (ranDOm(20)+4);
		WHILE test <> nil DO BEGIN
			IF (cord.x = test^.x) and (cord.y = test^.y) THEN BEGIN
				test := snake.tete;
				cord.x := (ranDOm(74)+4);
				cord.y := (ranDOm(20)+4);
			END;
			test := test^.suivant;
		END;
		cond1 := (((cord.x > 20) and (cord.x < 27)) and (cord.y = 6)); //premiere ligne de gauche
		cond2 := ((cord.x = 21) and ((cord.y >= 6) and (cord.y <= 20))); // ligne vertical de gauche
		cond3 := ((cord.y = 20) and ((cord.x > 20 ) and (cord.x < 27))); //deuxieme ligne de gauche
		cond4 := (((cord.x > 54) and (cord.x < 61)) and (cord.y = 6)); // premiere ligne de droite
		cond5 := ((cord.x = 60) and ((cord.y >= 6) and (cord.y <= 20))); // ligne vertical de droite
		cond6 := ((cord.y = 20) and ((cord.x > 54) and (cord.x < 61))); //deuxieme ligne de droite
		IF not(cond1) or not(cond2) or not(cond3) or not(cond4) or not(cond5) or not(cond6) THEN cond7 := true;
	END;
	aleatoireMurs := cord;
END;

PROCEDURE nourriture(cod : coorDOnnees);
BEGIN
	textcolor(3);
	gotoxy(cod.x,cod.y);
	write('O');
END;

PROCEDURE gameOver(score : integer);
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
END;
///////////////////////////Jouer Collision Cadre////////////////////////////////
PROCEDURE jouer_lent;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
		      72 : IF snake.direction <> 2 THEN snake.direction := 0;
					75 : IF snake.direction <> 1 THEN snake.direction := 3;
					77 : IF snake.direction <> 3 THEN snake.direction := 1;
		      80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175);
	END;
	fin_jeu(score,'CNTL');
	gameOver(score);
END;

PROCEDURE jouer_croissant;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score,i : INTEGER;
BEGIN
	i := 0;
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			IF i < 165 THEN i := i + 15;
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175-i);
	END;
	fin_jeu(score,'CNTC');
	gameOver(score);
END;

PROCEDURE jouer_normal;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(115);
	END;
	fin_jeu(score,'CNTN');
	gameOver(score);
END;

PROCEDURE jouer_rapide;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(100);
	END;
	fin_jeu(score,'CNTR');
	gameOver(score);
END;

PROCEDURE jouer_tresRapide;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_cadre(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(50);
	END;
	fin_jeu(score,'CNTTR');
	gameOver(score);
END;
///////////////////////////////Jouer Murs///////////////////////////////////////
PROCEDURE jouer_lentMurs;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	WHILE (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoireMurs(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
		      72 : IF snake.direction <> 2 THEN snake.direction := 0;
					75 : IF snake.direction <> 1 THEN snake.direction := 3;
					77 : IF snake.direction <> 3 THEN snake.direction := 1;
		      80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175);
	END;
	fin_jeu(score,'ML');
	gameOver(score);
END;

PROCEDURE jouer_croissantMurs;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score,i : INTEGER;
BEGIN
	i := 0;
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	WHILE (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoireMurs(snake);
			IF i < 165 THEN i := i + 15;
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(175-i);
	END;
	fin_jeu(score,'MC');
	gameOver(score);
END;

PROCEDURE jouer_normalMurs;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	WHILE (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoireMurs(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(115);
	END;
	fin_jeu(score,'MN');
	gameOver(score);
END;

PROCEDURE jouer_rapideMurs;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	WHILE (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoireMurs(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(100);
	END;
	fin_jeu(score,'MR');
	gameOver(score);
END;

PROCEDURE jouer_tresRapideMurs;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre_murs(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoireMurs(snake);
	WHILE (collision_cadre_mod(snake) = FALSE) and (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre_murs(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoireMurs(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		affi_serpent(snake);
		delay(50);
	END;
	fin_jeu(score,'MTR');
	gameOver(score);
END;
///////////////////////////Jouer Non Collision Cadre////////////////////////////
PROCEDURE NCjouer_lent;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(175);
	END;
	fin_jeu(score,'CTL');
	gameOver(score);
END;

PROCEDURE NCjouer_croissant;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score,i : INTEGER;
BEGIN
	i := 0;
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			IF i < 165 THEN i := i + 15;
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(175-i);
	END;
	fin_jeu(score,'CTC');
	gameOver(score);
END;

PROCEDURE NCjouer_normal;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(115);
	END;
	fin_jeu(score,'CTN');
	gameOver(score);
END;

PROCEDURE NCjouer_rapide;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE  (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(100);
	END;
	fin_jeu(score,'CTR');
	gameOver(score);
END;

PROCEDURE NCjouer_tresRapide;
VAR
	snake : viper;
	mange : coorDOnnees;
	c : char;
	score : INTEGER;
BEGIN
	score := 0;
	affi_cadre(score);
	lancer_jeu;
	readkey;
	snake := initialiser;
	mange := aleatoire(snake);
	WHILE (collision_corps(snake) = FALSE) DO BEGIN
		c:=#0;
		ClrScr;
		affi_cadre(score);
		nourriture(mange);
		IF (mange.x = snake.tete^.x) and (mange.y = snake.tete^.y) THEN BEGIN
			mange := aleatoire(snake);
			score := score +1;
			snake := grandissement_corps(snake);
		END;
			IF keypressed THEN BEGIN
				c:=readkey;
				IF c=#0 THEN BEGIN c:=readkey;
				 CASE (ord(c)) OF
				 72 : IF snake.direction <> 2 THEN snake.direction := 0;
				 75 : IF snake.direction <> 1 THEN snake.direction := 3;
				 77 : IF snake.direction <> 3 THEN snake.direction := 1;
				 80 : IF snake.direction <> 0 THEN snake.direction := 2;
		      END;
				END;
			END;
		snake := mouvement(snake);
		snake.tete := Ncollision_cadre(snake);
		affi_serpent(snake);
		delay(50);
	END;
	fin_jeu(score,'CTTR');
	gameOver(score);
END;
////////////////////////////////////////////////////////////////////////////////
PROCEDURE comment_jouer;
BEGIN
	affiCJ;
	writeln();
	writeln();
	writeln('Saississez une touche pour retourner à l''accueil');
	readkey;
	accueil;
END;


PROCEDURE jouerMurs;
	VAR
	  dep_1 : INTEGER;
	BEGIN
	  affi_jouer;
	  dep_1 := deplacement(1,9,15,7);
	  IF (dep_1 = 1) THEN
	    jouer_lentMurs;
	  ELSE IF (dep_1 = 2) THEN
	    jouer_normalMurs;
		ELSE IF (dep_1 = 3) THEN
	    jouer_rapideMurs;
		ELSE IF (dep_1 = 4) THEN
	    jouer_tresRapideMurs;
		ELSE IF (dep_1 = 5) THEN
	    jouer_croissantMurs;
		ELSE IF (dep_1 = 6) THEN
	    modeCadre;
	  ELSE
			sortie;
END;

PROCEDURE jouerNC;
	VAR
	  dep_1 : INTEGER;
	BEGIN
	  affi_jouer;
	  dep_1 := deplacement(1,9,15,7);
	  IF (dep_1 = 1) THEN
	    NCjouer_lent;
	  ELSE IF (dep_1 = 2) THEN
	    NCjouer_normal;
		ELSE IF (dep_1 = 3) THEN
	    NCjouer_rapide;
		ELSE IF (dep_1 = 4) THEN
	    NCjouer_tresRapide;
		ELSE IF (dep_1 = 5) THEN
	    NCjouer_croissant;
		ELSE IF (dep_1 = 6) THEN
	    modeJeu;
	  ELSE
			sortie;
END;

PROCEDURE jouer;
	VAR
	  dep_1 : INTEGER;
	BEGIN
	  affi_jouer;
	  dep_1 := deplacement(1,9,15,7);
	  IF (dep_1 = 1) THEN
	    jouer_lent;
	  ELSE IF (dep_1 = 2) THEN
	    jouer_normal;
		ELSE IF (dep_1 = 3) THEN
	    jouer_rapide;
		ELSE IF (dep_1 = 4) THEN
	    jouer_tresRapide;
		ELSE IF (dep_1 = 5) THEN
	    jouer_croissant;
		ELSE IF (dep_1 = 6) THEN
	    modeJeu;
	  ELSE
			sortie;
END;

PROCEDURE modeJeu;
VAR
  dep_1 : INTEGER;
BEGIN
  affi_modeJeu;
  dep_1 := deplacement(1,9,12,4);
  IF (dep_1 = 1) THEN
    jouerNC;
  ELSE IF (dep_1 = 2) THEN
    jouer;
	ELSE IF (dep_1 = 3) THEN
    modeCadre;
  ELSE
		sortie;
END;


PROCEDURE modeCadre;
VAR
  dep_1 : INTEGER;
BEGIN
  affi_modeCadre;
  dep_1 := deplacement(1,9,12,4);
  IF (dep_1 = 1) THEN
    modeJeu;
  ELSE IF (dep_1 = 2) THEN
    jouerMurs;
	ELSE IF (dep_1 = 3) THEN
    accueil;
  ELSE
		sortie;
END;

PROCEDURE classement;
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

PROCEDURE accueil;
VAR
  dep_1 : INTEGER;
BEGIN
  affiMen_1;
  dep_1 := deplacement(1,10,13,4);
  IF (dep_1 = 1) THEN
    modeCadre;
  ELSE IF (dep_1 = 2) THEN
    comment_jouer;
	ELSE IF (dep_1 = 3) THEN
    classement;
  ELSE
		sortie;
END;

////////////////////////////////////////////////////////////////////////////////
BEGIN
	RANDOMIZE;
	premier_ecr;
	readkey;
	accueil;
END.
