echo "hello world"

$array = "abc", "xyz", "pqr"

echo $array

echo "The second item of $array is " $array[1]

$array.GetType()

$array[1] = "2"

# arrays can also be made using @() as the delimiters
$altArray = @('string1', 'string2', 'string4', 'string5')

$altArray

# arrays can also be made using numeric ranges
$numArray = 1..10
$numArray


# notice the type is System.Array
$numArray.GetType();


# we cant add to a system array
# $numArray.Add("item1")

[System.Collections.ArrayList]$ArrayList = $numArray


# built in variables
[string]$aString = ""
[char]$aChar = 'a'
[byte]$aByte = 0
[bool]$aBool = ""
[int]$aInt = 10
[single]$aSingle = 10
[double]$aDouble = 20
[long]$aLong = 10
[array]$aArray = ""
[hashtable]$aHashtable = ""
[xml]$anXML = ""

$ArrayList


$ArrayList.Add("item10")
$ArrayList