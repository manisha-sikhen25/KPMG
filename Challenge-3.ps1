$object = [pscustomobject]@{
    a = [pscustomobject]@{

        b = [pscustomobject]@{
                c = 'd'
        }
        }

        
    

}



function getKey($dict)
{
    $keys = $dict | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name 
    if ($keys.Count -ne 1){
       
        write-host $dict.keys.
        }
    else{
        return $dict.$keys
        }
}


 function recursionfn {
 
 param(
        [PSObject]$object, 
        $key
    )
 #if ($key -like ($object| gm | select Name) )
 if (($object | gm|  Where-Object -Property MemberType -Like 'NoteProperty').Name -like $key)
       {         
            return ($object1.$key), $key  
            break
        }
           
       
       
    else{
        $object1 = $object.(($object | gm|  Where-Object -Property MemberType -Like 'NoteProperty').Name)
        $nestedKey = getKey($object)
        
        return recursionfn $nestedKey  $Key
        }

 }

 $str = 'c'
$value = recursionfn $object $str
Write-Host $value[0]