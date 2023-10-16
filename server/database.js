const { Pool } = require("pg");
const Roadmap = require("./roadmap");

class DatabaseManagment {
  constructor() {
    const config = {
      user: "postgres",
      host: "localhost",
      password: "admin",
      database: "postgres",
      port: 5433,
    };
    this.pool = new Pool(config);
  }

  getMaterias = async (req, res) => {
    try {
      const result = await this.pool.query("SELECT * FROM roadmapp.materias");
      res.send(result.rows);
    } catch (e) {
      res.send(e);
    }
  };

  getProfesores = async (req, res) => {
    try {
      const result = await this.pool.query("SELECT * FROM roadmapp.profesores");
      res.send(result);
    } catch (e) {
      res.send(e);
    }
  };

  getNow = async (req, res) => {
    try {
      const result = await this.pool.query("SELECT NOW()");
      res.send(result);
    } catch (e) {
      res.send(e);
    }
  };

  getRoadmapUserById = async (req, res) => {
    try {
      const id = req.body.userId;
      const result = await this.pool.query(
        "SELECT * FROM roadmapp.usuarios WHERE id = ($1)",
        [id]
      );
      if (result.rows.length === 0) {
        return res.status(404).json({
          message: "User not found",
        });
      } else {
        const cadenaRoadmap = result.rows[0].roadmap;
        const obtenerMaterias = await this.pool.query(
          "SELECT * FROM roadmapp.materias"
        );
        const listaMaterias = obtenerMaterias.rows;
        const algoritmoRoadmap = new Roadmap(listaMaterias);
        const roadmap = algoritmoRoadmap.toSeparateRoadmap(cadenaRoadmap);
        res.send(roadmap);
      }
    } catch (e) {
      res.send(e);
    }
  };

  searchUserLogin = async (req, res) => {
    try {
      const email = req.body.email;
      const passwd = req.body.passwd;
      const result = await this.pool.query(
        "SELECT email, passwd FROM roadmapp.usuarios WHERE email = $1 AND passwd= $2",
        [email, passwd]
      );

      if (result.rows.length === 0) {
        console.log("Credenciales incorrectas")
        return res.status(401).json({
          message: "Credenciales incorrectas",
        });

      }
      // Autenticación exitosa
      console.log("Autenticacion: " + result.rows.length )
      return res.status(200).json({
        message: "Autenticación exitosa",
      });
    } catch (e) {
      console.error(e);
      res.status(500).json({
        message: "Error en el servidor",
      });
    }
  };


  createUser = async (req, res) => {
    try {
      const { email, passwd } = req.body;

      // Realiza una verificación para comprobar si el correo ya existe en la base de datos
      const userExists = await this.pool.query("SELECT * FROM roadmapp.usuarios WHERE email = $1", [email]);
      //si el correo ya existe, devuelve un mensaje de error
      if (userExists.rows.length > 0) {
        //errores 400, indican que la solicitud contienen errores debido a acciones del cliente
        res.status(400).json({ success: false, message: "El correo electrónico ya está en uso" });
      } else {
        // Caso contrario, correo no existe, procede con la inserción
        const result = await this.pool.query("INSERT INTO roadmapp.usuarios (email, passwd) VALUES ($1, $2)", [email, passwd]);
        if (result.rowCount !== 0) {
          res.json({ success: true, message: "Usuario registrado exitosamente" });
        }
      }
    } catch (e) {

      res.status(500).json({ success: false, message: "Error en el servidor", error: e.message });
    }
  };

  getUsers = async (req, res) => {
    console.log("getUser")
    try {
      const result = await this.pool.query("SELECT * FROM roadmapp.usuarios");
      res.send(result.rows);
    } catch (e) {
      res.send(e);
    }
  };

  getUserById = async (req, res) => {
    try {
      const id = req.params.id;
      const result = await this.pool.query(
        "SELECT * FROM roadmapp.usuarios WHERE id = ($1)",
        [id]
      );
      if (result.rows.length === 0) {
        return res.status(404).json({
          message: "User not found",
        });
      } else {
        res.send(result.rows);
      }
    } catch (e) {
      res.send(e);
    }
  };

  deleteUser = async (req, res) => {
    try {
      const id = req.params.id;
      const result = await this.pool.query("DELETE FROM roadmapp.usuarios WHERE id = ($1)", [id]);

      if (result.rowCount === 0) {
        return res.status(404).json({
          message: "User not found",
        });
      } else {
        res.status(200).json({
          message: "User deleted successfully",
        });
      }
    } catch (e) {
      console.error(e);
      res.status(500).json({
        message: "Internal server error",
      });
    }
  };

  updateUser = async (req, res) => {
    try {
      const { id, email, passwd, roadmap, creditosAct } = req.body;

      const query = "UPDATE roadmapp.usuarios SET email = $1, passwd = $2, roadmap = $3, creditosAct = $4 WHERE id = $5";
      const values = [email, passwd, roadmap, creditosAct, id];
      const result = await this.pool.query(query, values);
      if (result.rowCount === 0) {
        return res.status(404).json({ message: "User not found" });
      }
      res.status(200).json({ message: "User updated successfully" });
    } catch (e) {
      console.error(e);
      res.status(500).json({ message: "Internal server error" });
    }
  };

  /*  searchUser = async (req, res) => {
    try {
      const userEmail = req.body.email;
      const userPassword = req.body.password;
      const result = await this.pool.query(
        "SELECT id FROM roadmapp.usuarios WHERE email=($1) AND passwd =($2)",
        [userEmail, userPassword]
      );
      if (result.rows.length === 0) {
        return res.status(404).json({
          message: "User not found",
        });
      } else {
        const id = result.rows[0].id;
        res.json(id);
      }
    } catch (e) {
      res.send(e);
    }
  };*/

  setRoadmapUser = async (req, res) => {
    try {
      const listaMaterias = req.body.materias;
      const semestres = req.body.semestres;
      const id = req.body.id;

      const algoritmo = new Roadmap(listaMaterias);
      const roadmap = algoritmo.createRoadmap(semestres);

      const result = await this.pool.query("UPDATE roadmapp.usuarios SET roadmap = ($1) WHERE id =($2)", [roadmap, id]);
      if (result.rowCount !== 0) {
        const obtenerMaterias = await this.pool.query("SELECT * FROM roadmapp.materias");
        const materias = obtenerMaterias.rows;
        const algoritmoCreditos = new Roadmap(materias);
        const data = algoritmoCreditos.toSeparateRoadmap(roadmap);

        let sumaTotalCreditos = 0;

        // Recorre la lista y suma los créditos
        for (const materia of data) {
          for (const objetoMateria of materia) {
            sumaTotalCreditos += objetoMateria.creditos;
          }
        }
        sumaTotalCreditos = 274 - sumaTotalCreditos
        //insertamos los creditos en la base de datos
        this.pool.query("UPDATE roadmapp.usuarios SET creditosact = ($1) WHERE id=($2)", [sumaTotalCreditos, id]);

        res.json({ result: 1 });
      }
    } catch (e) {
      res.send(e);
    }
  }

  getRecomendaciones = async (req, res) => {
    try {
      const materia = req.body.nameMateria;
      const recomendaciones = await this.pool.query("SELECT p.nameP AS profesor FROM roadmapp.profesores p JOIN roadmapp.materias m ON p.materiaID = m.id WHERE m.nameM = ($1);", [materia]);
      if (recomendaciones.rowCount !== 0) {
        res.send(recomendaciones.rows)
      } else {
        res.json({ "message": "not found" })
      }
    } catch (e) {
      res.send(e);
    }

  }



}

module.exports = DatabaseManagment;