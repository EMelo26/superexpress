const express = require('express');
const router = express.Router();
const db = require('../database/mysql').pool;
const multer = require('multer');

// Configuração do multer
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, file.originalname);
    }
});
const upload = multer({ storage: storage });

// Rota para retornar todos os produtos
router.get('/todos', (req, res, next) => {
    db.getConnection((err, conn) => {
        if (err) {
            return res.status(500).json({ error: 'Erro no servidor' });
        }
        conn.query("SELECT * FROM projetotcc.produtos", (error, resultado, campo) => {
            conn.release();
            if (error) {
                return res.status(500).json({ error: 'Erro ao consultar produtos' });
            }
            res.status(200).json({ mensagem: 'Rota GET funcionando', data: resultado });
        });
    });
});

// Rota para cadastrar um novo produto
router.post('/', upload.single('produto_image'), async (req, res, next) => {
    try {
        const novoProduto = [req.body.name, req.body.preco];
        const conn = await db.getConnection();
        const resultado = await conn.query("INSERT INTO projetotcc.produtos(nome, descricao, preco) VALUES (?, ?)", novoProduto);
        conn.release();
        res.status(200).json({ mensagem: 'Novo Produto Cadastrado', data: resultado });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao cadastrar produto', detalhes: error.message });
    }
});

module.exports = router;
