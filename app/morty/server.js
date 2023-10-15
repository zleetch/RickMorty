var express = require("express")
var app = express()

var HTTP_PORT = 8002

app.listen(HTTP_PORT, () => {
    console.log("Server running on port %PORT%".replace("%PORT%", HTTP_PORT))
});

app.get("/morty", (req, res, next) => {
    res.json({"message": "Hello i'm Morty"})
});

app.use(function(req, res){
    res.status(404);
});