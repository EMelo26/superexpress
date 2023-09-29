const http = require("http");
const port = process.env.PORT || 8001;

const app = require('./app.js');
const server = http.createServer(app);

server.listen(port);
