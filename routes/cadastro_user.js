const express = require('express');
const router = express.Router();
const db = require('../database/mysql').pool; // Importe a conexão com o MySQL

// Rota para cadastrar um novo usuário
router.post('/cadastro_user', (req, res) => {
  const { username, password, email, telefone } = req.body; // Adicione "telefone" ao destructuring
  
  // Verifique se todos os campos necessários foram fornecidos
  if (!username || !password || !email || !telefone) { // Verifique se "telefone" está presente
    return res.status(400).json({ error: 'Todos os campos são obrigatórios' });
  }
  
  // Consulta no banco de dados para inserir um novo usuário
  db.getConnection((err, conn) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Erro no servidor' });
    }
    
    conn.query(
      'INSERT INTO login (username, email, password, telefone) VALUES (?, ?, ?, ?)', // Inclua "telefone" na consulta
      [username, email, password, telefone], // Inclua "telefone" nos valores
      (error, results, fields) => {
        conn.release(); // Libere a conexão
        
        if (error) {
          console.error(error);
          return res.status(500).json({ error: 'Erro ao cadastrar o usuário' });
        }
        
        return res.status(201).json({ message: 'Usuário cadastrado com sucesso' });
      }
    );
  });
});

// Outras rotas relacionadas a usuários podem ser adicionadas aqui, como autenticação, atualização, exclusão, consulta, etc.

module.exports = router;
