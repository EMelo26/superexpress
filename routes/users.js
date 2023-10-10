const express = require('express');
const router = express.Router();
const db = require('../database/mysql').pool;

// Rota para buscar um usuário específico
router.get('/:id', (req, res, next) => {
    db.getConnection((err, conn) => {
        if (err) {
            return res.status(500).json({ error: 'Erro no servidor' });
        }
        conn.query("SELECT * FROM projetotcc.login WHERE user_id = ?", [req.params.id], (error, resultado, campo) => {
            conn.release();
            if (error) {
                return res.status(500).json({ error: 'Erro ao consultar usuário' });
            }
            res.status(200).json({ mensagem: 'Usuário encontrado', data: resultado[0] });
        });
    });
});

module.exports = router;
