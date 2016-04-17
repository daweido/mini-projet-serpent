unit classement;
{$mode objfpc}

interface

procedure affichage_complet;
procedure fin_jeu(score : integer;modeDuJeu : string);



implementation
uses
	sysutils,cadre_menu,crt;

type highscore = record
		table : ARRAY[1..10,1..4] OF string;
		points : ARRAY[1..10] OF INTEGER;
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

procedure erreur_reecriture;
begin
	writeln();
	writeln('Une erreur c''est produite lors de la réécriture du classement dans le fichier.');
	writeln();
	writeln('Saississez une touche pour retourner au menu précédent...');
	readkey;
end;

function recup_lowest(): string;
var
	Fichier : TextFile;
	lowest, score : string;
	i : integer;
begin
	lowest :='';
	score := '';
	assignFile(fichier,'classement.txt');
	{$I+}
	try
		reset(fichier);
		readln(fichier,lowest);
		closeFile(fichier);
	except
		on E: EInOutError do
		begin
			erreur_lecture;
		end;
	end;
	i := 1;
	repeat
		score := score + lowest[i];
		i := i+1;
	until (lowest[i] = ' ');
	recup_lowest := score;
end;

procedure reecriture_classement(ordre : highscore);
var
	Fichier : TextFile;
	i : integer;
begin
	assignFile(fichier,'classement.txt');
	{$I+}
	try
		rewrite(fichier);
		for i := 10 downto 1 do begin
			write(fichier, ordre.table[i,3],' ');
			write(fichier, ordre.table[i,2],' ');
			writeln(fichier, ordre.table[i,4],' ');
		end;
		closeFile(fichier);
	except
		on E: EInOutError do
		begin
			erreur_reecriture;
		end;
	end;
end;


function inHighscore(low,score:integer): boolean;
begin
	if low < score then inHighscore := true
	else inHighscore := false;
end;

function espEnPlus(ordre : highscore;i : integer): STRING;
var
	esp : string;
	l,p : integer;
begin
	esp := '';
	l := length(ordre.table[i,3]);
	for p := 1 to 10-l do esp := esp+' ';
	espEnPlus := esp;
end;
procedure affi_table(ordre : highscore;u : integer);
var
	i,x,y : integer;
	esp : string;
begin
	esp := '';
	textcolor(4);
	for i := 1 to u do esp := esp + ' ';
	writeln('                  N°  Surnoms',esp,'Score   Mode de Jeu*');
	for i := 1 to 10 do begin
			textcolor(10);
			if ordre.table[i,1] = '10' then write('                  ',ordre.table[i,1],'. ')
			else write('                  ',ordre.table[i,1],'.  ');
			write(ordre.table[i,2]);
			textcolor(15);
			if i = 1 then begin
				x := WhereX;
				y := WhereY;
				write(ordre.table[i,3],espEnPlus(ordre,i));
			end
			else begin
				y := y+1;
				gotoxy(x,y);
				write(ordre.table[i,3],espEnPlus(ordre,i));
			end;
			textcolor(7);
			writeln(ordre.table[i,4]);
	end;
end;
//////////////////////////////////Tri///////////////////////////////////////////
FUNCTION partitionner(var ordre : highscore; debut, fin: INTEGER): INTEGER;
VAR
    i, j, pivot,tmp: INTEGER;
		tmp2, tmp3, tmp4,pivot2,pivot3,pivot4 : string;
BEGIN
    pivot := ordre.points[debut];
		pivot2 := ordre.table[debut,2];
		pivot3 := ordre.table[debut,3];
		pivot4 := ordre.table[debut,4];
    i := debut + 1;
    j := fin;
    WHILE (i <= j) DO // Tant que i et j ne se sont pas croisés...
    BEGIN
        WHILE (i <= fin) AND (ordre.points[i] >= pivot) DO i := i+1; // on parcourt de gauche à droite jusqu'à trouver un élément plus grand que le pivot
        WHILE (j > debut) AND (ordre.points[j] < pivot) DO j := j-1; // on parcourt de droite à gauche jusqu'à trouver un élément plus petit que le pivot
        IF (i<j) THEN    // Si i et j ne se sont pas croisés, on échange
        BEGIN
            tmp := ordre.points[i];
						tmp2 := ordre.table[i,2];
						tmp3 := ordre.table[i,3];
						tmp4 := ordre.table[i,4];
            ordre.points[i] := ordre.points[j];
						ordre.table[i,2] := ordre.table[j,2];
						ordre.table[i,3] := ordre.table[j,3];
						ordre.table[i,4] := ordre.table[j,4];
            ordre.points[j] := tmp;
						ordre.table[j,2] := tmp2;
						ordre.table[j,3] := tmp3;
						ordre.table[j,4] := tmp4;
        END;
    END;
    // A la fin de la boucle, on a trouvé la bonne place du pivot
    ordre.points[debut] := ordre.points[j];
		ordre.table[debut,2] := ordre.table[j,2];
		ordre.table[debut,3] := ordre.table[j,3];
		ordre.table[debut,4] := ordre.table[j,4];
    ordre.points[j] := pivot; // c'est j
		ordre.table[j,2] := pivot2;
		ordre.table[j,3] := pivot3;
		ordre.table[j,4] := pivot4;
    partitionner := j;
END;

PROCEDURE triRapideRec(VAR ordre: highscore; debut , fin : INTEGER);
VAR
  pivot : INTEGER;
begin
  IF (debut < fin) THEN
  begin
    pivot := partitionner(ordre,debut,fin);
    triRapideRec(ordre,debut,pivot-1);
    triRapideRec(ordre,pivot+1,fin);
  end;
end;

procedure TriRapide(VAR ordre : highscore);
begin
  triRapideRec(ordre,1,length(ordre.points));
end;
////////////////////////////////////////////////////////////////////////////////
procedure classification(var ordre : highscore; tampon: string;i : integer);
var
	entre : string;
	pos,cases : integer;
begin
	pos := 1;
	cases := 0;
	repeat
		cases := cases+1;
		entre := '';
		repeat
			entre := entre + tampon[pos];
			pos := pos+1;
		until (tampon[pos] = ' ');
		if cases = 1 then ordre.table[i,3] := entre;
		if cases = 2 then ordre.table[i,2] := entre;
		if cases = 3 then ordre.table[i,4] := entre;
		pos := pos+1
	until (cases = 3);
end;

PROCEDURE recupScores(Var ordre : highscore);
var
	Fichier : TextFile;
	tampon : string;
	i: integer;
begin
	i := 10;
	assignFile(fichier,'classement.txt');
	{$I+}
	try
		reset(fichier);
		repeat
			readln(fichier,tampon);
			ordre.table[i,1] := IntToStr(i);
			classification(ordre,tampon,i);
			i := i-1
		until (EOF(fichier));
		closeFile(fichier);
	except
		on E: EInOutError do
		begin
			erreur_lecture;
		end;
	end;
end;

procedure tri_Score(Var ordre : highscore; score : integer; nom,modeDuJeu : string);
var
	i : integer;
begin
	ordre.table[10,2] := nom;
	ordre.table[10,3] := IntToStr(score);
	ordre.table[10,4] := modeDuJeu;
	for i := 1 to 10 do ordre.points[i] := StrToInt(ordre.table[i,3]);
	TriRapide(ordre);
end;

procedure fin_jeu(score : integer;modeDuJeu : string);
var
	low : integer;
	ordre : highscore;
	nom : string;
begin
	low := StrToInt(recup_lowest);
	if inHighscore(low,score) then begin
		affi_gameOverHS(score);
		writeln('Bravo vous avez réalisé un score dans le Top 10');
		recupScores(ordre);
		writeln('Veuillez entrer votre surnom en majuscule :');
		readln(nom);
		tri_Score(ordre,score,nom,modeDuJeu);
		reecriture_classement(ordre);
		writeln();
		writeln('Score a été sauvegardé avec succès');
		writeln('Saississez une touche pour continuer..');
		readkey;
	end;
end;

PROCEDURE modifEspaces(VAR compt : highscore;VAR u : INTEGER);
VAR
  i,lmax,ltmp,j : INTEGER;
  nomss : STRING;
BEGIN
  lmax := length(compt.table[1,2]);
  FOR i := 1 to 10 DO BEGIN
    nomss := compt.table[i,2];
    IF (lmax < length(compt.table[i,2])) THEN lmax := length(compt.table[i,2]);
  END;
  FOR i := 1 to 10 do BEGIN
    nomss := compt.table[i,2];
    IF lmax = length(nomss) THEN nomss := nomss+'     '
    ELSE IF (lmax-length(nomss)) = 1 THEN nomss := nomss+'      '
    ELSE BEGIN
      ltmp := (lmax - length(nomss));
      FOR j := 1 to ltmp+4 DO  nomss := nomss + ' ';
    END;
    compt.table[i,2] := nomss;
  END;
    u := lmax -5;
END;

procedure affichage_complet;
var
	compt : highscore;
	u : integer;
begin
	recupScores(compt);
	modifEspaces(compt,u);
	affi_table(compt,u);
	writeln();
	affiClassement_mode;
end;
END.
