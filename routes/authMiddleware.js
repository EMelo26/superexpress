function authenticate(req, res, next) {
    const token = req.header('Authorization');
  
    if (!token) {
      return res.status(401).json({ error: 'Token de autenticação não fornecido' });
    }
  
    // Verifique o token JWT aqui e decida se o usuário está autenticado ou não
    // Você pode usar bibliotecas como o jsonwebtoken para verificar o token
  
    if (usuarioNaoAutenticado) {
      return res.status(401).json({ error: 'Token de autenticação inválido' });
    }
  
    // Se o usuário estiver autenticado, chame next() para permitir o acesso à rota protegida
    next();
  }
  
  module.exports = {
    authenticate,
  };
  