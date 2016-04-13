// Flèche du haut : 72
// Flèche de droite : 77
// Flèche du bas : 80
// Flèche de gauche 75
unit serpent;

interface

type pnoeud = ^noeud;
	noeud = record
		x, y: integer; // les coordonnées d’une case occupée
		suivant: pnoeud;
	end;

type viper = record
		taille: integer; // la taille actuelle du serpent
		direction: integer; // 0=up, 1=right, 2=down, 3=left
		tete: pnoeud; // la tete du serpent
	end;

function initialiser(): viper;
procedure affi_serpent(snake : viper);
function grandissement_corps(snake : viper) : viper;
FUNCTION collision_cadre(snake : viper): BOOLEAN;
function mouvement(snake : viper): viper;
function collision_corps(snake : viper) : boolean;


implementation
uses
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

procedure affi_serpent(snake : viper);
VAR
	i,x,y : integer;
begin
	i := 1;
	while (snake.tete <> nil) do begin
		x := snake.tete^.x;
		y := snake.tete^.y;
		gotoxy(x,y);
		if i = 1 then begin
			if snake.direction = 0 then write('^')
			else if snake.direction = 1 then write('>')
			else if snake.direction = 2 then write('v')
			else write('<');
		end
		else write('*');
		i := i+1;
		gotoxy(1,1);
		snake.tete := snake.tete^.suivant;
	end;
end;
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

function SupFin(liste : pnoeud) : pnoeud;
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

function mouvement(snake : viper): viper;
var
	x,y : integer;
begin
	x := snake.tete^.x;
	y := snake.tete^.y;
	snake.tete := SupFin(snake.tete);
	if snake.direction = 0 then snake.tete := AjoutTete(x,y-1,snake.tete)
	else if snake.direction = 1 then snake.tete := AjoutTete(x+1,y,snake.tete)
	else if snake.direction = 2 then snake.tete := AjoutTete(x,y+1,snake.tete)
	else snake.tete := AjoutTete(x-1,y,snake.tete);
	mouvement := snake;
end;
/////////////////////////////Mandry/////////////////////////////////////////////
function collision_corps(snake : viper) : boolean;
VAR
xb, yb : INTEGER;
colli : boolean;
begin
	colli := false;
	xb := snake.tete^.x;
	yb := snake.tete^.y;
	snake.tete := snake.tete^.suivant;
	IF (xb = snake.tete^.x) AND (yb = snake.tete^.y) THEN collision_corps := true;
	while snake.tete <> Nil DO Begin
		IF (xb = snake.tete^.x) AND (yb = snake.tete^.y) THEN begin
			colli := TRUE;
			break;
		end;
		snake.tete := snake.tete^.suivant;
	end;
	collision_corps := colli;
end;

function grandissement_corps(snake : viper) : viper;
VAR
	tmp1 : pnoeud;
	x,y : integer;
BEGIN
	tmp1 := snake.tete;
	while tmp1^.suivant <> nil do tmp1 := tmp1^.suivant;
	x := tmp1^.x;
	y := tmp1^.y;
	tmp1^.suivant := creerNoeud(x,y);
	snake.taille := snake.taille+1;
	grandissement_corps := snake;
end;

////////////////////////////////////Mehdi///////////////////////////////////////
FUNCTION collision_cadre(snake : viper): BOOLEAN;
begin
	IF (snake.tete^.x = 3) OR (snake.tete^.x = 78) OR (snake.tete^.y = 3) OR (snake.tete^.y = 24) THEN collision_cadre := true
	ELSE collision_cadre := false;
end;
////////////////////////////////////////////////////////////////////////////////
function initialiser(): viper;
var
	init : viper;
	tmp1, tmp2 : pnoeud;
	x,y : integer;
begin
	init.taille := 5;
	init.direction := 1;
	tmp1 := Nil;
  tmp2 := Nil;
	x := 36;
	y := 14;
	while (x <= 40) do begin
		tmp2 := creerNoeud(x,y);
		tmp2^.suivant := tmp1;
		tmp1 := tmp2;
		x := x+1
	end;
	init.tete := tmp2;
	initialiser := init;
end;

FUNCTION colision(snake : viper): BOOLEAN;
begin
	IF (snake.tete^.x = 2) OR
		 (snake.tete^.x = 78)OR
		 (snake.tete^.y = 3) OR
		 (snake.tete^.y = 25) THEN colision:= vrai;
		ELSE colision := faux;
end;

end.
