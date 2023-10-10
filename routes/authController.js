const express = require('express');
const router = express.Router();
const db = require('../database/mysql').pool;
const bcrypt = require('bcrypt');

// Rota de login
router.post('/users', async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await getUserByUsername(username);

    if (!user) {
      return res.status(401).json({ error: 'Credenciais inválidas' });
    }

    const passwordMatch = await bcrypt.compare(password, user.password);

    if (passwordMatch) {
      res.status(200).json({ message: 'Login bem-sucedido' });
    } else {
      res.status(401).json({ error: 'Credenciais inválidas' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro no servidor' });
  }
});

// Rota para mostrar todos os usuários
router.get('/users', async (req, res) => {
  try {
    const users = await getAllUsersFromDatabase(); // Implemente esta função para buscar todos os usuários

    return res.status(200).json(users);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Erro no servidor' });
  }
});

// Rota para mostrar um usuário por ID
router.get('/users/:id', async (req, res) => {
  const userId = req.params.id;

  try {
    const user = await getUserByIdFromDatabase(userId); // Implemente esta função para buscar um usuário por ID

    if (!user) {
      return res.status(404).json({ error: 'Usuário não encontrado' });
    }

    return res.status(200).json(user);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Erro no servidor' });
  }
});

async function getUserByUsername(username) {
  return new Promise((resolve, reject) => {
    db.getConnection((err, conn) => {
      if (err) {
        reject(err);
      }

      conn.query(
        'SELECT * FROM projetotcc.login WHERE username = ?',
        [username],
        (error, results, fields) => {
          conn.release();
          if (error) {
            reject(error);
          }

          if (results.length === 1) {
            resolve(results[0]);
          } else {
            resolve(null);
          }
        }
      );
    });
  });
}

// Implemente a função para buscar todos os usuários no banco de dados
async function getAllUsersFromDatabase() {
  // Sua lógica para consultar e retornar todos os usuários aqui
}

// Implemente a função para buscar um usuário por ID no banco de dados
async function getUserByIdFromDatabase(userId) {
  // Sua lógica para consultar e retornar um usuário por ID aqui
}

module.exports = router;
