const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');

// Middleware para registrar informações de solicitação no console
app.use(morgan('dev'));

// Middleware para analisar os corpos das solicitações HTTP
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Configuração de cabeçalhos CORS para permitir qualquer origem (geralmente usado durante o desenvolvimento)
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
    if (req.method === "OPTIONS") {
        res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
        return res.status(200).send({});
    }
    next();
});

// Roteamento de produtos
const produtosRoutes = require('./routes/produtos');
app.use('/produtos', produtosRoutes);

// Roteamento de pedidos
const pedidosRoutes = require('./routes/pedidos');
app.use('/pedidos', pedidosRoutes);

// Roteamento de usuários
const usersRoutes = require('./routes/users'); // Importe o módulo users.js da pasta routes
app.use('/users', usersRoutes); // Defina uma rota base para os endpoints de usuário

// Tratamento de erro para rota não encontrada
app.use((req, res, next) => {
    const erro = new Error("Não encontrado");
    erro.status = 404;
    next(erro);
});

// Tratamento de erro geral
app.use((error, req, res, next) => {
    res.status(error.status || 500).json({
        erro: { mensagem: error.message }
    });
});

module.exports = app;
