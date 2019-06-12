var express 	= require('express');
var router 		= express.Router();
var env 		= require('./env');
var config 		= require('./config');


/* GET home page. */
router.get('/', function(req, res, next) {
	

 let data =  { 
	 title: 			config.title ,
	 serverName: 		env.server ,
	 databaseName : 	env.options.database ,
	 encryption : 		env.options.encrypt
}
  res.render('index', data );
});

module.exports = router;
