const express = require('express');
const fileUpload = require('express-fileupload');
const fs = require('fs');

const port = 80;
const filesDir = 'files';
const app = express();

fs.mkdirSync(filesDir);

app.use(fileUpload({}));

app.post('/', (req, res) => {
  if (req.files && req.files['file']) {
    req.files['file'].mv(`${filesDir}/${req.files['file'].name}`, err => {
      if (err) {
        console.error(err);
        res.sendStatus(500);   
      } else {
        res.sendStatus(200);
      }
    });
  } else {
    res.sendStatus(400);
  }
});

app.listen(port, () => console.log(`Listening on port ${port}`));
