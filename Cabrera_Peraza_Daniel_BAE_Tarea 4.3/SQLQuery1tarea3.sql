use CineDanCabPer

insert into Actores (CodActor,Nombre,LNacimiento,Nacionalidad,FNacimiento)
values (18,'Antonio Banderas','Malaga','España','08-10-1960')
go

update Actores set FNacimiento = '10-08-1960' where Nombre = 'Antonio Banderas'
go


insert into Actores (Nombre, FNacimiento, LNacimiento, Nacionalidad, FMuerte,
LMuerte,Foto) select Nombre, FNacimiento, LNacimiento, Nacionalidad, FMuerte, LMuerte,
Foto from TablaDatos where Nacionalidad = 'Estados Unidos'
go

alter table Actores 
add primary key (CodActor)
go

Insert into Directores( Nombre, FechaNacimiento, LocalNacim, Nacionalidad, FechaMuerte,
LocalMuerte, Foto) select Nombre , FNacimiento , LNacimiento , Nacionalidad , FMuerte ,
LMuerte , Foto from TablaDatos where Tipo='D 'and Nacionalidad <> 'Estados Unidos'

Select codigo, nombre, nacionalidad, cache into actorestemporal from tabladatos where tipo
= 'A'

Update actorestemporal set cache= (cache*0.10)+cache where nacionalidad = 'Estados Unidos'
Update actorestemporal set cache= (cache*0.15)+cache where nacionalidad <> 'Estados
Unidos' and nacionalidad <> 'Argelia'

Select codigo, nombre, fnacimiento, lnacimiento, nacionalidad, cache into directorestemporal
From tabladatos where tipo = 'D'

Update directorestemporal set cache= (cache*0.05)+cache where nacionalidad='Estados
Unidos'

Delete from directorestemporal where nacionalidad='España' 

Delete from directorestemporal

Select * into temporal from gananciadirectores where peliculas='casablanca'
Update temporal set ganancia=0;
Delete from actorestemporal where cache>1000000

Delete from actorestemporal where Cache>1000000
go