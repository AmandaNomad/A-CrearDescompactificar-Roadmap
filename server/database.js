const { Pool } = require("pg");
const Roadmap = require("./roadmap");

class DatabaseManagment {
  constructor() {
    const config = {
      user: "postgres",
      host: "localhost",
      password: "postgres",
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

  getUsers = async (req, res) => {
    try {
      const result = await this.pool.query("SELECT * FROM roadmapp.usuarios");
      res.send(result);
    } catch (e) {
      res.send(e);
    }
  };

  getUserById = async (req, res) => {
    try {
      const id = req.body.id;
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

  searchUser = async (req, res) => {
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
  };
}

module.exports = DatabaseManagment;