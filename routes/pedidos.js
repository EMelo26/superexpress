const express = require('express');
const rota = express();


// rota de fato: Retorna todos os produtos
rota.get('/', (req, res, next)=>{
    res.status(200).send({
        mensagem: "rota get pedidos funcionando"
    });
});

// rota tipo post, Cadastra 
rota.post('/', (req, res, next)=>{
    res.status(201).send({
        mensagem: "rota post pedidos funcionando"
    });
});

// rota tipo get, consultando id xclusivo 
rota.get('/:id_pedido', (req, res, next)=>{
    var id_pedido = req.params.id_pedido;

    if( id_pedido === "")
    {
        res.status(200).send({
            mensagem: "pedido não encontrado"
        });
    }
    else
    {
        res.status(200).send({
            mensagem: "rota get com id do pedido: {"+ id_pedido +"}",
            pedido: id_pedido
        });
    }
});

// rota de update, ou patch 
rota.patch('/', (req, res, next)=>{
    res.status(200).send({
        mensagem: "rota path( ou update ¬¬ )  pedidos funcionando"
    });
});

// rota de delete
rota.delete('/', (req, res, next)=>{
    res.status(200).send({
        mensagem: "rota delete( ou delete mesmo ¬¬ ) pedidos funcionando"
    });
});

module.exports = rota;