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
	i,x,y,longueur : integer;
begin
	i := 1;
	while (snake.tete <> nil) do begin
		x := snake.tete^.x;
		y := snake.tete^.y;
		gotoxy(x,y);
		if i = 1 then begin
			if snake.direction = 0 then write('^')
			else if snake.direction = 1 then write('>')
			else if snake.direction = 2 then write('è')
			else write('<');
		end
		else write('*');
		i := i+1;
		snake.tete := snake.tete^.suivant;
	end;
end;

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

end.
