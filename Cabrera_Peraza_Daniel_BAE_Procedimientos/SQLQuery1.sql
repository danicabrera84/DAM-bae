use empresa

--2.5.	Mostrar los datos de los empleados cuyos nombres de empleados empiecen por una letra dada

if OBJECT_ID('nombreemp') is not null
begin
  drop procedure nombreemp
end
go

create procedure nombreemp  
@nomemp char(1)
as
begin
(SELECT SUBSTRING(NOMEM,CHARINDEX(',',NOMEM)+1,LEN(NOMEM)) FROM TEMPLE WHERE NOMEM  LIKE @nomemp+'%')
end
 
EXEC nombreemp 'A'


--2.6.	Repetir el anterior, pero con el apellido.

if OBJECT_ID('apellidoemp') is not null
begin
  drop procedure apellidoemp
 end
 go

 create procedure apellidoemp
 @apelemp char(1)
 as
 begin
 (SELECT SUBSTRING(NOMEM,1,CHARINDEX(',',NOMEM)-1) FROM TEMPLE WHERE NOMEM LIKE @apelemp+'%')
 end

 EXEC apellidoemp 'C'


 --------------------------------------------------
 SELECT * FROM TCENTR

 --2.7.	Mostrar los datos de los empleados donde nomce se adapten a un patrón de búsqueda.

 if OBJECT_ID('datosemp') is not null
 begin
   drop procedure datosemp
end
create Procedure datosemp
@datos varchar(40)
as
begin
select temple2.numemp,temple2.numde,temple2.nomem,temple2.fecna
 from temple2 inner join tdepto2 on 
temple2.numde=tdepto2.numde inner join tcentr2 on 
tdepto2.numce=tcentr2.numce where tcentr2.nomce like '%'+@datos+'%'
end

Exec datosemp 'sede'


--2.8.	Mostrar el número de empleado, el nombre y la fecha de nacimiento, 
--mostrando el mes de nacimiento con letras

if OBJECT_ID('fechletra')is not null
begin
drop procedure fechletra
end
create procedure fechletra
@numemp int
as
begin
SELECT numemp,nomem,CONCAT(datepart(day,fecna),' de ',datename(month,fecna),' de ',datepart(year,fecna))as fecha
FROM Temple2 where numemp=@numemp
end

EXEC fechletra 110


--2.9.	Repetir el ejercicio anterior, añadiendo el nombre del
-- departamento donde trabaja y el nombre del centro y la dirección.
if OBJECT_ID('fechletra2')is not null
begin
drop procedure fechletra
end 
create procedure fechletra2
@numemp int
as
begin
SELECT temple2.numemp,temple2.numde,temple2.nomem,CONCAT(datepart(day,temple2.fecna),' de ',
datename(month,temple2.fecna),' de ',datepart(year,temple2.fecna))'Fecha de nac.',tdepto2.numce,
tcentr2.nomce FROM Temple2 inner join Tdepto2 on Temple2.numde=Tdepto2.numde inner join Tcentr2 on
Tdepto2.numce=Tcentr2.numce where Temple2.numemp = @numemp
end

EXEC fechletra2 110


--2.10.	Obtener los nombres de los empleados que tengan más edad que la que se le pasa como parámetro.
if OBJECT_ID ('edademple') is not null
begin
  drop procedure edademple
end
create procedure edademple
@edad int
as
begin
SELECT nomem, datediff(year,fecna,getdate())as edad from temple2 where 
@edad < (SELECT datediff(year,fecna,getdate()))
end

EXEC edademple 60


SELECT * FROM TEMPLE2
SELECT nomem, datediff(year,fecna,getdate())'Edad' from temple2 


--2.11.	Obtener los nombres de los empleados que lleven en la empresa menos años que los dado como parámetro
if OBJECT_ID ('fechempez') is not null
begin
  drop procedure fechempez
end
create procedure fechempez
@años int
as
begin
SELECT nomem, datediff(year,fecin,getdate())'Años en la empresa' from temple2 where 
@años > (SELECT datediff(year,fecin,getdate()))
end

EXEC fechempez 30



--2.12.	Mostrar el número de empleado, nombre, edad y fecha de ingreso de aquellos empleados
--que tengan más edad que la que se pasa como parámetro y lleven en la empresa más de los años 
--pasados también como parámetro.
if OBJECT_ID ('fechtot') is not null
begin
  drop procedure fechtot
end
create procedure fechtot
@edad int, 
@años int
as
begin
SELECT numemp,nomem, datediff(year,fecna,getdate())'Edad', datediff(year,fecin,getdate())'Años en la empresa'
from Temple2 where @edad < (SELECT datediff(year,fecna,getdate())) and @años < (SELECT datediff(year,fecin,getdate()))
end

EXEC fechtot 60,30

--2.13.	Se va a eliminar un centro, pasándole el código del centro. Borrar todos los empleados del centro,
-- todos los departamentos y por último el centro.
if OBJECT_ID ('borcentro') is not null
begin
  drop procedure borcentro
end
create procedure borcentro
@codcentro int
as
begin
delete from Temple2 where Temple2.numde in
(SELECT Tdepto2.numde from Tdepto2 where  Tdepto2.numce = @codcentro)
delete from Tdepto2 where Tdepto2.numce = @codcentro
delete from Tcentr2 where Tcentr2.numce = @codcentro
end
Exec borcentro 10


end

SELECT * FROM TCENTR2
SELECT * FROM TEMPLE2
SELECT * FROM TDEPTO2

--2.14.	Borrar un empleado pasándole el número de empleado.
if OBJECT_ID ('boremple') is not null
begin
  drop procedure boremple
end
create procedure boremple
@emple int
as
begin
delete from Temple2 where numemp = @emple
end

exec boremple 120
select * from tdepto2
select * from temple2


--2.15.	Insertar un registro en la tabla tdepto.
if OBJECT_ID ('insertdepto') is not null
begin
  drop procedure insertdepto
end
create procedure insertdepto
@numde int, @numce int,
@direc int, @tidir char(1),
@presu int, @depde int,
@nomde varchar(50)
as
begin
insert into Tdepto2(numde,numce,direc,tidir,presu,depde,nomde)
values(@numde,@numce,@direc,@tidir,@presu,@depde,@nomde)
end

Exec insertdepto 115,20,180,'F',12,100,'dpto. informatico'
select * from tdepto2

if OBJECT_ID ('insertemp') is not null
begin
  drop procedure insertemp
end

create procedure insertemp
@NUMEMP INT,
@NUMDE INT,
@EXTEL SMALLINT,
@FECNA DATE,
@FECIN DATE,
@SALAR FLOAT,
@COMIS FLOAT,
@NUMHI SMALLINT,
@NOMEM VARCHAR(20),
@DNI VARCHAR(9)
as
begin
begin tran
declare @error int
if (dbo.FN_COMPROBAR_DNI(@DNI)=1)
begin
print '¡El DNI es correcto!'
insert into temple2 (numemp, numde, extel, fecna, fecin, salar, comis, numhi, nomem)
values (@numemp, @numde, @extel, @fecna, @fecin, @salar, @comis, @numhi, @nomem)
print 'Se ha insertado el empleado'
end
else
begin
print 'El DNI introducido no es correcto'
print 'No se ha guardado el usuario en la base de datos'
end
set @error = @@error
if (@error=-1)
begin
rollback tran
return (@error)
print 'Ha sucedido un error y se han deshecho los cambios'
end
commit tran
end

EXEC dbo.insertemp 150, 121, 340, '1984-10-28', '2006-09-16', 550, 300, 1, 'CABRERA, DANIEL', '42213469M'


   








