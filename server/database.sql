-- creando una instancia de Postgresql
./initdb -D data -U postgres -A md5 -W
--data lo remplace por roadmap en mi caso, ya tenia tenia el directorio data.

--Ejecutando el servidor PostgreSQLUna vez creada la instancia data utilizar la utilería--
--pg_ctl.exe para levantar el servidor:

./pg_ctl -D data -o "-p 5433" start

--Conectándose a PostgreSQLPara conectarnos a la instancia de postgres postgres que hemos levantado (data) utilizaremos el cliente psql.exeproporcionado en la distribución dentro de bin:--

./psql -U postgres -d postgres -p 5433 -h localhost

create schema roadmapp;


CREATE TABLE roadmapp.usuarios(
    id  SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    passwd VARCHAR(255) NOT NULL,
    roadmap VARCHAR(255), 
    creditosAct INTEGER
);

CREATE TABLE roadmapp.materias(
    id SERIAL PRIMARY KEY,
    nameM VARCHAR(255) NOT NULL,
    numCredits INT NOT NULL,
    clave VARCHAR(4) NOT NULL,
    codigo VARCHAR(5) NOT NULL
);

CREATE TABLE roadmapp.profesores(
    id SERIAL PRIMARY KEY,
    nameP VARCHAR(255) NOT NULL,
    materiaID INTEGER NOT NULL REFERENCES roadmapp.materias(id)
);

INSERT INTO roadmapp.usuarios VALUES (1,'usuario1@alumnos.udg.mx','pa$$wd','CPROSPROCMATCMM1|SMM1EIFICED1SED1|TECOCMM2SMM2CED2SED2|ADMRCALGSALGPYESCBDD|SBDDADSEHIPEIDS1SDS1|CODPSEDIPPINIDS2ESP1|CESOSESOALDDADBDMIDD|OPT1CSBCSSBCCIDDOPT2');

INSERT INTO roadmapp.materias VALUES (1,'Programacion',8,'CPRO','I5882');
INSERT INTO roadmapp.materias VALUES (2,'Seminario De Programacion',5,'SPRO','I5883');
INSERT INTO roadmapp.materias VALUES (3,'Matematicas Discretas',8,'CMAT','I5892');
INSERT INTO roadmapp.materias VALUES (4,'Metodos matematicos I',8,'CMM1','I5893');
INSERT INTO roadmapp.materias VALUES (5,'Seminario metodos matematicos I',5,'SMM1','I5894');
INSERT INTO roadmapp.materias VALUES (6,'Especializaznte introduccion a la fisica',7,'EIFI','I6123');

INSERT INTO roadmapp.materias VALUES (7,'Estructuras de datos I',8,'CED1','I5886');
INSERT INTO roadmapp.materias VALUES (8,'Seminario Estructuras de datos I',5,'SED1','I5887');
INSERT INTO roadmapp.materias VALUES (9,'Teoria de la computacion',8,'TECO','I5915');
INSERT INTO roadmapp.materias VALUES (10,'Metodos Matematicos II',8,'CMM2','I5895');
INSERT INTO roadmapp.materias VALUES (11,'Seminario Metodos Matematicos II',5,'SMM2','I5896');

INSERT INTO roadmapp.materias VALUES (12,'Estructuras de datos II',8,'CED2','I5888');
INSERT INTO roadmapp.materias VALUES (13,'Seminario Estructuras de datos II',5,'SED2','I5889');
INSERT INTO roadmapp.materias VALUES (14,'Administracion de redes',8,'ADMR','I5907');
INSERT INTO roadmapp.materias VALUES (15,'Algoritmia',8,'CALG','I5884');
INSERT INTO roadmapp.materias VALUES (16,'Seminario de algoritmia',5,'SALG','I5885');
INSERT INTO roadmapp.materias VALUES (17,'Estadistica y procesos estocasticos',8,'PYES','I5897');

INSERT INTO roadmapp.materias VALUES (18,'Bases de datos',8,'CBDD','I5890');
INSERT INTO roadmapp.materias VALUES (19,'Seminario de Bases de datos',5,'SBDD','I5891');
INSERT INTO roadmapp.materias VALUES (20,'Administracion de servidores',8,'ADSE','I5908');
INSERT INTO roadmapp.materias VALUES (21,'Hipermedia',8,'HIPE','I5910');
INSERT INTO roadmapp.materias VALUES (22,'Ingenieria de software I',8,'IDS1','I5898');

INSERT INTO roadmapp.materias VALUES (23,'Seminario de Ingenieria de software I',5,'SDS1','I5899');
INSERT INTO roadmapp.materias VALUES (24,'Control de proyectos',8,'CODP','I5901');
INSERT INTO roadmapp.materias VALUES (25,'Seguridad de la informacion',8,'SEDI','I5905');
INSERT INTO roadmapp.materias VALUES (26,'Programacion para internet',8,'PPIN','I5909');
INSERT INTO roadmapp.materias VALUES (27,'Ingenieria de software II',8,'IDS2','I5900');

INSERT INTO roadmapp.materias VALUES (28,'Especializante selectiva II',9,'ESP1','#####');
INSERT INTO roadmapp.materias VALUES (29,'Uso, adaptacion y explotacion de sistemas operativos',8,'CESO','I5903');
INSERT INTO roadmapp.materias VALUES (30,'Seminario de uso, adaptacion y explotacion de sistemas operativos',5,'SESO','I5904');

INSERT INTO roadmapp.materias VALUES (31,'Almacenes de datos',8,'ALDD','I5906');
INSERT INTO roadmapp.materias VALUES (32,'Administracion de base de datos',8,'ADBD','I5902');
INSERT INTO roadmapp.materias VALUES (33,'Mineria de datos',8,'MIDD','I5911');
INSERT INTO roadmapp.materias VALUES (34,'Optativa abierta',8,'OPT1','#####');

INSERT INTO roadmapp.materias VALUES (35,'Sistemas basados en conocimiento',8,'CSBC','I5913');
INSERT INTO roadmapp.materias VALUES (36,'Seminario sistemas basados en conocimiento',5,'SSBC','I5914');
INSERT INTO roadmapp.materias VALUES (37,'Clasificacion inteligente de datos',8,'CIDD','I5912');
INSERT INTO roadmapp.materias VALUES (38,'Optativa abierta',8,'OPT2','#####');



INSERT INTO roadmapp.profesores VALUES (1,'Patricia Sanchez Rosario',1);
INSERT INTO roadmapp.profesores VALUES (2,'Belen Anabett Ortiz Pimentel',1);
INSERT INTO roadmapp.profesores VALUES (3,'Veronica Camacho Santillan',1);

INSERT INTO roadmapp.profesores VALUES (4,'Alma Gloria Vazquez Narez',2);
INSERT INTO roadmapp.profesores VALUES (5,'Thelma Isabel Morales Ramirez',2);
INSERT INTO roadmapp.profesores VALUES (6,'Zoila Liliana Herrera Lujan',2);

INSERT INTO roadmapp.profesores VALUES (7,'Sara Edith Villalobos Jimenez',3);

INSERT INTO roadmapp.profesores VALUES (8,'Tonantzin Judith Hernandez Cedillo',4);
INSERT INTO roadmapp.profesores VALUES (9,'Fernando Renan Gonzalez Solis',4);
INSERT INTO roadmapp.profesores VALUES (10,'Maria Del Socorro Real Guerrero',4);

INSERT INTO roadmapp.profesores VALUES (11,'Tonantzin Judith Hernandez Cedillo',5);
INSERT INTO roadmapp.profesores VALUES (12,'Ma. Guadalupe Fernandez Luna',5);
INSERT INTO roadmapp.profesores VALUES (13,'Maria Del Socorro Real Guerrero',5);

INSERT INTO roadmapp.profesores VALUES (14,'Mario Enrique Garcia Guadalupe',6);
INSERT INTO roadmapp.profesores VALUES (15,'Ramon Alejandro Marquez Lugo',6);
INSERT INTO roadmapp.profesores VALUES (16,'Laura Patricia Rivera Resendiz',6);

INSERT INTO roadmapp.profesores VALUES (17,'Felipe Sencion Echauri',7);
INSERT INTO roadmapp.profesores VALUES (18,'Oscar Didier Sanchez Sanchez',7);

INSERT INTO roadmapp.profesores VALUES (19,'Michel Davalos Boites',8);
INSERT INTO roadmapp.profesores VALUES (20,'Alfredo Gutierrez Hernandez',8);
INSERT INTO roadmapp.profesores VALUES (21,'Felipe Sencion Echauri',8);

INSERT INTO roadmapp.profesores VALUES (22,'Abelardo Gomez Andrade',9);
INSERT INTO roadmapp.profesores VALUES (23,'Sulema Ramos Torres',9);
INSERT INTO roadmapp.profesores VALUES (24,'Aurora Espinoza Valdez',9);

INSERT INTO roadmapp.profesores VALUES (25,'Jose Solis Rodrigez',10);
INSERT INTO roadmapp.profesores VALUES (26,'Eloisa Santiago Hernandez',10);
INSERT INTO roadmapp.profesores VALUES (27,'Eli Vianney Roblero Mendez',10);

INSERT INTO roadmapp.profesores VALUES (28,'Jose Solis Rodrigez',11);
INSERT INTO roadmapp.profesores VALUES (29,'Eloisa Santiago Hernandez'11);
INSERT INTO roadmapp.profesores VALUES (30,'Adrian Cervantes Lomeli',11);

INSERT INTO roadmapp.profesores VALUES (31,'Noe Ortega Sanchez',12);
INSERT INTO roadmapp.profesores VALUES (32,'Luis Felipe Mariscal Lugo',12);
INSERT INTO roadmapp.profesores VALUES (33,'Cesar Rodolfo Ascencio Piña',12);

INSERT INTO roadmapp.profesores VALUES (34,'Michel Davalos Boites',13);
INSERT INTO roadmapp.profesores VALUES (35,'Alfredo Gutierrez Hernandez',13);
INSERT INTO roadmapp.profesores VALUES (36,'Felipe Sencion Echauri',13);

INSERT INTO roadmapp.profesores VALUES (37,'Luis Ignacio Sanchez Salazar',14);
INSERT INTO roadmapp.profesores VALUES (38,'Miguel Angel Barba Venegas',14);
INSERT INTO roadmapp.profesores VALUES (39,'Mario Alberto Navarro Velazquez',14);

INSERT INTO roadmapp.profesores VALUES (40,'Ramiro Lupercio Coronel',15);
INSERT INTO roadmapp.profesores VALUES (41,'Miguel Angel Barba Venegas',15);
INSERT INTO roadmapp.profesores VALUES (42,'Mario Alberto Navarro Velazquez',15);

INSERT INTO roadmapp.profesores VALUES (43,'Erasmo Martinez Soltero',16);
INSERT INTO roadmapp.profesores VALUES (44,'Cesar Rodolfo Ascencio Piña',16);
INSERT INTO roadmapp.profesores VALUES (45,'Luque Chang Alberto',16);

INSERT INTO roadmapp.profesores VALUES (46,'Mario Alberto Prado Alonso',17);
INSERT INTO roadmapp.profesores VALUES (47,'Elizabeth Maritza Lopez Alcala ',17);
INSERT INTO roadmapp.profesores VALUES (48,'Lizbeth Diaz Caldera',17);

INSERT INTO roadmapp.profesores VALUES (49,'Angel Tonatihu Hernandez Casas',18);
INSERT INTO roadmapp.profesores VALUES (50,'Ruben Nuñez Ortega',18);
INSERT INTO roadmapp.profesores VALUES (51,'Veronica Camacho Santillan',18);

INSERT INTO roadmapp.profesores VALUES (52,'Oscar Didier Sanchez Sanchez',19);
INSERT INTO roadmapp.profesores VALUES (53,'Zoila Liliana Herrera Lujan',19);
INSERT INTO roadmapp.profesores VALUES (54,'Karla Avila Cardenas',19);

INSERT INTO roadmapp.profesores VALUES (55,'Jose de Jesus Soto',20);
INSERT INTO roadmapp.profesores VALUES (56,'Martin Arturo Garcia Gonzales',20);
INSERT INTO roadmapp.profesores VALUES (57,'Felix Arreola Rodrigez',20);

INSERT INTO roadmapp.profesores VALUES (58,'Carlos Camarena Robles',21);
INSERT INTO roadmapp.profesores VALUES (59,'Fabian Rodrigez Macias',21);
INSERT INTO roadmapp.profesores VALUES (60,'Lotsy Beatriz Fonseca Chiu',21);

INSERT INTO roadmapp.profesores VALUES (61,'Thelma Isabel Morales Ramirez',22);
INSERT INTO roadmapp.profesores VALUES (62,'Francisco Gerardo Cuellar Hernandez',22);
INSERT INTO roadmapp.profesores VALUES (63,'Victor Manuel Zamora Ramos',22);

INSERT INTO roadmapp.profesores VALUES (64,'Thelma Isabel Morales Ramirez',23);
INSERT INTO roadmapp.profesores VALUES (65,'Zoila Liliana Herrera Lujan',23);
INSERT INTO roadmapp.profesores VALUES (66,'Ramiro Lupercio Coronel',23);

INSERT INTO roadmapp.profesores VALUES (67,'Linka Vanessa Figueroa Vega',24);
INSERT INTO roadmapp.profesores VALUES (68,'Lotsy Beatriz Fonseca Chiu',24);
INSERT INTO roadmapp.profesores VALUES (69,'Mauricio Rodolfo Arreola Gonzalez',24);

INSERT INTO roadmapp.profesores VALUES (70,'Emmanuel Franco Lopez Velarde',25);
INSERT INTO roadmapp.profesores VALUES (71,'Jose Manuel Jimenez Mora ',25);
INSERT INTO roadmapp.profesores VALUES (72,'Carlos Alberto Guzman Montes',25);

INSERT INTO roadmapp.profesores VALUES (73,'Michel Emanuel Lopez Franco',26);
INSERT INTO roadmapp.profesores VALUES (74,'Samuel Mercado Garibay',26);
INSERT INTO roadmapp.profesores VALUES (75,'Mario Jimenez Rodrigez',26);

INSERT INTO roadmapp.profesores VALUES (76,'Sergio Manuel Bolaños Gutierrez',27);
INSERT INTO roadmapp.profesores VALUES (77,'Miguel Angel Alejandro Islas Toski',27);
INSERT INTO roadmapp.profesores VALUES (78,'Karla Avila Cardenas',27);

INSERT INTO roadmapp.profesores VALUES (79,'####',28);

INSERT INTO roadmapp.profesores VALUES (80,'Violeta Del Rocio Becerra Velazquez',29);
INSERT INTO roadmapp.profesores VALUES (81,'Martha Del Carmen Gutierrez Salmeron',29);
INSERT INTO roadmapp.profesores VALUES (82,'Javier Francisco Quintanilla Moreno',29);

INSERT INTO roadmapp.profesores VALUES (83,'Violeta Del Rocio Becerra Velazquez',30);
INSERT INTO roadmapp.profesores VALUES (84,'Martha Del Carmen Gutierrez Salmeron',30);
INSERT INTO roadmapp.profesores VALUES (85,'Javier Francisco Quintanilla Moreno',30);

INSERT INTO roadmapp.profesores VALUES (86,'Jorge Fausto Hernandez Andrade',31);
INSERT INTO roadmapp.profesores VALUES (87,'Armida Griselda Vazquez Curiel',31);

INSERT INTO roadmapp.profesores VALUES (88,'Patricia Del Rosario Retamoza Vega',32);
INSERT INTO roadmapp.profesores VALUES (89,'Sergio Javier Uribe Nava',32);

INSERT INTO roadmapp.profesores VALUES (90,'Sergio Javier Uribe Nava',33);
INSERT INTO roadmapp.profesores VALUES (91,'Gabriela Luna Retana',33);
INSERT INTO roadmapp.profesores VALUES (92,'Carlos Alberto Guzman Montes',33);

INSERT INTO roadmapp.profesores VALUES (93,'####',34);

INSERT INTO roadmapp.profesores VALUES (94,'Erik Valdemar Cuevas Jimenez',35);
INSERT INTO roadmapp.profesores VALUES (95,'Eduardo Rangel Heras',35);
INSERT INTO roadmapp.profesores VALUES (96,'Jose Antonio Aviña Mendez',35);

INSERT INTO roadmapp.profesores VALUES (97,'Ramiro Lupercio Coronel',36);
INSERT INTO roadmapp.profesores VALUES (98,'Jorge De Jesus Galvez Rodriguez',36);
INSERT INTO roadmapp.profesores VALUES (99,'Julio Esteban Valdes Lopez',36);

INSERT INTO roadmapp.profesores VALUES (100,'Elsa Estrada Guzman',37);
INSERT INTO roadmapp.profesores VALUES (101,'Luis Antonio Medellin Serna',37);
INSERT INTO roadmapp.profesores VALUES (102,'Daniel Omar Landa Horta',37);

INSERT INTO roadmapp.profesores VALUES (103,'####',38);