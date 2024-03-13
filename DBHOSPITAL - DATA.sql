
/* ------------------------------  DATA ---------------------------------------*/

-- Datos para la tabla Gerente
INSERT INTO Gerente (idGerente, descGerente) 
    VALUES (gerente_sec.NEXTVAL, 'Juan');
INSERT INTO Gerente (idGerente, descGerente) 
    VALUES (gerente_sec.NEXTVAL, 'Pedro');
INSERT INTO Gerente (idGerente, descGerente) 
    VALUES (gerente_sec.NEXTVAL, 'María');
INSERT INTO Gerente (idGerente, descGerente) 
    VALUES (gerente_sec.NEXTVAL, 'Carlos');
INSERT INTO Gerente (idGerente, descGerente) 
    VALUES (gerente_sec.NEXTVAL, 'Jorge');
INSERT INTO Gerente (idGerente, descGerente) 
    VALUES (gerente_sec.NEXTVAL, 'Claudia');
    
-- Datos para la tabla Condicion
INSERT INTO Condicion (idCondicion, descCondicion) 
    VALUES (condicion_sec.NEXTVAL, 'Condicion 1');
INSERT INTO Condicion (idCondicion, descCondicion) 
    VALUES (condicion_sec.NEXTVAL, 'Condicion 2');
INSERT INTO Condicion (idCondicion, descCondicion) 
    VALUES (condicion_sec.NEXTVAL, 'Condicion 3');
INSERT INTO Condicion (idCondicion, descCondicion) 
    VALUES (condicion_sec.NEXTVAL, 'Condicion 4');
INSERT INTO Condicion (idCondicion, descCondicion) 
    VALUES (condicion_sec.NEXTVAL, 'Condicion 5');
INSERT INTO Condicion (idCondicion, descCondicion) 
    VALUES (condicion_sec.NEXTVAL, 'Condicion 6');

-- Datos para la tabla Provincia
INSERT INTO Provincia (idProvincia, descProvincia) 
    VALUES (provincia_sec.NEXTVAL, 'Trujillo');
INSERT INTO Provincia (idProvincia, descProvincia) 
    VALUES (provincia_sec.NEXTVAL, 'Otuzco');
INSERT INTO Provincia (idProvincia, descProvincia) 
    VALUES (provincia_sec.NEXTVAL, 'Pacasmayo');
INSERT INTO Provincia (idProvincia, descProvincia) 
    VALUES (provincia_sec.NEXTVAL, 'Ascope');

-- Datos para la tabla Distrito
INSERT INTO Distrito (idDistrito, idProvincia, descDistrito) 
    VALUES (distrito_sec.NEXTVAL, 1, 'Trujillo');
INSERT INTO Distrito (idDistrito, idProvincia, descDistrito) 
    VALUES (distrito_sec.NEXTVAL, 1, 'El Porvenir');
INSERT INTO Distrito (idDistrito, idProvincia, descDistrito) 
    VALUES (distrito_sec.NEXTVAL, 2, 'Otuzco');
INSERT INTO Distrito (idDistrito, idProvincia, descDistrito) 
    VALUES (distrito_sec.NEXTVAL, 2, 'Huamachuco');
INSERT INTO Distrito (idDistrito, idProvincia, descDistrito) 
    VALUES (distrito_sec.NEXTVAL, 3, 'Guadalupe');
INSERT INTO Distrito (idDistrito, idProvincia, descDistrito) 
    VALUES (distrito_sec.NEXTVAL, 3, 'Pacasmayo');

-- Datos para la tabla Sede
INSERT INTO Sede (idSede, descSede) 
    VALUES (sede_sec.NEXTVAL, 'Sede 1');
INSERT INTO Sede (idSede, descSede) 
    VALUES (sede_sec.NEXTVAL, 'Sede 2');
INSERT INTO Sede (idSede, descSede) 
    VALUES (sede_sec.NEXTVAL, 'Sede 3');
INSERT INTO Sede (idSede, descSede) 
    VALUES (sede_sec.NEXTVAL, 'Sede 4');
INSERT INTO Sede (idSede, descSede) 
    VALUES (sede_sec.NEXTVAL, 'Sede 5');
INSERT INTO Sede (idSede, descSede) 
    VALUES (sede_sec.NEXTVAL, 'Sede 6');

-- Datos para la tabla Hospital
INSERT INTO Hospital (idHospital, idDistrito, nombre, antiguedad, area, idSede, idGerente, idCondicion) 
    VALUES (hospital_sec.NEXTVAL, 1, 'Hospital Belén', 10, 150.25, 1, 1, 1);
INSERT INTO Hospital (idHospital, idDistrito, nombre, antiguedad, area, idSede, idGerente, idCondicion) 
    VALUES (hospital_sec.NEXTVAL, 2, 'Hospital El Porvenir', 5, 200.50, 2, 2, 2);
INSERT INTO Hospital (idHospital, idDistrito, nombre, antiguedad, area, idSede, idGerente, idCondicion) 
    VALUES (hospital_sec.NEXTVAL, 3, 'Hospital Otuzco', 8, 180.75, 3, 3, 3);
INSERT INTO Hospital (idHospital, idDistrito, nombre, antiguedad, area, idSede, idGerente, idCondicion) 
    VALUES (hospital_sec.NEXTVAL, 4, 'Hospital Huamachuco', 15, 120.30, 4, 4, 4);
INSERT INTO Hospital (idHospital, idDistrito, nombre, antiguedad, area, idSede, idGerente, idCondicion) 
    VALUES (hospital_sec.NEXTVAL, 5, 'Hospital Guadalupe', 3, 250.90, 5, 5, 5);
INSERT INTO Hospital (idHospital, idDistrito, nombre, antiguedad, area, idSede, idGerente, idCondicion) 
    VALUES (hospital_sec.NEXTVAL, 6, 'Hospital Pacasmayo', 12, 160.45, 6, 6, 6);











