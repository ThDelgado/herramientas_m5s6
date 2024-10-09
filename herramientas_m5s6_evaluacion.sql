CREATE TABLE empresas(
rut VARCHAR(10) PRIMARY KEY,
nombre VARCHAR(120) NOT NULL,
direccion VARCHAR(120) NOT NULL,
telefono VARCHAR(15) NOT NULL,
correo VARCHAR(80) NOT NULL,
web VARCHAR(50)
);

CREATE TABLE clientes(
rut VARCHAR(10) PRIMARY KEY,
nombre VARCHAR(120) NOT NULL,
correo VARCHAR(80) NOT NULL,
direccion VARCHAR(120) NOT NULL,
celular VARCHAR(15) NOT NULL
);

CREATE TABLE herramientas (
id_herramienta SERIAL PRIMARY KEY,
nombre VARCHAR(120) NOT NULL,
precio_dia NUMERIC(12,2) CHECK(precio_dia >0) NOT NULL
);

CREATE TABLE arriendos(
id_arriendo SERIAL PRIMARY KEY,
folio INTEGER NOT NULL,
fecha DATE DEFAULT CURRENT_DATE NOT NULL,
dias INTEGER DEFAULT (0) CHECK (dias > 0) NOT NULL,
garantia  VARCHAR(30),
id_herramienta INTEGER REFERENCES herramientas(id_herramienta),
cliente_rut  VARCHAR(10) REFERENCES clientes(rut)
);



--Inserte los datos de una empresa.

INSERT INTO empresas (rut, nombre, direccion, telefono, correo, web) VALUES
('11111111-1','ECONOMI','Las lomas', '22456123','economy@economy.cl','www.economy.cl');
SELECT * FROM empresas;


--Inserte 5 herramientas.

INSERT INTO herramientas(nombre, precio_dia) VALUES
('taladro',5000),
('sierra electrica', 25000),
('Motosierra', 15000),
('taladro percutor', 18000),
('soldador',50000);

SELECT * FROM herramientas;

--Inserte 3 clientes. 

INSERT INTO clientes (rut,nombre, correo, direccion, celular) VALUES
('11111111-2', 'Pedro Martinez','pedro@mmm.cl','lomas verdes 52','9456789'),
('11111111-3','Ricardo Soto', 'ricardo@lqsea.cl','praderas 1245','9789456'),
('11111111-4','Estavan Yanez','esteban@lqsea.cl','El llano 478','9456123');
SELECT * FROM clientes;

-- AGREGANDO ARRIENDOS
INSERT INTO arriendos(folio, fecha, dias, garantia, id_herramienta, cliente_rut) VALUES
(15,'2024-01-15',5,'25000',1,'11111111-4'),
(18,'2024-05-21',15,'18000',4,'11111111-2'),
(19,'2024-06-05',6,'50000',5,'11111111-3');

-- Listar todos los arriendos con las siguientes columnas: 
--Folio, Fecha, Días, ValorDia, NombreCliente, RutCliente.  

SELECT
	a.folio, a.fecha, a.dias, 
	h.precio_dia  as ValorDia, 
	c.nombre as NombreClinete,
	c.rut as RutCliente
FROM arriendos a
JOIN herramientas h  ON a.id_herramienta = h.id_herramienta
JOIN clientes c ON a.cliente_rut = c.rut;


--Listar los clientes sin arriendos.
SELECT * FROM arriendos;
SELECT * FROM clientes;

INSERT INTO clientes (rut, nombre, correo, direccion, celular) VALUES
('11111111-5', 'Juan Perez', 'juan@ejemplo.com', 'Calle Falsa 123', '12345678');

SELECT c.rut, c.nombre FROM clientes c
LEFT JOIN  arriendos a  ON c.rut = a.cliente_rut
WHERE a.cliente_rut IS NULL;




--Liste RUT y Nombre de las tablas empresa y cliente.
SELECT e.rut AS RutEmpresa, e.nombre AS NombreEmprea FROM empresas e
UNION ALL
SELECT c.rut AS RutCliente, c.nombre as NombreCliente FROM clientes c;


--Liste la cantidad de arriendos por mes. 
SELECT TO_CHAR(DATE_TRUNC('month', fecha),'YYYY-MM') AS Mes,
COUNT(*) AS CantidadArriendos FROM arriendos
GROUP BY Mes
ORDER BY Mes;







