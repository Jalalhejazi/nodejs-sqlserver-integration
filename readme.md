## Microservice_api


### How to start

```
npm run start 
```



### Docker run with environment development|test|prod

```
## loads the file './development|test|prod.env'

serverName=192.168.4.103
databaseName=********
databaseUser=***
databaseSecret=***********
encryption=false
title=microservice-api


. ./start.ps1 -config development|test|prod

```


## docker pull from remote hub

```
function get-microservice-sqlserver{
    $img = "jalalhejazi/microservice_sqlserver"

    docker pull $img
    docker run -d -p "1433:1433"  $img
    docker container ls

    $cmd01 = "SQLCMD -S $env:COMPUTERNAME -U sa -P $sa_password -d master -Q 'select @@version' "
    $cmd02 = "SQLCMD -S $env:COMPUTERNAME -U sa -P $sa_password -d AdventureworksLT2017 -Q 'exec API.Get_Product_Info' "
    $cmd03 = "SSMS   -S '$env:COMPUTERNAME,1433' -d 'master' -U 'SA' -p $sa_password -nosplash "

    $cmd01
    $cmd02
    $cmd03
}


```