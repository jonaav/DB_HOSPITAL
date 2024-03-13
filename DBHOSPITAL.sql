
---------------------------TABLAS---------------------------------------------
CREATE TABLE Gerente (
    idGerente NUMBER(10, 0) CONSTRAINT pk_gerente PRIMARY KEY,
    descGerente VARCHAR2(25) CONSTRAINT desc_gerenteNN NOT NULL,
    fechaRegistro TIMESTAMP DEFAULT(SYSDATE)
);

CREATE TABLE Condicion (
    idCondicion NUMBER(10, 0) CONSTRAINT pk_condicion PRIMARY KEY,
    descCondicion VARCHAR2(25) CONSTRAINT desc_condicionNN NOT NULL,
    fechaRegistro TIMESTAMP DEFAULT(SYSDATE)
);

CREATE TABLE Provincia (
    idProvincia NUMBER(10, 0) CONSTRAINT pk_provincia PRIMARY KEY,
    descProvincia VARCHAR2(30) CONSTRAINT desc_provinciaNN NOT NULL,
    fechaRegistro TIMESTAMP DEFAULT(SYSDATE)
);

CREATE TABLE Distrito (
    idDistrito NUMBER(10, 0) CONSTRAINT pk_distrito PRIMARY KEY,
    idProvincia NUMBER(10, 0) CONSTRAINT idProvincia_distritoNN NOT NULL,
    descDistrito VARCHAR2(30) CONSTRAINT desc_distritoNN NOT NULL,
    fechaRegistro TIMESTAMP DEFAULT(SYSDATE),
    CONSTRAINT fk_provincia FOREIGN KEY (idProvincia) REFERENCES provincia(idProvincia)
);

CREATE TABLE Sede (
    idSede NUMBER(10, 0) CONSTRAINT pk_sede PRIMARY KEY,
    descSede VARCHAR2(25) CONSTRAINT desc_sedeNN NOT NULL,
    fechaRegistro TIMESTAMP DEFAULT(SYSDATE)
);


CREATE TABLE Hospital (
    idHospital NUMBER(10, 0) CONSTRAINT pk_hospital PRIMARY KEY,
    idDistrito NUMBER(10, 0) CONSTRAINT idDistrito_hospitalNN NOT NULL,
    nombre VARCHAR2(50) CONSTRAINT nombre_hospitalNN NOT NULL,
    antiguedad NUMBER(10, 0),
    area DECIMAL(5,2),
    idSede NUMBER(10,0) CONSTRAINT idSede_hospitalNN NOT NULL,
    idGerente NUMBER (10, 0) CONSTRAINT idGerente_hospitalNN NOT NULL,
    idCondicion NUMBER (10, 0) CONSTRAINT idCondicion_hospitalNN NOT NULL,
    fechaRegistro TIMESTAMP DEFAULT(SYSDATE),
    CONSTRAINT fk_distrito FOREIGN KEY (idDistrito) REFERENCES distrito(idDistrito),
    CONSTRAINT fk_sede FOREIGN KEY (idSede) REFERENCES sede(idSede),
    CONSTRAINT fk_gerente FOREIGN KEY (idGerente) REFERENCES gerente(idGerente),
    CONSTRAINT fk_condicion FOREIGN KEY (idCondicion) REFERENCES condicion(idCondicion)
);



---------------------------SECUENCIAS---------------------------------------------

CREATE SEQUENCE gerente_sec
INCREMENT BY 1
START WITH 1
NOMAXVALUE 
NOMINVALUE
NOCYCLE
ORDER;

CREATE SEQUENCE condicion_sec
INCREMENT BY 1
START WITH 1
NOMAXVALUE 
NOMINVALUE
NOCYCLE
ORDER;

CREATE SEQUENCE provincia_sec
INCREMENT BY 1
START WITH 1
NOMAXVALUE 
NOMINVALUE
NOCYCLE
ORDER;

CREATE SEQUENCE distrito_sec
INCREMENT BY 1
START WITH 1
NOMAXVALUE 
NOMINVALUE
NOCYCLE
ORDER;

CREATE SEQUENCE sede_sec
INCREMENT BY 1
START WITH 1
NOMAXVALUE 
NOMINVALUE
NOCYCLE
ORDER;

CREATE SEQUENCE hospital_sec
INCREMENT BY 1
START WITH 1
NOMAXVALUE 
NOMINVALUE
NOCYCLE
ORDER;

---------------------------PACKAGE & STORE PROCEDURES-------------------------------

create or replace PACKAGE PKG_HOSPITAL 
IS
    PROCEDURE SP_HOSPITAL_REGISTRAR (
        pi_idDistrito IN distrito.idDistrito%type,
        pi_nombre IN hospital.nombre%type,
        pi_antiguedad IN hospital.antiguedad%type,
        pi_area IN hospital.area%type,
        pi_idSede IN sede.idSede%type,
        pi_idGerente IN gerente.idGerente%type,
        pi_idCondicion IN condicion.idCondicion%type,
        pi_fechaRegistro IN hospital.fechaRegistro%type,
        po_salida_codigo OUT NUMBER,
        po_salida_mensaje OUT VARCHAR2
    ); 
    PROCEDURE SP_HOSPITAL_ACTUALIZAR  (
        pi_idHospital IN hospital.idHospital%type,
        pi_idDistrito IN distrito.idDistrito%type,
        pi_idSede IN sede.idSede%type,
        pi_idGerente IN gerente.idGerente%type,
        pi_idCondicion IN condicion.idCondicion%type,
        po_salida_codigo OUT NUMBER,
        po_salida_mensaje OUT VARCHAR2
    ); 
    PROCEDURE SP_HOSPITAL_ELIMINAR (
        pi_idHospital IN hospital.idHospital%type,
        po_salida_codigo OUT NUMBER,
        po_salida_mensaje OUT VARCHAR2  
    );
    PROCEDURE SP_HOSPITAL_LISTAR (
        pi_idDistrito IN NUMBER DEFAULT NULL,
        pi_idProvincia IN NUMBER DEFAULT NULL,
        pi_idGerente IN NUMBER DEFAULT NULL,
        pi_idSede IN NUMBER DEFAULT NULL,
        pi_idCondicion IN NUMBER DEFAULT NULL,
        po_hospitales_cursor OUT SYS_REFCURSOR,
        po_salida_codigo OUT NUMBER,
        po_salida_mensaje OUT VARCHAR2  
    );

END PKG_HOSPITAL;

-----BODY-------


create or replace PACKAGE BODY PKG_HOSPITAL
IS
---------REGISTRAR---------------
    PROCEDURE SP_HOSPITAL_REGISTRAR (
        pi_idDistrito IN distrito.idDistrito%type,
        pi_nombre IN hospital.nombre%type,
        pi_antiguedad IN hospital.antiguedad%type,
        pi_area IN hospital.area%type,
        pi_idSede IN sede.idSede%type,
        pi_idGerente IN gerente.idGerente%type,
        pi_idCondicion IN condicion.idCondicion%type,
        pi_fechaRegistro IN hospital.fechaRegistro%type,
        po_salida_codigo OUT NUMBER,
        po_salida_mensaje OUT VARCHAR2  
    ) 
    IS
    BEGIN
        IF pi_fechaRegistro IS NOT NULL THEN
            INSERT INTO hospital (idHospital, idDistrito, nombre, antiguedad,
                area, idSede, idGerente, idCondicion, fechaRegistro)
                VALUES (
                hospital_sec.NEXTVAL, 
                pi_idDistrito, 
                pi_nombre, 
                pi_antiguedad, 
                pi_area, 
                pi_idSede, 
                pi_idGerente, 
                pi_idCondicion, 
                pi_fechaRegistro);
        ELSE
            INSERT INTO hospital (idHospital, idDistrito, nombre, antiguedad,
                area, idSede, idGerente, idCondicion)
                VALUES (
                hospital_sec.NEXTVAL, 
                pi_idDistrito, 
                pi_nombre, 
                pi_antiguedad, 
                pi_area, 
                pi_idSede, 
                pi_idGerente, 
                pi_idCondicion);
        END IF;
        po_salida_codigo := 0;
        po_salida_mensaje := 'Hospital creado exitosamente';

    EXCEPTION
        WHEN OTHERS THEN
            po_salida_codigo := SQLCODE;
            po_salida_mensaje := SQLERRM;

    END SP_HOSPITAL_REGISTRAR;
    
---------ACTUALIZAR---------------
    PROCEDURE SP_HOSPITAL_ACTUALIZAR (
        pi_idHospital IN hospital.idHospital%type,
        pi_idDistrito IN distrito.idDistrito%type,
        pi_idSede IN sede.idSede%type,
        pi_idGerente IN gerente.idGerente%type,
        pi_idCondicion IN condicion.idCondicion%type,
        po_salida_codigo OUT NUMBER,
        po_salida_mensaje OUT VARCHAR2  
    ) 
    IS
    BEGIN
        UPDATE hospital 
        SET idDistrito = pi_idDistrito, 
            idSede = pi_idSede, 
            idGerente = pi_idGerente, 
            idCondicion = pi_idCondicion
        WHERE idHospital = pi_idHospital;

        po_salida_codigo := 0;
        po_salida_mensaje := 'Hospital actualizado exitosamente';

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            po_salida_codigo := 1;
            po_salida_mensaje := 'El hospital no existe';
        WHEN OTHERS THEN
            po_salida_codigo := SQLCODE;
            po_salida_mensaje := SQLERRM;

    END SP_HOSPITAL_ACTUALIZAR;

---------ELIMINAR---------------
    PROCEDURE SP_HOSPITAL_ELIMINAR (
        pi_idHospital IN hospital.idHospital%type,
        po_salida_codigo OUT NUMBER,
        po_salida_mensaje OUT VARCHAR2  
    )
    IS
    BEGIN
        DELETE FROM hospital h
        WHERE h.idHospital = pi_idHospital;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se encontró el hospital con el ID ' || pi_idHospital);
        ELSE
            po_salida_codigo := 0;
            po_salida_mensaje := 'Hospital eliminado exitosamente';
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            po_salida_codigo := 1;
            po_salida_mensaje := 'El hospital no existe';
        WHEN OTHERS THEN
            po_salida_codigo := SQLCODE;
            po_salida_mensaje := SQLERRM;

    END SP_HOSPITAL_ELIMINAR;
    
------------------LISTAR------------------------
    PROCEDURE SP_HOSPITAL_LISTAR (
        pi_idDistrito IN NUMBER DEFAULT NULL,
        pi_idProvincia IN NUMBER DEFAULT NULL,
        pi_idGerente IN NUMBER DEFAULT NULL,
        pi_idSede IN NUMBER DEFAULT NULL,
        pi_idCondicion IN NUMBER DEFAULT NULL,
        po_hospitales_cursor OUT SYS_REFCURSOR,
        po_salida_codigo OUT NUMBER,
        po_salida_mensaje OUT VARCHAR2  
    )
    IS
        v_query VARCHAR2(1000);
        v_resultados SYS_REFCURSOR;
        v_idHospital NUMBER;
        v_idDistrito NUMBER;
        v_nombre VARCHAR2(100);
        v_antiguedad VARCHAR2(100);
        v_area DECIMAL(5,2);
        v_idSede NUMBER;
        v_idGerente NUMBER;
        v_idCondicion NUMBER;
        v_idFechaRegistro TIMESTAMP;
    BEGIN
        v_query := 'SELECT h.idHospital, h.idDistrito, h.nombre, h.antiguedad, 
        h.area, h.idSede, h.idGerente, h.idCondicion, h.fechaRegistro
        FROM Hospital h WHERE 1=1';
    
        IF pi_idDistrito IS NOT NULL THEN
            v_query := v_query || ' AND h.idDistrito = ' || pi_idDistrito;
        END IF;
    
        IF pi_idProvincia IS NOT NULL THEN
            v_query := v_query || ' AND h.idDistrito IN (SELECT d.idDistrito FROM Distrito d WHERE d.idProvincia = ' || pi_idProvincia || ')';
        END IF;
    
        IF pi_idGerente IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Gerente: ' || pi_idGerente);
            v_query := v_query || ' AND h.idGerente = ' || pi_idGerente;
        END IF;
        
        IF pi_idSede IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Sede: ' || pi_idSede);
            v_query := v_query || ' AND h.idSede = ' || pi_idSede;
        END IF;
        
        IF pi_idCondicion IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Condicion: ' || pi_idCondicion);
            v_query := v_query || ' AND h.idCondicion = ' || pi_idCondicion;
        END IF;
    
        DBMS_OUTPUT.PUT_LINE('Query generada: ' || v_query);
    
        OPEN v_resultados FOR v_query;
        po_hospitales_cursor := v_resultados;
        
        FETCH v_resultados 
        INTO v_idHospital,
            v_idDistrito,
            v_nombre,
            v_antiguedad,
            v_area,
            v_idSede,
            v_idGerente,
            v_idCondicion,
            v_idFechaRegistro;
        
        IF v_resultados%FOUND THEN
            po_salida_codigo := 0;
            po_salida_mensaje := 'Se encontraron resultados';
        ELSE 
            po_salida_codigo := 1;
            po_salida_mensaje := 'No se encontraron resultados';
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            po_salida_codigo := SQLCODE;
            po_salida_mensaje := SQLERRM;
        
    END SP_HOSPITAL_LISTAR;

END PKG_HOSPITAL;












