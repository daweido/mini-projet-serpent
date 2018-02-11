// Flèche du haut : 72
// Flèche de droite : 77
// Flèche du bas : 80
// Flèche de gauche 75
UNIT serpent;

INTERFACE

TYPE pnoeud = ^noeud;
	noeud = RECORD
		x, y: integer; // les coordonnées d’une case occupée
		suivant: pnoeud;
	END;

TYPE viper = RECORD
		taille: integer; // la taille actuelle du serpent
		direction: integer; // 0=up, 1=right, 2=down, 3=left
		tete: pnoeud; // la tete du serpent
	END;

FUNCTION initialiser(): viper;
PROCEDURE affi_serpent(snake : viper);
FUNCTION grandissement_corps(snake : viper) : viper;
FUNCTION collision_cadre(snake : viper): BOOLEAN;
FUNCTION mouvement(snake : viper): viper;
FUNCTION collision_corps(snake : viper) : boolean;
FUNCTION Ncollision_cadre(snake : viper): pnoeud;
FUNCTION collision_cadre_mod(snake : viper): BOOLEAN;


IMPLEMENTATION
USES
	crt;

FUNCTION creerNoeud (x,y : INTEGER) : pnoeud;
VAR
  nv : pnoeud;
BEGIN
  new(nv);
  nv^.x := x;
	nv^.y := y;
  nv^.suivant := Nil;
  creerNoeud := nv;
END;

PROCEDURE affi_serpent(snake : viper);
VAR
	i,x,y : integer;
BEGIN
	i := 1;
	textcolor(15);
	WHILE (snake.tete <> NIL) DO BEGIN
		x := snake.tete^.x;
		y := snake.tete^.y;
		gotoxy(x,y);
		IF i = 1 THEN BEGIN
			IF snake.direction = 0 THEN write('^')
			ELSE IF snake.direction = 1 THEN write('>')
			ELSE IF snake.direction = 2 THEN write('v')
			ELSE write('<');
		END
		ELSE write('*');
		i := i+1;
		gotoxy(1,1);
		snake.tete := snake.tete^.suivant;
	END;
END;


//////////////////////////////Maxime////////////////////////////////////////////
FUNCTION AjoutTete(x, y : integer; tete : pnoeud) : pnoeud;
VAR
    tmp : pnoeud;
BEGIN
    tmp := creerNoeud(x,y);
    tmp^.suivant := tete;
    tete := tmp;
    AjoutTete := tete;
END;

FUNCTION SupFin(liste : pnoeud) : pnoeud;
VAR
  tmp1,tmp : pnoeud;
  n,l : integer;
BEGIN
  tmp := liste;
  tmp1 := liste;
  n := 0;
  l := 0;
  WHILE (tmp^.suivant <> Nil) DO BEGIN
    n := n+1;
    tmp := tmp^.suivant;
  END;
  REPEAT
  l := l+1;
  tmp1 := tmp1^.suivant;
  UNTIL (l = n-1);
  tmp1^.suivant := NIL;
  dispose(tmp);
  SupFin := liste;
END;

FUNCTION mouvement(snake : viper): viper;
VAR
	x,y : integer;
BEGIN
	x := snake.tete^.x;
	y := snake.tete^.y;
	snake.tete := SupFin(snake.tete);
	IF snake.direction = 0 THEN
		snake.tete := AjoutTete(x,y-1,snake.tete)
	ELSE IF snake.direction = 1 THEN
		snake.tete := AjoutTete(x+1,y,snake.tete)
	ELSE IF snake.direction = 2 THEN
		snake.tete := AjoutTete(x,y+1,snake.tete)
	ELSE
		snake.tete := AjoutTete(x-1,y,snake.tete);
	mouvement := snake;
END;

////////////////////////////////////Collisions///////////////////////////////////////
FUNCTION collision_cadre(snake : viper): BOOLEAN;
BEGIN
	IF (snake.tete^.x = 3) OR (snake.tete^.x = 78) OR (snake.tete^.y = 3) OR (snake.tete^.y = 24) THEN
		collision_cadre := true
	ELSE
		collision_cadre := false;
END;

FUNCTION collision_cadre_mod(snake : viper): BOOLEAN;
VAR
cond1, cond2, cond3, cond4, cond5, cond6, cond7, cond8, cond9, cond10 : boolean;
BEGIN
	cond1 := (snake.tete^.x = 3); // cadre de base
	cond2 := (snake.tete^.x = 78); // cadre de base
	cond3 := (snake.tete^.y = 3); // cadre de base
	cond4 := (snake.tete^.y = 24); // cadre de base
	cond5 := (((snake.tete^.x > 20) and (snake.tete^.x < 27)) and (snake.tete^.y = 6)); //premiere ligne de gauche
	cond6 := ((snake.tete^.x = 21) and ((snake.tete^.y >= 6) and (snake.tete^.y <= 20))); // ligne vertical de gauche
	cond7 := ((snake.tete^.y = 20) and ((snake.tete^.x > 20 ) and (snake.tete^.x < 27))); //deuxieme ligne de gauche
	cond8 := (((snake.tete^.x > 54) and (snake.tete^.x < 61)) and (snake.tete^.y = 6)); // premiere ligne de droite
	cond9 := ((snake.tete^.x = 60) and ((snake.tete^.y >= 6) and (snake.tete^.y <= 20))); // ligne vertical de droite
	cond10 := ((snake.tete^.y = 20) and ((snake.tete^.x > 54) and (snake.tete^.x < 61))); //deuxieme ligne de droite

	IF cond1 or cond2 or cond3 or cond4 or cond5 or cond6 or cond7 or cond8 or cond9 or cond10 THEN
		collision_cadre_mod := true
	ELSE
		collision_cadre_mod := false;
END;

FUNCTION Ncollision_cadre(snake : viper): pnoeud;
BEGIN
	IF (snake.tete^.x = 3) THEN
		snake.tete^.x := 77;
	If (snake.tete^.x = 78) THEN
		snake.tete^.x := 4;
	IF (snake.tete^.y = 3) THEN
		snake.tete^.y := 23;
	IF (snake.tete^.y = 24) THEN
		snake.tete^.y := 4;
	Ncollision_cadre := snake.tete
END;

FUNCTION collision_corps(snake : viper) : boolean;
VAR
xb, yb : INTEGER;
colli : boolean;
BEGIN
	colli := false;
	xb := snake.tete^.x;
	yb := snake.tete^.y;
	snake.tete := snake.tete^.suivant;
	IF (xb = snake.tete^.x) AND (yb = snake.tete^.y) THEN
		collision_corps := true;
	WHILE snake.tete <> Nil DO BEGIN
		IF (xb = snake.tete^.x) AND (yb = snake.tete^.y) THEN BEGIN
			colli := TRUE;
			break;
		END;
		snake.tete := snake.tete^.suivant;
	END;
	collision_corps := colli;
END;

/////////////////////////////Corps du Serpent///////////////////////////////////
FUNCTION initialiser(): viper;
VAR
	init : viper;
	tmp1, tmp2 : pnoeud;
	x,y : integer;
BEGIN
	init.taille := 5;
	init.direction := 1;
	tmp1 := Nil;
  tmp2 := Nil;
	x := 36;
	y := 14;
	WHILE (x <= 40) do BEGIN
		tmp2 := creerNoeud(x,y);
		tmp2^.suivant := tmp1;
		tmp1 := tmp2;
		x := x+1
	END;
	init.tete := tmp2;
	initialiser := init;
END;

FUNCTION grandissement_corps(snake : viper) : viper;
VAR
	tmp1 : pnoeud;
	x,y : integer;
BEGIN
	tmp1 := snake.tete;
	WHILE tmp1^.suivant <> nil do tmp1 := tmp1^.suivant;
	x := tmp1^.x;
	y := tmp1^.y;
	tmp1^.suivant := creerNoeud(x,y);
	snake.taille := snake.taille+1;
	grandissement_corps := snake;
END;

END.
