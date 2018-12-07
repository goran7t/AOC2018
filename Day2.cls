Class AOC.Day2 Extends AOC.Common
{

Parameter InputFile = "C:\Advent\input2.txt";

ClassMethod One(input As %String = {..#InputFile}) As %Integer
{
	set twos = 0
	set threes = 0
	
	set file = ##class(%File).%New(input)
    set sc = file.Open("R") 
    if $$$ISERR(sc) quit

    while 'file.AtEnd {
	    set str=file.ReadLine()
	    set counter = ##class(%ArrayOfDataTypes).%New()
	    set two = 0
	    set three = 0
	    for i=1:1:$l(str) {
		    set letter=$e(str,i)
		    do counter.SetAt(+counter.GetAt(letter)+1,letter)
	    }
	    set key = ""
	    for {
		    set key = counter.Next(key)
		    quit:key=""
		    if counter.GetAt(key)=2 set two=1
		    if counter.GetAt(key)=3 set three=1
		    if two && three quit
	    }
	    set twos = twos + two
	    set threes = threes + three
    }
    
    do file.Close()
       
	quit threes*twos
}

ClassMethod Two(input As %String = {..#InputFile}) As %Integer
{
	set file = ##class(%File).%New(input)
    set sc = file.Open("R") 
    if $$$ISERR(sc) quit
    
    kill ^temp("Advent",1)
    set result = ""

    while 'file.AtEnd {
	    set str=file.ReadLine()
	    kill ^temp("Advent",2)
	    set l=$l(str)
	    for i=1:1:l {
		    set str1 = $e(str,1,i-1)_$e(str,i+1,l)
		    set letter=$e(str,i)
		    if $g(^temp("Advent",1,str1))'="" {
			    set result = str1
			    quit
		    }
		    set ^temp("Advent",2,str1)=1
	    }
	    if result="" {
		    merge ^temp("Advent",1)=^temp("Advent",2)
	    }
	    else {
		    quit
	    }
    }
    
    do file.Close()
       
	quit result
}

}
