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
function get-microservice-api{
	
	$img = "jalalhejazi/microservice_api"
	
	$e1= "serverName=$env:COMPUTERNAME"
	$e2= "databaseName=AdventureworksLT2017"
	$e3= "databaseUser=sa"
	$e4= "databaseSecret=Djakp88t"
	$e5= "encryption=false"
	$port = "2222:2222"

	docker pull $img
    docker run -d -p $port -e $e1 -e $e2 -e $e3 -e $e4 -e $e5  $img
    docker container ls
}

```