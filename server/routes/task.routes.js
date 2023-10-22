const Router = require("express");
const DatabaseManagment = require("../database.js");

const router = Router();
const db = new DatabaseManagment();

router.get("/", (req, res) => {
  res.send("Hello world desde task routes");
});

//obtiene todos los usuarios
router.get("/api/usuarios", db.getUsers); 
/*obtiene un usuario buscando por id
 requiere un json --> {"id" : 1}*/
 router.get("/api/user/:id", db.getUserById); 
//crea  usuarios
router.post("/api/crearUsuario", db.createUser);
//elimina usuarios por id los usuarios
router.delete("/api/borrarUsuario/:id", db.deleteUser);
//actualiza  los usuarios
router.put("/api/actualizarUsuario/:id", db.updateUser);

router.post("/api/login", db.searchUserLogin);



//obtiene todas las materias
router.get("/api/materias", db.getMaterias); 

//obtiene todos los profesores
router.get("/api/profesores", db.getProfesores); 

// obtiene la fecha actual
router.get("/api/now", db.getNow); 


//obtiene el roadmap de un usuario buscando por id , requiere un json --> {"userId" : 1}
router.get("/api/roadmap", db.getRoadmapUserById);

/*
busca un usuario existente con su email y password , requiere un json --> 
{"email" :"usuario1@alumnos.udg.mx","password" : "pa$$wd1"}
retornara su id 
 */
/*router.get("/api/login", db.searchUser);*/


/*registrara un usuario con email y password , requiere un json -->
{
  "email":"usuario5@alumnos.udg.mx",
  "password" : "pa$$wd5"
}

si la insercion fue exitosa retornara -->
{
  "result": 1
}
*/
router.post("/api/createUser",db.createUser);

/*
asignara un roadmap para un usuario y actualizara sus creditos, requeire un json con las materias que no ha cursado,semestres deseados, y id-->
{
  "materias": [
    {
      "id": 1,
      "namem": "Programacion",
      "numcredits": 8,
      "clave": "CPRO",
      "codigo": "I5882"
    },
    {
      "id": 2,
      "namem": "Seminario De Programacion",
      "numcredits": 5,
      "clave": "SPRO",
      "codigo": "I5883"
    },
    {
      "id": 3,
      "namem": "Matematicas Discretas",
      "numcredits": 8,
      "clave": "CMAT",
      "codigo": "I5892"
    }
  ],
  "semestres" : 3,
  "id": 1
} 
si la operacion es exitosa retornara -->
{
  "result": 1
}
*/
router.post("/api/setRoadmapUser",db.setRoadmapUser);

/* recupera las recomendaciones para una materia en especifico , requiere un json con el nombre de la materia -->
{
  "nameMateria" : "Programacion"
}
*/
router.get("/api/getRecomendaciones",db.getRecomendaciones)

module.exports = router;