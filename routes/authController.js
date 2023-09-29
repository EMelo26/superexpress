const express = require('express');
const router = express.Router();
const db = require('../database/mysql').pool;
const bcrypt = require('bcrypt');

// Rota de login
router.post('/login', async (req, res) => {
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

async function getUserByUsername(username) {
  return new Promise((resolve, reject) => {
    db.getConnection((err, conn) => {
      if (err) {
        reject(err);
      }

      conn.query(
        'SELECT * FROM projetotcc.user_acesso WHERE username = ?',
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

module.exports = router;
