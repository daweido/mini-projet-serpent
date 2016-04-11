program ExampleKeyPressed; uses crt; // Ce programme affiche le code ascii
// des touches appuyées par l’utilisateur.
// Notez que les flèches font partie du code étendu
// (#0 puis un deuxième code ascii)
var c : char;
begin
	c:=#0;
	while c<>#27 do begin
		if keypressed then begin
			c:=readkey;
			if c=#0 then
				// if extended code
				begin c:=readkey;
				// read the code once more
				writeln('Extended : ', ord(c));
				end
				else
					writeln(ord(c));
				end
				else write('.');
				readkey;

end;

end.
