/*CREACION DE SCHEMA

Empezaremos creando nuestro schema, este es el espacio que 
alojara nuestras tablas y datos.
*/

CREATE SCHEMA tienda;



/*CREACION DE TABLA

Para crear una tabla, utilizaremos CREATE
Es impotante que notemos la estructura, que tiene esta sentencia(query),
*/



CREATE TABLE productos 
(
id_producto INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_producto),
nombre VARCHAR(255),
precio INT
);

CREATE TABLE clientes 
(
id_cliente INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_cliente),
nombre VARCHAR(255),
apellido VARCHAR(100),
edad INT,
telefono INT
);

CREATE TABLE pedidos 
(
id_pedido INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_pedido),
fecha DATE,
cantidad INT,
id_cliente INT,
id_producto INT,
FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY(id_producto) REFERENCES productos(id_producto)
);

/*ALTER TABLE

Supongamos que deseamos modificar la tabla pedidos, incluyendo en esta la sede en la
que el cliente compro sede producto. Para esto vamos a crear una tabla sede y usaremos
ALTER para agregar una columna dentro de la tabla pedidos.
*/

CREATE TABLE sedes
(
id_sede INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_sede),
nombre VARCHAR(255)
);

ALTER TABLE pedidos
	ADD COLUMN id_sede int,
    ADD CONSTRAINT `fk_relacion` FOREIGN KEY (id_sede)
        REFERENCES sedes(id_sede);

/*DROP TABLE

En el caso que nosotros querramos eliminar una tabla, utilizaremos el comando DROP, 
debemos tener cuidado con esta sentencia y al momento de ejecutarla, pues eliminara 
todos los datos que haya almacenados en la tabla.
*/

CREATE TABLE tabla_a_ser_borrada 
(
id_clientes INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_clientes),
nombre VARCHAR(255),
apellido VARCHAR(100),
edad INT,
telefono INT
);

DROP TABLE tabla_a_ser_borrada;

/*INSERT

Este comando nos permite ingresar datos a nuestras tablas.
*/

INSERT INTO clientes(nombre, apellido, edad, telefono)
VALUES("Yon","Arce",24,9876546);

INSERT INTO productos(nombre, precio)
VALUES("USB 64GB", 40);

INSERT INTO sedes(nombre)
VALUES("AGENCIA 3 DE MAYO");

INSERT INTO sedes(nombre)
VALUES("AGENCIA ALTO MISTI"),
("AGENCIA ANTUNEZ DE MAYOLO"),
("AGENCIA CHORRILLOS"),
("AGENCIA EL PORVENIR"),
("AGENCIA JAEN"),
("AGENCIA MACUSANI");


/*UPDATE

Permite modificar los valores de una tabla
*/

UPDATE clientes SET telefono = 966666612 WHERE id_cliente = 1; #Con el comando WHERE especificamos en que fila se reemplazara
#Debemos especificar siempre con WHERE, pues el no hacerlo implicaria modificar todos los valores de la tabla

/*DELETE

Se permite eliminar los valores de una tabla, recordemos usar el WHERE pues podemos volarnos
toda la tabla.
*/

DELETE FROM clientes WHERE id_cliente = 2;

/*SELECT

Nos permite seleccionar una tabla y visualizar su contenido.
*/

SELECT * FROM clientes; #Si no seleccionamos nos mostrara toda la tabla
SELECT nombre,apellido FROM clientes; #Si solo deseamos columnas en especifico

SELECT nombre,apellido FROM clientes WHERE id_cliente BETWEEN 3 AND 20;

SELECT nombre,apellido FROM clientes WHERE nombre = "Yon" AND apellido = "Arce";

SELECT nombre,apellido FROM clientes WHERE nombre = "Yon" OR apellido = "RAMIREZ";

SELECT nombre,apellido FROM clientes WHERE edad > 50;

SELECT nombre FROM productos WHERE precio > 50;

SELECT nombre,precio FROM productos WHERE precio <> 45;

SELECT nombre,precio FROM productos WHERE precio = 45;

SELECT nombre,apellido FROM clientes WHERE nombre LIKE "%ANTONIO";

/*FUNCION DE ORDENAMIENTO

Se permite eliminar los valores de una tabla, recordemos usar el WHERE pues podemos volarnos
toda la tabla.
ORDER BY 
ASC
DESC
*/
SELECT * FROM clientes WHERE id_cliente < 15 ORDER BY nombre DESC;

/*FUNCION DE AGREGACION

Calculos:
COUNT: Contamos la cantidad de elementos
*/

SELECT COUNT(*) FROM clientes WHERE nombre = "Yon";

# SUM: Sumamos los precios de todos los productos en venta

SELECT SUM(precio) FROM productos; 

# AVG: Proviene de average(promedio), tomaremos el promedio de la edad de todos los clientes
SELECT nombre, AVG(edad) FROM clientes GROUP BY nombre;
# MIN: Encontremos a la persona mas joven
SELECT nombre,apellido, MIN(edad) FROM clientes;
# MAX: Encontremos a la persona mas longeva
SELECT nombre, MAX(edad) FROM clientes GROUP BY nombre;

UPDATE clientes SET edad = 20 WHERE id_cliente = 4; #Cambiamos la edad del 2° Yon para ver como actua AVG
