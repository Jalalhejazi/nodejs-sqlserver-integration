function get-Product-Info {
<#
.DESCRIPTION
    Get Information about product from DataService API

.EXAMPLE
    ## Try it out
    get-Product-Info

    get-product-info | Out-GridView

    get-product-info | Out-File product.txt | notepad product.txt

    get-Product-Info -productCount 10

    get-Product-Info 10

    get-Product-Info  100  | where categoryName -Like 'Mountain Bikes'
   
    get-Product-Info  100  | where categoryName -Like 'Mountain Bikes'
   
    get-Product-Info | where  productName -like '*Mountain-100*'
   
#>
    param (
        [int] $productCount = 500
    )

    $productAddress = "http://localhost:2222/product?count=$productCount"
    $productData    = Invoke-RestMethod -Uri $productAddress

    write-output $productData

}



function get-Mountain-Bikes {
<#
.DESCRIPTION
    Get Information only about Mountain Bikes from DataService API

.EXAMPLE
    # Try it out

    get-Mountain-Bikes

    get-Mountain-Bikes | where productName -like '*Black*'

    get-Mountain-Bikes | where productName -like '*Silver*'

    get-Mountain-Bikes | where productName -like '*Silver, 38*'

    get-Mountain-Bikes | where productName -like '*Silver, 38*' | select productName

#>
    get-Product-Info  1000  | 
    where categoryName -Like 'Mountain Bikes' 
}