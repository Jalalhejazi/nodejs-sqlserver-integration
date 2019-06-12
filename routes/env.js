
require('dotenv').config()

let connectionString = {
    "userName": 	process.env.databaseUser ,
    "password": 	process.env.databaseSecret,
    "server": 		process.env.serverName ,
    "options": {
      "database": 	process.env.databaseName,
      "encrypt": 	process.env.encryption
    }
}



module.exports = connectionString