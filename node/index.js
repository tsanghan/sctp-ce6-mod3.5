// before rum
//npm install express

// to run
// npm start

'use strict';

const express = require('express');

// Constants
const PORT = process.env.APP_PORT || 8080;
const HOST = '0.0.0.0';
const OS = require('os');
const ENV = 'DEV';


// App
const app = express();
app.get('/', (req, res) => {
  res.statusCode = 200;
  // const msg = 'Hello from tsanghan-ce6-Node!';
  res.json({"Hello":"from tsanghan-ce6-Node!"});
});

app.get('/test', (req, res) => {
  res.statusCode = 200;
  const msg = 'Hello from /test tsanghan-ce6-Node!';
  res.json({"Hello":"from /test tsanghan-ce6-Node!"});
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);