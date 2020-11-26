create database proiectbiblioteca
use proiectbiblioteca

create table Biblioteca(
	id int primary key,
	nume varchar(30),
	adresa varchar(30)
)
create table Persoane_angajate(
	idpers int primary key,
	id int foreign key references Biblioteca(id),
	nume varchar(30),
	varsta int 
	)
create table Utilizator(
	idut int primary key,
	id int foreign key references Biblioteca(id),
	nrcarti_imprumutate int
)
create table Imprumut(
	idimpr int primary key,
	idut int foreign key references Utilizator(idut),
	nrcarti_imprumutate int
)
create table Autor(
	idautor int primary key,
	nume varchar(30),
)
create table Domeniu(
	iddomeniu int primary key,
	nume varchar(30)
)
create table Carte(
	idcarte int primary key,
	idautor int foreign key references Autor(idautor),
	iddomeniu int foreign key references Domeniu(iddomeniu),
	an_aparitie int,
)
drop table Titlul
drop table ImprumutCarte
drop table Carte
create table ImprumutCarte(
	idimpr int foreign key references Imprumut(idimpr),
	idcarte int foreign key references Carte(idcarte),
	CONSTRAINT PK_ImprumutCarte primary key (idimpr,idcarte)
)
drop table ImprumutCarte


drop table Titlul
create table Titlul(
	id int foreign key references Carte(idcarte) ,
	nume varchar(30),
	CONSTRAINT pk_Titlul primary key (id) 
)
drop table romani
create table Nationalitate
(
	id_nationalitate int primary key,
	id_autor int foreign key references Autor(idautor),
	nume_de_autor varchar(30) 
)

INSERT INTO Biblioteca(id,nume,adresa)
VALUES ('2','BIBLIOTECA SECUNDARA','https://www.bcucluj.ro')
VALUES ('1','BIBLIOTECA CENTRALA','https://www.bcucluj.ro')


INSERT INTO Persoane_angajate(idpers,id,nume,varsta)
VALUES('8','2','ANDREI','25'),('9','2','ANDREEA','39')
VALUES('1','1','ANDREI','25'),('2','1','ANDREEA','30'),('3','1','MIHAI','40'),('5','1','DRAGOS','37'),('6','1','ALEXANDRA','19'),('7','1','ALEXANDRU','30')


INSERT INTO Utilizator(idut,id,nrcarti_imprumutate,Nume,Adresa)
VALUES ('6','2','3','Mihai','Manastur'),('7','2','4','Andreea','Gilau')
VALUES ('2','1','3','Mihai','Manastur'),('3','1','4','Andreea','Gilau'),('4','1','1','Larisa','Gheorgheni'),('5','1','8','Ioana','Marasti')

INSERT INTO Imprumut(idimpr,idut,nrcarti_imprumutate)
VALUES ('1','1','10'),('2','2','3'),('3','3','8'),('4','4','10'),('5','5','9'),('6','6','10'),('7','7','3')

INSERT INTO AUTOR(idautor,nume)
VALUES ('1','Marin Preda'),('2','Ioan Slavici'),('3','Mihail Sadoveanu'),('4','Liviu Rebreanu'),('5','Mihai Eminescu'),('6','INA Preda')

INSERT INTO DOMENIU(iddomeniu,nume)
VALUES ('1','Roman'),('2','Drama'),('3','Comedie'),('4','Poezie')

INSERT INTO Carte(idcarte,idautor,iddomeniu,an_aparitie)
VALUES ('1','1','1','2000'),('2','1','1','2002'),('3','2','2','2005'),('4','3','2','2008'),('5','4','3','2000'),('6','5','4','2010'),('7','5','4','2018')

INSERT INTO ImprumutCarte(idimpr,idcarte)
VALUES (1,1),(2,3),(3,7),(4,1),(5,6),(6,6),(7,1)

INSERT INTO Titlul(id,nume)
VALUES ('1','MOROMETII'),('2','Enigma Otiliei'),('3','Ion'),('4','Baltagul'),('5','Panza de paianjen'),('6','Maitreyi'),('7','Doando')

INSERT INTO Nationalitate(id_nationalitate,id_autor,nume_de_autor)
VALUES ('1','1','roman'),('2','2','roman'),('3','3','roman'),('4','4','roman'),('5','5','roman')

Select *
From Carte
WHERE an_aparitie>2000

Select *
From Carte
WHERE iddomeniu=1

Select *
FROM Nationalitate
WHERE nume_de_autor='roman'
SELECT * FROM Biblioteca
SELECT * FROM Persoane_angajate
SELECT * FROM Utilizator
SELECT * FROM Imprumut
SELECT * FROM Carte
SELECT * FROM Autor
SELECT * FROM Domeniu
SELECT * FROM ImprumutCarte
SELECT * FROM Titlul
SELECT * FROM Nationalitate

----PRIMELE 5 INTEROGARI CU WHERE
--aceasta interogare ne arata persoanele angajate de la fiecare biblioteca care au varsta mai mare de 30 de ani,ordonate dupa id
SELECT p.nume,p.varsta,b.id
From Persoane_angajate p INNER JOIN Biblioteca b ON p.id=b.id
where p.varsta>30
ORDER BY p.id

--aceasta interogare ne arata utilizatorii care au cel putin 2 carti imprumutate de la o  biblioteca si numele acestlei biblioteci 
SELECT p.nume,p.nrcarti_imprumutate,b.nume
From Utilizator p INNER JOIN Biblioteca b ON p.id=b.id
where p.nrcarti_imprumutate>2
ORDER BY p.id

--sa se afiseze toate domeniile cartilor care au anul de aparitie mai mare de 2009
SELECT p.nume
From Domeniu p INNER JOIN Carte b ON p.iddomeniu=b.iddomeniu
where b.an_aparitie>2009
ORDER BY p.iddomeniu

--sa se afiseze autorii cartilor al caror nume incepe cu I
SELECT nume
FROM Autor
WHERE nume LIKE 'I%'

--sa se afiseze toti autorii care sunt de nationalitate romana
SELECT a.nume,n.nume_de_autor
FROM Autor a INNER JOIN Nationalitate n ON a.idautor=n.id_autor
WHERE n.nume_de_autor='roman'
-----AICI SE TERMINA PRIMELE 5 INTEROGARI CU WHERE

---3 INTEROGARI CARE FOLOSESC GROUP BY

--numarul de carti imprumutate de fiecare biblioteca
SELECT b.id,SUM(u.nrcarti_imprumutate)
FROM Biblioteca b INNER JOIN Utilizator u ON b.id=u.id
GROUP BY b.id

--numarul de anagajati al fiecarei biblioteci
SELECT b.id,SUM(u.id)
FROM Biblioteca b INNER JOIN Persoane_angajate u ON b.id=u.id
GROUP BY b.id

--numarul de autori de fiecare nationalitate
SELECT n.nume_de_autor,SUM(n.id_autor) as numar
FROM Autor a INNER JOIN Nationalitate n ON a.idautor=n.id_autor
GROUP BY n.nume_de_autor

---2 interogari ce folosesc distinct------------------------------------------------
--sa se afiseze ani de aparitie al cartilor din biblioteca,distincti
SELECT DISTINCT an_aparitie
FROM CARTE
--sa se afiseze varstele distincte ale angajatilor
SELECT DISTINCT varsta
FROM Persoane_angajate


----------2 interogari ce folosesc having------------

--sa se afiseze media varstei angajatilor de la fiecare biblioteca,care este mai mare de 29 de ani
SELECT b.id,AVG(p.varsta)
FROM Biblioteca b INNER JOIN Persoane_angajate p ON b.id=p.id
GROUP BY b.id
HAVING AVG(p.varsta)>29

---SA SE AFISEZE  BIBLIOTECA CARE ARE UN NUMAR DE UTILIZATORI MAI MARE DE 3 SI IN CARE FIECARE UTILIZATOR ARE PESTE 1 CARTE IMPRUMUTATE
SELECT b.nume,SUM(u.id)
FROM Biblioteca b INNER JOIN Utilizator u ON b.id=u.id
WHERE u.nrcarti_imprumutate>1
GROUP BY b.nume
HAVING SUM(u.id)>3

-----------2 INTEROGARI PE TABELE AFLATE IN RELATIE M N------------
---id-ul imprumutului ,nr de carti imprumutate si anul aparitiei acelei carti
SELECT i.idimpr,i.nrcarti_imprumutate,c.an_aparitie
FROM Imprumut i INNER JOIN ImprumutCarte ic ON i.idimpr=ic.idimpr INNER JOIN Carte c ON c.idcarte=ic.idcarte 
WHERE i.nrcarti_imprumutate>5 and c.an_aparitie>=2010


----sa se afiseze dupa id-ul fiecarei carti numarul de exemplare imprumutate si id -ul utlizatorului
SELECT c.idcarte,i.nrcarti_imprumutate as numar_exemplare,i.idut
FROM Imprumut i INNER JOIN ImprumutCarte ic ON i.idimpr=ic.idimpr INNER JOIN Carte c ON c.idcarte=ic.idcarte 
ORDER BY c.idcarte


------------7 interogari ce folosesc mai mult de 2 tabele------------
-- sa se afiseze numele cartilor al caror autor incepe cu M si al caror nationalitate este romana
SELECT t.nume as TITLU,a.nume as Autor,n.nume_de_autor as Nationalitate
FROM Carte c INNER JOIN Autor a ON c.idautor=a.idautor INNER JOIN Nationalitate n ON a.idautor=n.id_autor  INNER JOIN Titlul t ON t.id=c.idcarte
WHERE n.nume_de_autor='roman' and a.nume LIKE 'M%'

-- sa se afiseze pentru fiecare biblioteca lista de utilizatori si imprumuturile lor ordonate descrescator dupa numarul de carti imprumutate
SELECT b.nume as NUME_BIBLIOTECA,u.Nume as Nume_Utilizator ,i.nrcarti_imprumutate as NUMARUL_DE_CARTI
From Biblioteca b INNER JOIN Utilizator u ON b.id=u.id INNER JOIN Imprumut i  ON i.idut=u.idut
ORDER BY i.nrcarti_imprumutate DESC


---sa se afiseze pentru fiecare domeniu suma cartilor imprumutate ordonate dupa numarul lor
SELECT d.nume as NUME_DOMENIU,SUM(i.nrcarti_imprumutate) as Numarul_cartilor_imprumutate
FROM Imprumut i INNER JOIN ImprumutCarte ic ON i.idimpr=ic.idimpr INNER JOIN  Carte c ON c.idcarte=ic.idcarte INNER JOIN Domeniu d ON c.iddomeniu=d.iddomeniu
GROUP by d.nume
Order by Sum(i.nrcarti_imprumutate)

-- sa se afiseze pentru fiecare carte ,biblioteca din care face parte
SELECT t.nume as TITLU_CARTE,b.nume as NUMELE_BIBLIOTECII
FROM Biblioteca b INNER JOIN Utilizator u ON b.id=u.id INNER JOIN Imprumut i ON u.idut=i.idut INNER JOIN ImprumutCarte ic ON ic.idimpr=i.idimpr INNER JOIN Carte c ON c.idcarte=ic.idcarte INNER JOIN Titlul t ON t.id=c.idcarte
ORDER BY b.id

-- sa se afiseze pentru fiecare autor numarul de carti pe care il are imprumutat de la fiecare biblioteca
SELECT a.nume as NUME_AUTOR,b.nume as NUMELE_BIBLIOTECII,sum(c.idcarte) as numarul_de_carti
FROM Biblioteca b INNER JOIN Utilizator u ON b.id=u.id INNER JOIN Imprumut i ON u.idut=i.idut INNER JOIN ImprumutCarte ic ON ic.idimpr=i.idimpr INNER JOIN Carte c ON c.idcarte=ic.idcarte INNER JOIN Autor a ON a.idautor=c.idautor 
GROUP BY a.nume,b.nume
ORDER BY a.nume


--sa se afiseze pentru fiecare autor,cartile impreuna cu  domeniul din care fac parte

SELECT a.nume as Autor,d.nume as Categoria,t.nume as Titlul
FROM Autor a INNER JOIN Carte c ON a.idautor=c.idautor INNER JOIN Domeniu d on d.iddomeniu=c.iddomeniu INNER JOIN Titlul t ON t.id=c.idcarte
ORDER BY a.nume

---sa se afiseze pentru fiecare autor titlurile cartilor sale impreuna cu anul aparitiei

SELECT a.nume as AUTOR,t.nume AS titlul,c.an_aparitie as an_aparitie
FROM Autor a INNER JOIN Carte c ON a.idautor=c.idautor INNER JOIN Titlul t ON c.idcarte=t.id
ORDER BY a.nume




-----------------------------------------------LABORATOR 3----------------------------------------

---aceasta procedura creeaza un table
CREATE PROCEDURE do_proc_1
AS
BEGIN
	CREATE TABLE NOU
	(
	ID INT  NOT NULL PRIMARY KEY,
	FIRST_NAME VARCHAR(50) NOT NULL,
	CITY VARCHAR(50)
	);
	UPDATE versiune SET versiune_actuala=versiune_actuala+1
END

-----ACEASTA PROCEDURE FACE UNDO LA CREEAREA TABELULUI
CREATE PROCEDURE undo_proc_1
AS
BEGIN
	DROP TABLE NOU
	UPDATE versiune SET versiune_actuala=versiune_actuala-1
END

EXEC do_proc_1
EXEC undo_proc_1

----ACEASTA PROCEDURA ADAUGA O CONSTRANGERE CA VALOARE IMPLICITA
CREATE PROCEDURE do_proc_2
AS
BEGIN
	ALTER TABLE NOU
	ADD CONSTRAINT df_0 DEFAULT '-' FOR CITY
	UPDATE versiune SET versiune_actuala=versiune_actuala+1

END

---ACEASTA PROCEDURA FACE UNDO LA CONSTRANGEREA
CREATE PROCEDURE undo_proc_2
AS
BEGIN
	ALTER TABLE NOU
	DROP CONSTRAINT df_0
	UPDATE versiune SET versiune_actuala=versiune_actuala-1
END


EXEC do_proc_2
EXEC undo_proc_2

-----ACEASTA PROCEDURA MODIFICA TIPUL UNEI COLOANE
CREATE PROCEDURE do_proc_3
AS
BEGIN
	ALTER TABLE NOU
	ALTER COLUMN CITY VARCHAR(50) NOT NULL 
	UPDATE versiune SET versiune_actuala=versiune_actuala+1
END

-----ACEASTA PROCEDURA FACE UNDO LA MODIFICAREA TIPULUI COLOANE
CREATE PROCEDURE undo_proc_3
AS
BEGIN
	ALTER TABLE NOU
	ALTER COLUMN CITY VARCHAR(50) 
	UPDATE versiune SET versiune_actuala=versiune_actuala-1
END

EXEC do_proc_3
EXEC undo_proc_3

---ACEASTA PROCEDURA ADAUGA ADAUGA UN CAMP NOU

CREATE PROCEDURE do_proc_4
AS
BEGIN
	ALTER TABLE NOU
	ADD SECOND_NAME VARCHAR(50)
	UPDATE versiune SET versiune_actuala=versiune_actuala+1
END

----ACEASTA PROCEDURA FACE UNDO LA ADAUGAREA UNEI COLOANE
CREATE PROCEDURE undo_proc_4
AS
BEGIN
	ALTER TABLE NOU
	DROP COLUMN SECOND_NAME
	UPDATE versiune SET versiune_actuala=versiune_actuala-1
END

EXEC do_proc_4
EXEC undo_proc_4

----ACEASTA PROCEDURA ADAUGA O CONSTRANGERE DE CHEIE STRAINA
CREATE PROCEDURE do_proc_5
AS
BEGIN
	ALTER TABLE NOU
	ADD CONSTRAINT fk_NOU FOREIGN KEY (ID) REFERENCES Persoane_angajate(idpers)
	UPDATE versiune SET versiune_actuala=versiune_actuala+1
END


-----ACEASTA PROCEDURA STERGE O CONSTRANGERE DE CHEIE STRAIAN
CREATE PROCEDURE undo_proc_5
AS
BEGIN
	ALTER TABLE NOU
	DROP CONSTRAINT fk_NOU
	UPDATE versiune SET versiune_actuala=versiune_actuala-1
END

DROP PROCEDURE do_proc_5
EXEC do_proc_5
EXEC undo_proc_5

---------------------final procedure------------

CREATE TABLE versiune
(
	versiune_actuala INT DEFAULT 0
)
INSERT INTO versiune(versiune_actuala) VALUES(0)
DELETE FROM versiune WHERE versiune_actuala=-1
SELECT versiune_actuala from versiune

CREATE PROCEDURE final
     @versiunedorita INT 
AS
BEGIN
	if @versiunedorita>5 or @versiunedorita<0
	begin
		print('Versiune inexistenta!');
	end;
	
	if(@versiunedorita>=0 and @versiunedorita<=5)
	begin
	declare @versiuneactuala int
	select @versiuneactuala=versiune_actuala FROM versiune
	if(@versiunedorita=@versiuneactuala)
	begin
		PRINT('VERSIUNEA DORITA ESTE EGALA CU VERSIUNEA ACTUALA')
	end
	while(@versiuneactuala < @versiunedorita)
	BEGIN
	if(@versiuneactuala=0)
	begin
		execute do_proc_1
		PRINT('A FOST CREAT TABELUL NOU')
		end
	if(@versiuneactuala=1)
		BEGIN
		execute do_proc_2
		PRINT('A FOST CREATA CONSTRANGEREA DE VALOARE IMPLICIT - PENTRU CAMPUL CITY DIN TABELUL NOU')
		END

	if(@versiuneactuala=2)
		BEGIN
		execute do_proc_3
		PRINT('A FOST FACUTA MODIFICAREA TIPULUI COLOANEI CITY IN VARCHAR NOT NULL')
		END
	if(@versiuneactuala=3)
		BEGIN
		execute do_proc_4
		PRINT('A FOST ADAUGAT CAMPUL NOU SECOND NAME DE TIP VARCHAR(40) IN TABELUL NOU')
		END
	if(@versiuneactuala=4)
		BEGIN
		execute do_proc_5
		PRINT('A FOST CREAT FOREIGN KEY CATRE TABELUL PERSOANE ANGAJATE,RELATIE 1-N PERSOANEANGAJATE-NOU')
		END
	select @versiuneactuala=versiune_actuala FROM versiune
	END
	while(@versiuneactuala>@versiunedorita)
	BEGIN
	if(@versiuneactuala=5)
		BEGIN
		execute undo_proc_5
		PRINT('A FOST STEARSA FOREIGN KEY')
		END
	if(@versiuneactuala=4)
		BEGIN
		execute undo_proc_4
		PRINT('A FOST STERS CAMPUL SECOND_NAME DIN TABELUL NOU')
		END
	if(@versiuneactuala=3)
	BEGIN
		execute undo_proc_3
		PRINT('A FOST STEARSA MODIFICAREA COLOANEI CITY IN VARCHAR NOT NULL->VARCHAR')
	END
	if(@versiuneactuala=2)
	BEGIN
		execute undo_proc_2
		PRINT('A FOST STEARSA CONSTRANGEREA DE IMPLICIT PENTRU CAMPUL CITY')
	END
	if(@versiuneactuala=1)
		BEGIN
		execute undo_proc_1
		PRINT('A FOST STERS TABELUL NOU DIN LISTA DE TABELE')
	END
	select @versiuneactuala=versiune_actuala FROM versiune
	END
	select @versiuneactuala=versiune_actuala FROM versiune
	PRINT ('VERISUNEA ACTUALA:')
	PRINT @versiuneactuala
	end
END
EXEC final 0
drop procedure final