const app = require('express')();
const https = require('https');
const fs = require('fs');

//GET home route
app.get('/', (req, res) => {
     res.send('<center>You Fool!</center>');
});

https.createServer({
    key: fs.readFileSync('./my_fake_cert.key'),
    cert: fs.readFileSync('./my_fake_cert.crt'),
    ca: [
        fs.readFileSync('./spoofed_ca.crt')
    ]
}, app)
.listen(443);