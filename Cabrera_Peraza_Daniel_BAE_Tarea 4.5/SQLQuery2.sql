USE master
GO
CREATE DATABASE aeropuertodancabper 
ON
(NAME=aeropuertodancabper_data,
FILENAME='C:\SQLServer_BaseDatos\aeropuertodancabper.mdf',
SIZE=10MB,
MAXSIZE=50MB,
FILEGROWTH=5MB)

LOG ON
(NAME=aeropuertodancabper_log,
FILENAME='C:\SQLServer_BaseDatos\aeropuertodancabper.ldf',
SIZE=10MB,
MAXSIZE=50MB,
FILEGROWTH=5MB)

use aeropuertodancabper

CREATE TABLE aviones (
Tipo int not null,
Capacidad int not null,
Longitud float not null,
Envergadura float not null,
Velocidad_de_crucero int not null
)
go

CREATE TABLE reservas (
Numero_de_vuelo varchar(10) not null primary key,
Fecha_de_salida date not null,
Plazas_libres int not null
)
go

CREATE TABLE vuelos(
Numero_de_vuelo varchar(10) not null primary key,
Origen varchar(25) not null,
Destino varchar(25) not null,
Hora_de_salida time not null,
Tipo_de_avion varchar(10) not null
)
go

ALTER TABLE aviones ALTER COLUMN Tipo varchar(10) not null
go

INSERT INTO aviones (Tipo,Capacidad,Longitud,Envergadura,Velocidad_de_crucero)
VALUES ('320',187,'42.15','32.6','853'),
('72S',160,'36.2','25.2','820'),
('737',172,'38.9','29','793'),
('73S',185,'44.1','30.35','815'),
('DS9',110,'38.3','28.5','815')
GO

INSERT INTO reservas (Numero_de_vuelo,Fecha_de_salida,Plazas_libres)
VALUES ('BA467','20-feb-92','32'),
('BA467','21-feb-92','49'),
('BA467','22-feb-92','79'),
('IB0640','20-feb-92','15'),
('IB0640','21-feb-92','21'),
('IB0640','22-feb-92','39'),
('IB3709','20-feb-92','60'),
('IB3709','21-feb-92','72'),
('IB3709','22-feb-92','85'),
('IB510','20-feb-92','19'),
('IB510','21-feb-92','31'),
('IB510','22-feb-92','40'),
('IB600','20-feb-92','46'),
('IB600','21-feb-92','80'),
('IB600','22-feb-92','91')
GO


INSERT INTO vuelos (Numero_de_vuelo,Origen,Destino,Hora_de_salida,Tipo_de_avion)
VALUES('AF577','BILBAO','PARIS','10:10:00','72S'),
('BA467','MADRID','LONDRES','20:40:00','73S'),
('IB023','MADRID','TENERIFE','21:20:00','320'),
('IB0640','MADRID','BARCELONA','6:45:00','DS9'),
('IB318','SEVILLA','MADRID','10:45:00','320'),
('IB327','MADRID','SEVILLA','18:05:00','320'),
('IB368','MALAGA','BARCELONA','22:25:00','737'),
('IB3709','DUBLIN','BARCELONA','14:35:00','737'),
('IB3742','MADRID','BARCELONA','9:15:00','320'),
('IB510','SEVILLA','MADRID','7:45:00','320'),
('IB600','MADRID','LONDRES','10:30:00','DS9'),
('IB610','MALAGA','LONDRES','15:05:00','320'),
('IB721','BARCELONA','SEVILLA','16:40:00','320'),
('IB77B','BARCELONA','ROMA','9:45:00','320'),
('LH1349','COPENHAGUE','FRANCFORT','10:20:00','DS9')
GO

SELECT DISTINCT Origen,Hora_de_salida,Destino FROM vuelos
go

SELECT * FROM VUELOS
go

SELECT Numero_de_vuelo,Origen,Destino,Hora_de_salida,Tipo_de_avion FROM VUELOS
go

SELECT * FROM VUELOS WHERE Origen = 'Madrid'
go

SELECT Numero_de_vuelo,Hora_de_salida FROM VUELOS WHERE Origen = 'Madrid' and Destino = 'Londres'
go

SELECT * FROM VUELOS WHERE Destino = 'Londres' and Origen NOT IN ('Madrid')
go

SELECT * FROM VUELOS WHERE Origen = 'Madrid' and Destino = 'Sevilla' or Origen = 'Sevilla' and Destino = 'Madrid'
go

SELECT * FROM VUELOS WHERE Origen = 'Madrid' and Destino = 'Barcelona' or Origen = 'Sevilla'
go

SELECT * FROM VUELOS WHERE Origen = 'Madrid' or Origen = 'Barcelona' or Origen = 'Sevilla'
go

SELECT * FROM VUELOS WHERE Origen NOT IN ('COPENHAGUE','DUBLIN')
go

SELECT * FROM VUELOS WHERE Hora_de_salida BETWEEN '06:00:00' AND '12:00:00'
go

SELECT * FROM VUELOS WHERE Numero_de_vuelo NOT IN (SELECT Numero_de_vuelo FROM vuelos WHERE Numero_de_vuelo LIKE 'IB%')
go

SELECT * FROM VUELOS WHERE Numero_de_vuelo LIKE 'IB%'
go

SELECT * FROM aviones
go

Select Tipo, Capacidad, (Longitud*3.28084) as 'Longitud en Pies', 
(Envergadura*3.28084) as 'Envergadura en Pies', (Velocidad_de_crucero*0.621371) as 'Velocidad millas/hora' from AVIONES
go

Select Longitud, Velocidad_de_crucero, Velocidad_de_crucero/Longitud as Relacion from AVIONES
go

Select * from AVIONES Where Longitud>Envergadura*1.1
go

Select MAX(Velocidad_de_crucero) as Maximo, Min(Velocidad_de_crucero) as Minimo from AVIONES
go

Select * from VUELOS Where Hora_de_salida=(Select Min(Hora_de_salida) from Vuelos)
go

Select * from RESERVAS Where plazas_libres>=50
go

Select Count(RESERVAS.Numero_de_vuelo) as Reservas from RESERVAS
go

SELECT COUNT(DISTINCT Destino)'Destinos'  FROM VUELOS
go

SELECT SUM(Plazas_libres)'Plazas libres el dia 20' from reservas where Fecha_de_salida = '1992-02-20'
go

SELECT SUM(Plazas_libres)'Plazas libres' from reservas
go

Select AVG(Capacidad)'Media de capacidad' from AVIONES
go

Select Tipo, Capacidad, Longitud, CONVERT(float(3),(Capacidad/Longitud)) as 'Relación Cap/Lon', 
Velocidad_de_crucero, Envergadura,  Cast ((Velocidad_de_crucero/Envergadura) as int) as 'Relación Env/Vel' From AVIONES
go

SELECT DISTINCT Origen, LEN(Origen)'Num de caracteres' FROM VUELOS
go

SELECT DISTINCT Origen, SUBSTRING(Origen,2,3)'2º,3º Y 4º caracter', SUBSTRING(Origen,3,2)'3º y 4º caracter' FROM VUELOS
go

SELECT DISTINCT ORIGEN, CONCAT(Origen ,left(Origen,1), Right(Origen,3))'Nombre modificado' FROM VUELOS
go

SELECT DISTINCT Fecha_de_salida, YEAR (Fecha_de_salida)'Año', MONTH (Fecha_de_salida)'Mes', DAY (Fecha_de_salida)'Día' FROM RESERVAS
go

SELECT Hora_de_salida, DATEPART(hh,hora_de_salida)'Hora',DATEPART(mi,Hora_de_salida)'Minutos',DATEPART(ss,Hora_de_salida)'Segundos' FROM vuelos
go

SELECT Fecha_de_salida,DATEDIFF(dd, Fecha_de_salida, '1992-03-01')'Dias han pasado desde el 01-03-1992' FROM RESERVAS
go

SELECT DISTINCT ORIGEN, MIN(Hora_de_salida)'Hora mas temprana' FROM VUELOS GROUP BY Origen ORDER BY Origen DESC
go

SELECT DISTINCT ORIGEN, MIN(Hora_de_salida)'Hora mas temprana' FROM VUELOS WHERE Origen NOT IN ('Barcelona') 
GROUP BY Origen ORDER BY Origen DESC
go

SELECT ORIGEN, MIN (Hora_de_salida)'Hora de salida mas temprana', MAX (Hora_de_salida)'Hora de salida mas tarde'
, COUNT (*)'Numero de vuelos desde este origen' FROM VUELOS GROUP BY ORIGEN
go

SELECT ORIGEN, MIN (Hora_de_salida)'Hora de salida mas temprana', MAX (Hora_de_salida)'Hora de salida mas tarde'
, COUNT (*)'Numero de vuelos desde este origen' FROM VUELOS WHERE Hora_de_salida < '16:00:00' GROUP BY ORIGEN
go

SELECT ORIGEN, MAX (Hora_de_salida) as 'Último vuelo', COUNT (*) as  'nvuelo' FROM VUELOS Where Hora_de_salida<'16:00' 
And Origen!='Dublin' And Origen!='Copenhague' GROUP BY ORIGEN Having COUNT (*)>1
go

SELECT ORIGEN,DESTINO, MIN(Hora_de_salida)'Hora mas temprana' FROM VUELOS GROUP BY Origen,Destino
go

SELECT DISTINCT Numero_de_vuelo, SUM(Plazas_libres)'Plazas libres totales' FROM reservas GROUP BY Numero_de_vuelo
go

SELECT DISTINCT Numero_de_vuelo, SUM(Plazas_libres)'Plazas libres totales' FROM reservas WHERE 
Numero_de_vuelo LIKE 'IB%' GROUP BY Numero_de_vuelo
go

SELECT DISTINCT Numero_de_vuelo, SUM(Plazas_libres)'Plazas libres totales' FROM reservas  GROUP BY Numero_de_vuelo
HAVING Numero_de_vuelo LIKE 'IB%' AND SUM(Plazas_libres)>150
go

Select * from reservas inner join vuelos on reservas.Numero_de_vuelo=vuelos.Numero_de_vuelo
 where reservas.Fecha_de_salida='1992-02-21' AND vuelos.Origen='Madrid' And Vuelos.Destino='Londres' AND Hora_de_salida='20:40'
 GO

Select reservas.Numero_de_vuelo, reservas.plazas_libres, vuelos.Hora_de_salida from reservas inner join vuelos on reservas.Numero_de_vuelo
=vuelos.Numero_de_vuelo where reservas.Fecha_de_salida='1992-02-20' AND vuelos.Origen='Madrid' And Vuelos.Destino='Londres'
go

select AVIONES.Tipo, AVIONES.Capacidad from AVIONES where aviones.Tipo in (Select vuelos.Tipo_de_avion from vuelos
 where Numero_de_vuelo IN (select RESERVAS.Numero_de_vuelo from RESERVAS where plazas_libres<30))
 GO

 SELECT * FROM aviones
 SELECT * FROM vuelos
 SELECT * FROM reservas

select tipo from aviones where capacidad / 2 < any (select avg(plazas_libres)from reservas group by Fecha_de_salida)
go


select tipo from aviones where capacidad / 2 > any (select avg(plazas_libres)from reservas group by Fecha_de_salida)
go

SELECT * FROM RESERVAS a WHERE Plazas_libres > (SELECT AVG(Plazas_libres) FROM reservas b WHERE a.Numero_de_vuelo = b.Numero_de_vuelo)
go

SELECT DISTINCT reservas.Numero_de_vuelo,vuelos.Origen,vuelos.Destino FROM RESERVAS , VUELOS WHERE vuelos.Origen = 'Madrid'and
reservas.Plazas_libres > 0
go

ALTER TABLE vuelos ADD Distancia_viaje FLOAT NULL
GO

SELECT DISTINCT aviones.Capacidad,aviones.Envergadura,aviones.Longitud,aviones.Tipo,aviones.Velocidad_de_crucero,vuelos.Destino,
vuelos.Tipo_de_avion FROM aviones inner join vuelos on aviones.Tipo = vuelos.Tipo_de_avion WHERE vuelos.Destino NOT IN ('Barcelona') 
AND vuelos.Origen NOT IN ('Barcelona')
GO

--Recuperar el número de plazas libres del vuelo Madrid-Londres de las 20:40 para el 21 de febrero de 1992:

SELECT DISTINCT vuelos.Numero_de_vuelo,vuelos.Origen,vuelos.Destino,vuelos.Hora_de_salida,reservas.Fecha_de_salida,reservas.Plazas_libres
'Plazas libres para este vuelo' FROM vuelos inner join reservas on vuelos.Numero_de_vuelo = reservas.Numero_de_vuelo WHERE
 reservas.Fecha_de_salida = '1992-02-21' AND vuelos.Origen = 'Madrid' AND vuelos.Destino = 'Londres'
GO

--Obtener los tipos de aviones y sus capacidades para aquellos en los que queden menos de 30 plazas libres:

SELECT DISTINCT aviones.Tipo,aviones.Capacidad FROM aviones,reservas WHERE reservas.Plazas_libres < 30
GO

--Obtener el número de plazas libres que quedan (entre todos los días) para cada vuelo y ordenar 
--el resultado de más a menos plazas. Para igual número de plazas se ordenará por el número de vuelo:

SELECT  Numero_de_vuelo, SUM(Plazas_libres)'Plazas Libres' from reservas group by Numero_de_vuelo order by
 SUM(Plazas_Libres) DESC, Numero_de_vuelo DESC
 GO

--Supongamos que se quiere una lista de todas las ciudades para las que hay vuelos, tanto si aparecen 
--como origen o como destino, ordenadas. No realizar dos consultas, ni poner varias veces las mismas ciudades:

SELECT Origen'Ciudades' FROM vuelos UNION SELECT Destino FROM vuelos
go

INSERT INTO reservas (Numero_de_vuelo,Fecha_de_salida,Plazas_libres)
VALUES ('IB600','1992-02-23','45')
go

SELECT * FROM RESERVAS WHERE Plazas_libres ='45'

insert into reservas
select Numero_de_vuelo, '2-2-92',0from vuelos where origen='sevilla'

UPDATE vuelos set Tipo_de_avion='d9s' where origen='malaga' and destino='londres' and DATEPART(hh,Hora_de_salida)=15 
and DATEPART(mi,Hora_de_salida)=5



update aviones set capacidad=capacidad*0.9
GO

DELETE FROM reservas WHERE Plazas_libres <50
go

DELETE FROM RESERVAS
GO

SELECT * FROM reservas

CREATE INDEX IXAVIONES ON AVIONES (Tipo)
GO

CREATE VIEW VISTA_VUELOS AS SELECT ORIGEN,DESTINO,HORA_DE_SALIDA FROM VUELOS
GO

CREATE VIEW VISTA_IBERIA AS SELECT Numero_de_vuelo,Fecha_de_salida FROM reservas WHERE Numero_de_vuelo LIKE 'IB%'
go

CREATE VIEW VISTA_IBERIA2 AS SELECT Numero_de_vuelo,Fecha_de_salida,Plazas_libres 
FROM reservas WHERE Numero_de_vuelo LIKE 'IB%'
go


ALTER VIEW VISTA_IBERIA AS SELECT Numero_de_vuelo,Fecha_de_salida,Plazas_libres 
FROM reservas WHERE Numero_de_vuelo LIKE 'IB%'
go

INSERT INTO VISTA_IBERIA2(Numero_de_vuelo,Fecha_de_salida,Plazas_libres)
VALUES('BA999','1992-02-29',85)
go

SELECT * FROM reservas

UPDATE VISTA_IBERIA SET Plazas_libres = 0 WHERE Numero_de_vuelo = 'IB510'
GO

UPDATE VISTA_IBERIA SET Numero_de_vuelo = 'ba000' WHERE Numero_de_vuelo = 'IB510'
GO

DELETE VISTA_IBERIA FROM reservas WHERE VISTA_IBERIA.Fecha_de_salida = '1992-02-20'
GO

--Supongamos que se quiere completar la tabla reservas especificando 
--cuántas plazas libres son de cada clase: primera, preferente y turista:

SELECT * FROM RESERVAS

ALTER TABLE RESERVAS ADD 
Primera_clase int,
Clase_preferente int,
Clase_turista int
go

INSERT INTO reservas (Primera_clase,Clase_preferente,Clase_turista)
VALUES (10,30,45),
(10,30,45),
(10,30,45),
(10,30,45),
(2,10,20),
(9,10,30),
(19,20,40),
(1,9,11),
(9,10,20),
(12,20,40),
(25,40,20),
(0,0,0),
(0,0,0),
(0,0,0),
(10,30,40),
(21,40,30)
GO

DROP TABLE vuelos
GO

DROP INDEX RESERVAS.IXRESERVAS
GO

DROP VIEW VISTA_VUELOS
GO

CREATE TABLE Salidas(
Num_vuelo varchar(10) not null primary key,
Origen varchar(25) not null,
Hora_de_salida time not null
)
go

INSERT INTO Salidas (Num_vuelo,Origen,Hora_de_salida)
VALUES('AF577','BILBAO','10:10:00'),
('BA467','MADRID','20:40:00'),
('IB023','MADRID','21:20:00'),
('IB0640','MADRID','6:45:00'),
('IB318','SEVILLA','10:45:00'),
('IB327','MADRID','18:05:00'),
('IB368','MALAGA','22:25:00'),
('IB3709','DUBLIN','14:35:00'),
('IB3742','MADRID','9:15:00'),
('IB510','SEVILLA','7:45:00'),
('IB600','MADRID','10:30:00'),
('IB610','MALAGA','15:05:00'),
('IB721','BARCELONA','16:40:00'),
('IB77B','BARCELONA','9:45:00'),
('LH1349','COPENHAGUE','10:20:00')
GO

CREATE TABLE Llegadas(
Num_vuelo varchar(10) not null primary key,
Origen varchar(25) not null,
Hora_de_llegada time not null
)
go

INSERT INTO Llegadas (Num_vuelo,Origen,Hora_de_llegada)
VALUES
('IB222','GRAN CANARIA','22:00:00'),
('IB432','LANZAROTE','15:05:00'),
('IB212','LA PALMA','12:00:00'),
('IB410','LA GOMERA','09:15:00'),
('IB610','SEVILLA','09:15:00'),
('IB510','MADRID','18:08:00')
go


SELECT Hora_de_salida'Horas operacion de vuelos' FROM Salidas UNION SELECT Hora_de_llegada from Llegadas
go

--Obtener las ciudades de origen de la tabla de LLEGADAS que no aparezcan en la tabla de SALIDAS.

 SELECT DISTINCT Llegadas.Origen from Llegadas,Salidas WHERE Llegadas.Origen NOT IN 
 (SELECT Salidas.origen from Salidas)
 go

 SELECT DISTINCT Origen 'Ciudades' from Salidas union SELECT DISTINCT Origen from Llegadas
 go

 SELECT DISTINCT Salidas.Origen from Salidas,Llegadas WHERE Salidas.Origen NOT IN 
 (SELECT Llegadas.origen from Llegadas)
 go

 --Encontrar las ciudades de origen donde se ha producido una operación de SALIDA así como las
 -- ciudades donde se han producido operaciones de LLEGADA (que aparezcan aunque se repitan).

 SELECT * FROM Salidas WHERE Hora_de_salida < (SELECT Convert(varchar(8),GetDate())) UNION 
 SELECT * FROM Llegadas WHERE Hora_de_llegada > (SELECT Convert(varchar(8),GetDate()))
 go

SELECT DISTINCT Llegadas.Hora_de_llegada from Llegadas,Salidas WHERE Llegadas.Hora_de_llegada NOT IN 
 (SELECT Salidas.Hora_de_salida from Salidas)
 go

 SELECT DISTINCT Salidas.Num_vuelo,Salidas.Hora_de_salida,Llegadas.Hora_de_llegada FROM Salidas INNER JOIN Llegadas 
 ON Salidas.Num_vuelo = Llegadas.Num_vuelo
 GO

SELECT Origen FROM Salidas UNION SELECT Origen FROM Llegadas
GO

SELECT DISTINCT Salidas.Hora_de_salida from Llegadas,Salidas WHERE Salidas.Hora_de_salida NOT IN 
 (SELECT Llegadas.Hora_de_llegada from Llegadas)
 go

 CREATE SYNONYM Reserv FOR Reservas
 go

 DROP SYNONYM Reserv
 GO
 DROP SYNONYM Bookings
 go

 CREATE USER OPERADOR_RESERVAS
 GO

 GRANT SELECT, UPDATE (PLAZAS_LIBRES) ON RESERVAS TO OPERADOR_RESERVAS 
 GO

 GRANT ALL PRIVILEGES ON RESERVAS TO JEFE_RESERVAS WITH GRANT OPTION
 GO

 REVOKE ALL PRIVILEGES ON RESERVAS TO OPERADOR_RESERVAS
 GO