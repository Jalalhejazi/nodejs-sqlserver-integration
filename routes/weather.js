var express = require('express');
var router 	= express.Router();
var fetch   = require("node-fetch");

router.get('/', function(req, res, next) {

	const URL    = 'http://www.henrikdemant.com/weather/realtime.txt'

	let response = fetch(URL)
	.then( res  => res.text())
	.then( data => {
		const temperaturArray  = data.split(/(\s+)/)

		const temperaturObject = {
		 Dato    			: temperaturArray[0],
		 Tid     			: temperaturArray[2],
		 temperatur 		: temperaturArray[4]
		}

		res.json ( temperaturObject )
	
	})




});

module.exports = router;
