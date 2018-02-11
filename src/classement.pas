unit classement;
{$mode objfpc}

INTERFACE

PROCEDURE affichage_complet;
PROCEDURE fin_jeu(score : integer;modeDuJeu : string);



IMPLEMENTATION
USES
	sysutils,cadre_menu,crt;

TYPE highscore = RECORD
		table : ARRAY[1..10,1..4] OF string;
		points : ARRAY[1..10] OF INTEGER;
		END;

PROCEDURE erreur_lecture;
BEGIN
	affi_serp_2;
	WRITELN();
	WRITELN('Une erreur c''est produite en lisant le fichier du classement.');
	WRITELN();
	WRITELN('Saississez une touche pour retourner au menu précédent...');
	readkey;
END;

PROCEDURE erreur_reecriture;
BEGIN
	WRITELN();
	WRITELN('Une erreur c''est produite lors de la réécriture du classement dans le fichier.');
	WRITELN();
	WRITELN('Saississez une touche pour retourner au menu précédent...');
	readkey;
END;

FUNCTION recup_lowest(): string;
VAR
	Fichier : TextFile;
	lowest, score : string;
	i : integer;
BEGIN
	lowest :='';
	score := '';
	assignFile(fichier,'classement.txt');
	{$I+}
	TRY
		reset(fichier);
		READLN(fichier,lowest);
		closeFile(fichier);
	EXCEPT
		on E: EInOutError DO
		BEGIN
			erreur_lecture;
		END;
	END;
	i := 1;
	REPEAT
		score := score + lowest[i];
		i := i+1;
	UNTIL (lowest[i] = ' ');
	recup_lowest := score;
END;

PROCEDURE reecriture_classement(ordre : highscore);
VAR
	Fichier : TextFile;
	i : integer;
BEGIN
	assignFile(fichier,'classement.txt');
	{$I+}
	TRY
		reWRITE(fichier);
		FOR i := 10 downto 1 DO BEGIN
			WRITE(fichier, ordre.table[i,3],' ');
			WRITE(fichier, ordre.table[i,2],' ');
			WRITELN(fichier, ordre.table[i,4],' ');
		END;
		closeFile(fichier);
	EXCEPT
		on E: EInOutError DO
		BEGIN
			erreur_reecriture;
		END;
	END;
END;


FUNCTION inHighscore(low,score:integer): boolean;
BEGIN
	if low < score THEN
		inHighscore := true
	ELSE
		inHighscore := false;
END;

FUNCTION espEnPlus(ordre : highscore;i : integer): STRING;
VAR
	esp : string;
	l,p : integer;
BEGIN
	esp := '';
	l := length(ordre.table[i,3]);
	FOR p := 1 TO 10-l DO
		esp := esp+' ';
	espEnPlus := esp;
END;

PROCEDURE affi_table(ordre : highscore;u : integer);
VAR
	i,x,y : integer;
	esp : string;
BEGIN
	esp := '';
	textcolor(4);
	FOR i := 1 TO u DO
		esp := esp + ' ';
	WRITELN('                  N°  Surnoms',esp,'Score   Mode de Jeu*');
	FOR i := 1 TO 10 DO BEGIN
			textcolor(10);
			IF ordre.table[i,1] = '10' THEN
				WRITE('                  ',ordre.table[i,1],'. ')
			ELSE
				WRITE('                  ',ordre.table[i,1],'.  ');
			WRITE(ordre.table[i,2]);
			textcolor(15);
			IF i = 1 THEN BEGIN
				x := WhereX;
				y := WhereY;
				WRITE(ordre.table[i,3],espEnPlus(ordre,i));
			END
			ELSE BEGIN
				y := y+1;
				gotoxy(x,y);
				WRITE(ordre.table[i,3],espEnPlus(ordre,i));
			END;
			textcolor(7);
			WRITELN(ordre.table[i,4]);
	END;
END;

//////////////////////////////////Tri///////////////////////////////////////////
FUNCTION partitionner(VAR ordre : highscore; debut, fin: INTEGER): INTEGER;
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
    WHILE (i <= j) DO BEGIN// Tant que i et j ne se sont pas croisés...
      WHILE (i <= fin) AND (ordre.points[i] >= pivot) DO
				i := i+1; // on parcourt de gauche à droite jusqu'à trouver un élément plus grand que le pivot
      WHILE (j > debut) AND (ordre.points[j] < pivot) DO
				j := j-1; // on parcourt de droite à gauche jusqu'à trouver un élément plus petit que le pivot
      IF (i<j) THEN BEGIN// Si i et j ne se sont pas croisés, on échange
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
BEGIN
  IF (debut < fin) THEN BEGIN
    pivot := partitionner(ordre,debut,fin);
    triRapideRec(ordre,debut,pivot-1);
    triRapideRec(ordre,pivot+1,fin);
  END;
END;

PROCEDURE TriRapide(VAR ordre : highscore);
BEGIN
  triRapideRec(ordre,1,length(ordre.points));
END;

////////////////////////////////////////////////////////////////////////////////
PROCEDURE classification(VAR ordre : highscore; tampon: string;i : integer);
VAR
	entre : string;
	pos,cases : integer;
BEGIN
	pos := 1;
	cases := 0;
	REPEAT
		cases := cases+1;
		entre := '';
		REPEAT
			entre := entre + tampon[pos];
			pos := pos+1;
		UNTIL (tampon[pos] = ' ');

		IF cases = 1 THEN
			ordre.table[i,3] := entre;
		if cases = 2 THEN
			ordre.table[i,2] := entre;
		if cases = 3 THEN
			ordre.table[i,4] := entre;
		pos := pos+1
	UNTIL (cases = 3);
END;

PROCEDURE recupScores(Var ordre : highscore);
VAR
	Fichier : TextFile;
	tampon : string;
	i: integer;
BEGIN
	i := 10;
	assignFile(fichier,'classement.txt');
	{$I+}
	TRY
		reset(fichier);
		REPEAT
			READLN(fichier,tampon);
			ordre.table[i,1] := IntToStr(i);
			classification(ordre,tampon,i);
			i := i-1
		UNTIL (EOF(fichier));
		closeFile(fichier);
	EXCEPT
		on E: EInOutError DO BEGIN
			erreur_lecture;
		END;
	END;
END;

PROCEDURE tri_Score(Var ordre : highscore; score : integer; nom,modeDuJeu : string);
VAR
	i : integer;
BEGIN
	ordre.table[10,2] := nom;
	ordre.table[10,3] := IntToStr(score);
	ordre.table[10,4] := modeDuJeu;
	FOR i := 1 TO 10 DO
		ordre.points[i] := StrToInt(ordre.table[i,3]);
	TriRapide(ordre);
END;

PROCEDURE fin_jeu(score : integer;modeDuJeu : string);
VAR
	low : integer;
	ordre : highscore;
	nom : string;
BEGIN
	low := StrToInt(recup_lowest);
	IF inHighscore(low,score) THEN BEGIN
		affi_gameOverHS(score);
		WRITELN('Bravo vous avez réalisé un score dans le Top 10');
		recupScores(ordre);
		WRITELN('Veuillez entrer votre surnom en majuscule :');
		READLN(nom);
		tri_Score(ordre,score,nom,modeDuJeu);
		reecriture_classement(ordre);
		WRITELN();
		WRITELN('Score a été sauvegardé avec succès');
		WRITELN('Saississez une touche pour continuer..');
		readkey;
	END;
END;

PROCEDURE modifEspaces(VAR compt : highscore;VAR u : INTEGER);
VAR
  i,lmax,ltmp,j : INTEGER;
  nomss : STRING;
BEGIN
  lmax := length(compt.table[1,2]);
  FOR i := 1 TO 10 DO BEGIN
    nomss := compt.table[i,2];
    IF (lmax < length(compt.table[i,2])) THEN lmax := length(compt.table[i,2]);
  END;
  FOR i := 1 TO 10 do BEGIN
    nomss := compt.table[i,2];
    IF lmax = length(nomss) THEN
			nomss := nomss+'     '
    ELSE IF (lmax-length(nomss)) = 1 THEN
			nomss := nomss+'      '
    ELSE BEGIN
      ltmp := (lmax - length(nomss));
      FOR j := 1 TO ltmp+4 DO
				nomss := nomss + ' ';
    END;
    compt.table[i,2] := nomss;
  END;
    u := lmax -5;
END;

PROCEDURE affichage_complet;
VAR
	compt : highscore;
	u : integer;
BEGIN
	recupScores(compt);
	modifEspaces(compt,u);
	affi_table(compt,u);
	WRITELN();
	affiClassement_mode;
END;

END.
