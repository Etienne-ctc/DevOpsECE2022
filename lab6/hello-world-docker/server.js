'use strict';

const express = require('express');

const PORT = 8080;

const app = express();
app.get('/', (req, res) => {
  res.send('Hello World from Docker!\n This a shared docker');
});

app.listen(PORT);
console.log(`The docker is Running on http://localhost:${PORT}`);
