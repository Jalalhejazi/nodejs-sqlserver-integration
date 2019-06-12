var express = require('express');
var router 	= express.Router();
var config 	= require('./config');
var package = require('../package.json');


/* GET about apge */
router.get('/', function(req, res, next) {
 let data =  {
 	title : config.title,
	package: package 
}

  res.render('about', data );
});

module.exports = router;
