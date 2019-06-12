param(
    $config = 'development' ,
    $containerName='microservice_api'
)

function microservice_api_clear {
    docker container rm $containerName --force
}

function microservice_api_build {
    docker build -t $containerName .
}

function microservice_api_run {
    $port    = "2222:2222"
    $config  = "./$config.env"
    
    $workdir = "/usr/src/app"
    
    docker run --name $containerName --env-file $config --rm  --workdir $workdir -p $port -d $containerName
}


function microservice_api_browse {
     $cmd = "HTTP localhost:2222/"
     $cmd
}


function microservice_api_push {
   # push to docker hub
   $remoteImageName = "jalalhejazi/microservice_api" 
   docker build -t $remoteImageName .
   docker push $remoteImageName
}

function azure_hosting_appsettings {
  param(
      $title          ,
      $serverName     ,
      $databaseName   ,
      $databaseUser   , 
      $databaseSecret ,
      $transportEncyrption ='true'
  )

  $resourceGroup  = 'microservices'
  $webappName     = 'microservice-api'
  
  $env00 = "title=$title"
  $env01 = "serverName=$serverName"
  $env02 = "databaseName=$databaseName"
  $env03 = "databaseUser=$databaseUser"
  $env04 = "databaseSecret=$databaseSecret"
  $env05 = "encryption=$transportEncyrption"
  
  az webapp config appsettings set -g $resourceGroup -n $webappName --settings $env00
  az webapp config appsettings set -g $resourceGroup -n $webappName --settings $env01
  az webapp config appsettings set -g $resourceGroup -n $webappName --settings $env02
  az webapp config appsettings set -g $resourceGroup -n $webappName --settings $env03
  az webapp config appsettings set -g $resourceGroup -n $webappName --settings $env04
  az webapp config appsettings set -g $resourceGroup -n $webappName --settings $env05
  

  # Must restart before changes works online
  az webapp restart -g $resourceGroup -n $webappName
}


function get-product-info {
<#
.DESCRIPTION
    get microservice api hosted on Azure Web app for containers
.EXAMPLE
    # 
    get-product-info 
    get-product-info | where productCost_USD -lt 10
    get-product-info | select -First 10 
    get-product-info |select -First 10 | ConvertTo-Csv -NoTypeInformation
    get-product-info |select -First 10 | ConvertTo-Json
    get-product-info |select -First 10 | ConvertTo-Html
#>
    $remoteAddress = "http://microservice-api.azurewebsites.net/product/version3"
    $Data    = Invoke-RestMethod -Uri $remoteAddress
    write-output $Data
}

function main {
    npm install 
    microservice_api_clear
    microservice_api_build
    microservice_api_run
    microservice_api_browse
}


main