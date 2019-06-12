/***************************************************************************
  Proof Of Concept how to make access to SQLServer Database from code 

****************************************************************************/

var express   = require('express')
var router    = express.Router()


var env                     = require('./env');
var SqlServer_integration   = require('../Jalal/SqlServer_integration')

router.use( (req, res, next) => {
    
    req.sqlserver = SqlServer_integration( env )

    next()
})






/*
  /product/?count=5

  This solution is a big security risk for exposing the Table object model
  Its not recommended to give the application access permission on tables

  Must Redesign Why ?

  * Performance
  * Security
  * Freedom to refactoring
*/
router.get('/version1', function(req, res, next) {
  
  let count = req.query.count || 10 

  let query1 =  
      `SELECT   TOP ${count} 
            pc.Name as categoryName, 
            p.name as productName 
          
          FROM [SalesLT].[ProductCategory] pc 
            JOIN [SalesLT].[Product] p 
               ON pc.productcategoryid = p.productcategoryid
               For JSON PATH
        `
    req.sqlserver( query1 ).output( res )

})









/*
  Version 2 is now using SQLServer View model
  Now the developer do not have any control about 
  the database logic. Only SQL DBA can change the view

  What About input params? 
  How to change params in Views ? 

  /product/version2

*/
router.get('/version2', function(req, res, next) {
  
   let query2 =  'SELECT * FROM JSON.Get_Product_Info'
        
    req.sqlserver( query2 ).output( res )

})







/*
  Version 3 

  Using Stored Procedures for SQL access for optimal perfomance
  
  /product/version3?count=20
  /product/version3?count=20&color=red
  /product/version3?count=20&color=black

*/
router.get('/version3', function(req, res, next) {
  
  let count = req.query.count || 1000
  let color = req.query.color || ''

  let query3 =  `API.Get_Product_Info 
                       @productCount = ${count} , @productColor = '${color}'  `
        
  req.sqlserver( query3 ).output( res )

})










/*
  Version 3 

  The most optimal solution you can get 
  

  /product/version3/color/red
  /product/version3/color/silver
  /product/version3/color/black

  /product/version3/color/black?count=5

*/
router.get('/version3/color/:color', function(req, res, next) {
  
  let count = req.query.count  || 1000
  let color = req.params.color || ' '

  let query3 =  `API.Get_Product_Info 
                                      @productCount = ${count} , 
                                      @productColor = '${color}'  `
        
  req.sqlserver( query3 ).output( res )

})

module.exports = router