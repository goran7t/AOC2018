Class AOC.Day1 Extends AOC.Common
{

Parameter InputFile = "C:\Advent\input1.txt";

ClassMethod One(input As %String = {..#InputFile}) As %Integer
{
	set result = 0
	
	set file = ##class(%File).%New(input)
    set sc = file.Open( "R" ) 
    if $$$ISERR(sc) quit

    while 'file.AtEnd {
	    set str=file.ReadLine()
	    set result = result + str
    }
    
    do file.Close()
   
	quit result
}

ClassMethod Two3(input As %String = {..#InputFile}) As %Integer
{
	set result = 0
	set end = 0
	set counter = 0
	
	set temp = ##class(%ArrayOfDataTypes).%New()
	set file = ##class(%File).%New(input)
	set sc = file.Open("R")
	if $$$ISERR(sc) quit
	
	while 'end {
		set str=1+file.ReadLine()
		set result = result + str
		w !, str _ " : " _ result
		if (file.AtEnd) {
			if counter = 3 {
				set end = 1
			}
		}
		else {
			set counter = counter + 1
			do file.Rewind()
			w !, "Premotao"
		}
	}
	//do file.Rewind()
	do file.Close()
	
	quit result
}

ClassMethod Two(input As %String = {..#InputFile}) As %Integer
{
	set result = 0
	set end = 0
	set temp = ##class(%ArrayOfDataTypes).%New()
	
	set file = ##class(%File).%New(input)
    set sc = file.Open("R") 
    if $$$ISERR(sc) quit

    while 'end {
	    set str=file.ReadLine()
	    if file.AtEnd {
		    do file.Rewind()
		    continue
	    }
	    set result = result + str
	    if temp.IsDefined(result) quit
	    do temp.SetAt(temp.GetAt(result)+1,result)
	}
	
    do file.Close()
    
	quit result
}

ClassMethod Test(input As %String = {..#InputFile}) As %Integer
{
	set result=0
	set end = 0
	set counter = 0
	set file = ##class(%File).%New(input)
	set sc = file.Open("R")
	if $$$ISERR(sc) quit
	
	while 'end {
		set str=file.ReadLine()
		if file.AtEnd {
			set counter = counter + 1
			w !,end
			if counter > 2 set end=1
			w !,end
			do file.Rewind()
			continue
		}
		;continue:str=""
		w !, str
	}
	do file.Close()
	
	w !, "Ende"
	
	quit result
}

}
