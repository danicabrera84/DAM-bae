use empresa

create function fn_direccion(@numcen int)
returns varchar(50)
as
begin
return (select SENAS from TCENTR where NUMCE=@numcen)
end;

--PARA USAR LA FUNCION HACEMOS

select dbo.fn_direccion(10)
SELECT * FROM TCENTR

--3.2	Función que devuelve el nombre de un centro de trabajo pasándole el número de centro.

CREATE FUNCTION fn_nombrecen(@numcen int)
returns varchar(40)
as
begin
return (SELECT NOMCE FROM TCENTR WHERE NUMCE=@numcen)
end

SELECT dbo.fn_nombrecen(50)

SELECT  * FROM TEMPLE

--3.3	Dado un número de empleado, función que devuelva el nombre

CREATE FUNCTION fn_nomemple (@numemp int)
returns varchar (50)
as
begin
return (SELECT SUBSTRING(NOMEM, CHARINDEX(',' ,NOMEM)+1, LEN(NOMEM))
 FROM TEMPLE WHERE NUMEM=@numemp)
end

SELECT dbo.fn_nomemple (150)



SELECT SUBSTRING(NOMEM, CHARINDEX(',' ,NOMEM)+1, LEN(NOMEM))
 FROM TEMPLE

 SELECT SUBSTRING(NOMEM,1, CHARINDEX(',' ,NOMEM)-1)
 FROM TEMPLE


--3.4	Dado un número de empleado, función que devuelva el apellido

CREATE FUNCTION fn_apell (@numemp int)
returns varchar (50)
as
begin
return (SELECT SUBSTRING(NOMEM,1, CHARINDEX(',' ,NOMEM)-1)
 FROM TEMPLE WHERE NUMEM=@numemp)
 end

 SELECT dbo.fn_apell (110)

 CREATE TABLE TEMPLEDNI (
 Nombre varchar(50) not null,
 dni int not null,
 letra char(1) null,
 NUMEM int not null)
 go

DROP TABLE TEMPLEDNI 

 INSERT INTO TEMPLEDNI (Nombre,dni,letra,NUMEM)
 VALUES ('Daniel',42213469,'',1),
 ('Agoney',54145889,'',2),
 ('Jorge',25569874,'',3),
 ('Juanjo',35569874,'',4),
 ('Paco',42258631,'',5),
 ('Gustavo',65523148,'',6)
 go

 SELECT * FROM TEMPLEDNI

 --3.6	Crear una tabla con 3 campos (nombre, dni, letra) llamada TempleDNI. El
 -- campo letra estará vacío. Función que actualizará la tabla, devolviendo la letra del dni.

 alter function fn_letradni(@dni varchar(8)) 
 returns varchar(1) 
 as 
 begin 
 declare @letra varchar(1) 
 SET @letra = SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @dni % 23 + 1, 1) 
 return @letra 
 end 
 
 update templedni set letra= dbo.fn_letradni(templedni.letra)

 DROP TABLE TEMPLEDNI

 --3.8	Función que dado un dni, devuelva la letra correspondiente.

 CREATE function fn_letradni3(@dni varchar(8))
  returns varchar(1) as
   begin 
   declare @letra varchar(1) 
   SET @letra = SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @dni % 23 + 1, 1) 
   return @letra 
   end

   SELECT dbo.fn_letradni3 (42213469)

   --3.9	Función que dado un dni, actualice en el registro correspondiente la letra (suponemos que está vacía)
   create function fn_actualizarletradni(@dni varchar(8))
    returns varchar(1) 
	as 
	begin 
	declare @letra varchar(1) 
	SET @letra = SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @dni % 23 + 1, 1) 
	return @letra 
	end 
	update templedni set letra=dbo.fn_actualizarletradni('42213469') where templedni.dni='42213469'

	
   SELECT dbo.fn_actualizarletradni (42213469)

   --3.10	Función que dado un dni con la letra en una cadena (todo unido), devuelva si es correcto o no.

   create function dbo.dnicorrecto(@dni varchar(9))
    returns varchar(1) 
	as 
	begin 
	declare @letra varchar(1) 
	declare @numeros varchar(8) 
	SET @numeros = SUBSTRING(@dni,1,8) 
	SET @letra = SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @numeros % 23 + 1,1) 
	if (@letra=SUBSTRING(@dni,9,1)) 
	set @letra='S' 
	else 
	set @letra='N' 
	return @letra 
	end 
	print dbo.dnicorrecto('42213469')




 create function dbo.digicontrol(@banco varchar(4),@sucur varchar(4),@cuenta varchar(10))
  returns varchar(2) 
 as 
 begin 
 declare @resultado int 
 declare @d1 varchar(2) 
 set @resultado=@resultado+convert(int,SUBSTRING(@banco,1,1))*4 
 set @resultado=@resultado+convert(int,SUBSTRING(@banco,2,1))*8 
 set @resultado=@resultado+convert(int,SUBSTRING(@banco,3,1))*5 
 set @resultado=@resultado+convert(int,SUBSTRING(@banco,4,1))*10 
 set @resultado=@resultado+convert(int,SUBSTRING(@sucur,1,1))*9 
 set @resultado=@resultado+convert(int,SUBSTRING(@sucur,2,1))*7 
 set @resultado=@resultado+convert(int,SUBSTRING(@sucur,3,1))*3 
 set @resultado=@resultado+convert(int,SUBSTRING(@sucur,4,1))*6 
 set @resultado=@resultado % 11 
 if @resultado=10 
 set @resultado=1 
 set @d1=CONVERT(varchar(1),@resultado) 
 set @resultado=0 
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,1,1))*1 
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,2,1))*2 
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,3,1))*4 
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,4,1))*8  
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,1,1))*5 
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,2,1))*10 
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,3,1))*9 
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,4,1))*7 
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,4,1))*3
 set @resultado=@resultado+convert(int,SUBSTRING(@cuenta,4,1))*6 
 set @resultado=@resultado % 11 if @resultado=10 
 set @resultado=1 
 set @d1=@d1+CONVERT(varchar(1),@resultado) 
 return @d1 
  end 


 select dbo.digicontrol (4221,5318,1234567890)

 ---------------------------------A PARTIR DE AQUI SE REPITE LA TAREA DE NUEVO---------------------------------------
 use empresa

 SELECT * FROM TEMPLE
 
 --3.1	Función que devuelve la dirección de un centro de trabajo pasándole el número de centro

 create function dbo.direccion (@numcentro int)
 returns varchar(50)
 as
 begin
 declare @direccion varchar(50)
 SELECT @direccion=senas FROM TCENTR WHERE NUMCE=@numcentro
 return @direccion
end

SELECT dbo.direccion (10)


--3.2 Función que devuelve el nombre de un centro de trabajo pasándole el número de centro.

create function dbo.nombre (@numcentro int)
returns varchar(40)
as
begin
declare @nombre varchar(40)
SELECT @nombre=NOMCE from TCENTR WHERE NUMCE=@numcentro
return @nombre
end

SELECT dbo.nombre (10)


--3.3 Dado un número de empleado, función que devuelva el nombre.

create function dbo.nombreemple (@numemple int)
returns varchar(40)
as
begin
declare @nombre varchar(40)
SELECT @nombre=SUBSTRING(NOMEM,CHARINDEX(',',NOMEM)+1, LEN(NOMEM)) FROM TEMPLE WHERE NUMEM=@numemple
return @nombre
end
 
 SELECT dbo.nombreemple (110)


 --3.4 Dado un número de empleado, función que devuelva el apellido.

 create function dbo.apellido (@numemple int)
 returns varchar(40)
 as
 begin
 declare @apellido varchar(40)
 SELECT @apellido = SUBSTRING(NOMEM,1,CHARINDEX(',',NOMEM)-1) FROM TEMPLE WHERE NUMEM=@numemple
 return @apellido
 end

 SELECT dbo.apellido (120)


 --3.5 Hallar la función que me devuelve la edad de un empleado, cuando se conoce el número de empleado.

 create function dbo.edademp (@numemple smallint)
 returns smallint
 as
 begin
 declare @edad tinyint
 SET @edad= (SELECT datediff(year,FECNA,getdate()) FROM TEMPLE WHERE NUMEM=@numemple)
 return @edad
 end

 SELECT dbo.edademp (270)

 --3.6	Crear una tabla con 3 campos (nombre, dni, letra) llamada TempleDNI. El campo letra estará vacío. 
 --Función que actualizará la tabla, devolviendo la letra del dni.

 alter function dbo.tabladni (@dni varchar(8))
 returns varchar(1)
 as 
 begin
 declare @letra varchar(1)
 SET @letra=SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @dni % 23 + 1, 1) 
 return @letra 
 end 
 update TEMPLEDNI set letra= dbo.tabladni(TEMPLEDNI.letra)


 --3.8	Función que dado un dni, devuelva la letra correspondiente.

 create function dbo.devuelveletra (@dni varchar (8))
 returns varchar(1)
 as
 begin
 declare @letra varchar(1)
 set @letra = SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @dni % 23 + 1, 1) 
 return @letra
 end

 SELECT dbo.devuelveletra (42213469)



 SELECT * FROM TEMPLEDNI

 --3.9 Función que dado un dni, actualice en el registro correspondiente la letra (suponemos que está vacía)

 create function dbo.actuletra (@dni varchar(8))
 returns varchar(1) 
	as 
	begin 
	declare @letra varchar(1) 
	SET @letra = SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @dni % 23 + 1, 1) 
	return @letra 
	end 
	update templedni set letra=dbo.actuletra('42213469') where templedni.dni='42213469'


	--3.10 Función que dado un dni con la letra en una cadena (todo unido), devuelva si es correcto o no.
    create function dbo.dniok (@dnicom varchar(9))
	returns varchar(40)
	as
	begin
	declare @letra varchar(1)
	declare @resultado varchar (40)
	declare @numeros varchar(8)
	set @numeros = SUBSTRING(@dnicom,1,8)
	SET @letra = SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @numeros % 23 + 1, 1)
	if @letra = SUBSTRING(@dnicom,9,1)
	set @resultado = 'La letra es correcta'
	else
	set @resultado = 'La letra no es correcta'
	return @resultado
	end

	SELECT dbo.dniok ('42213469M')

	--3.7 En la tabla anterior, función que dado un número de empleado y su dni, devuelva la letra calculada.

	create function dbo.letracalc (@numemp smallint,@dni varchar(8))
	returns char(1)
	as
	begin
	declare @letra char(1)
	set @letra = SUBSTRING('TRWAGMYFPDXBNJZSQVHLCKE', @dni % 23 + 1, 1)
	SELECT @letra = letra FROM TEMPLEDNI WHERE NUMEM=@numemp and dni=@dni
	return @letra
	end

	SELECT dbo.letracalc (1,'42213469')


	--3.11 Dado un código de banco, código de sucursal y número de cuenta corriente, devuelva el dígito de control.

    create function dbo.digicontrol (@entidad int, @sucursal int, @cuenta bigint)
	returns int
	as
	begin
	declare @result int
	declare @digcont varchar(2)
	set @result = @result+SUBSTRING(@entidad,1,1)*4
	set @result = @result+SUBSTRING(@entidad,2,1)*8
	set @result = @result+SUBSTRING(@entidad,3,1)*5
	set @result = @result+SUBSTRING(@entidad,4,1)*10
	set @result = @result+SUBSTRING(@sucursal,1,1)*9
	set @result = @result+SUBSTRING(@sucursal,2,1)*7
	set @result = @result+SUBSTRING(@sucursal,3,1)*3
	set @result = @result+SUBSTRING(@sucursal,4,1)*6
	set @result = @result / 11
	if @result = 10
	set @result = 1
	set @digcont = CONVERT(varchar(1),@result)
	set @result = 0
	set @result = @result+SUBSTRING(@cuenta,1,1)*1
	set @result = @result+SUBSTRING(@cuenta,2,1)*2
	set @result = @result+SUBSTRING(@cuenta,3,1)*4
	set @result = @result+SUBSTRING(@cuenta,4,1)*8
	set @result = @result+SUBSTRING(@cuenta,5,1)*5
	set @result = @result+SUBSTRING(@cuenta,6,1)*10
	set @result = @result+SUBSTRING(@cuenta,7,1)*9
	set @result = @result+SUBSTRING(@cuenta,8,1)*7
	set @result = @result+SUBSTRING(@cuenta,9,1)*3
	set @result = @result+SUBSTRING(@cuenta,10,1)*6
	set @result = @result / 11
	if @result = 10
	set @result = 1
	set @digcont = @digcont+CONVERT(varchar(1),@result)
	return @digcont
	end



