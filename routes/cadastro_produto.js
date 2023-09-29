const express = require('express');
const router = express.Router();
const db = require('../database/mysql').pool; // Importe a conexão com o MySQL

// Rota para cadastrar um novo produto
router.post('/cadastro_produto', (req, res) => {
  const { nome, descricao, preco } = req.body;
  
  // Verifique se todos os campos necessários foram fornecidos
  if (!nome || !descricao || !preco) {
    return res.status(400).json({ error: 'Todos os campos são obrigatórios' });
  }
  
  // Consulta no banco de dados para inserir um novo produto
  db.getConnection((err, conn) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Erro no servidor' });
    }
    
    conn.query(
      'INSERT INTO projetotcc.produtos (nome, descricao, preco) VALUES (?, ?, ?)',
      [nome, descricao, preco],
      (error, results, fields) => {
        conn.release(); // Libere a conexão
        
        if (error) {
          console.error(error);
          return res.status(500).json({ error: 'Erro ao cadastrar o produto' });
        }
        
        return res.status(201).json({ message: 'Produto cadastrado com sucesso' });
      }
    );
  });
});

// Outras rotas relacionadas a produtos podem ser adicionadas aqui, como atualização, exclusão, consulta, etc.

module.exports = router;
