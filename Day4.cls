Class AOC.Day4 Extends AOC.Common
{

Parameter InputFile = "C:\Advent\input4.txt";

ClassMethod InitMatrix(input As %String = {..#InputFile}) As %ArrayOfDataTypes
{
	k ^temp
	set result = 0
	set matrix = ##class(%ArrayOfDataTypes).%New()
	
	set file = ##class(%File).%New(input)
    set sc = file.Open("R") 
    if $$$ISERR(sc) quit
    
    while 'file.AtEnd {
	    set rec=file.ReadLine()
	    set:rec'="" ^temp(rec)=""
    }
    
    do file.Close()
    
    set (guard,begin,end) = 0
    set rec = ""
    for {
	    set rec = $o(^temp(rec))
	    quit:rec=""
	    if $p(rec,"#",2)'="" {
		    set guard = +$p(rec,"#",2)
		    if matrix.GetAt(guard)="" do ..Init(guard,matrix)
		    set begin = 0
		    set end = 0
		    continue
	    }
	    if $f(rec, "falls asleep") {
		    set begin=+$p(rec,":",2)
		    continue
	    }
	    if $f(rec, "wakes up") {
		    set end = +$p(rec,":",2)
		    set row = matrix.GetAt(guard)
		    for i = (begin+1):1:end {
			    do row.SetAt(row.GetAt(i)+1,i)
		    }
		    do matrix.SetAt(row,guard)	    
	    }
    }
    quit matrix
}

ClassMethod One(input As %String = {..#InputFile}) As %Integer
{
	set matrix = ..InitMatrix(input)
    set key = ""
    for {
	    set key = matrix.Next(key)
	    quit:key=""
	    set row = matrix.GetAt(key)
	    for i=0:1:59 {
		    set value = row.GetAt(i)
	    }
    
    }
    
    set theGuard = ..MaxGuard(matrix)
    set result = ..MaxSleep(matrix.GetAt(theGuard))
    
	quit theGuard * result
}

ClassMethod Init(guard As %Integer, matrix As %ArrayOfDataTypes) As %Status
{
	set oneRow = ##class(%ListOfDataTypes).%New()
	for i=1:1:60 do oneRow.Insert(0)
	do matrix.SetAt(oneRow,guard)
	quit
}

ClassMethod MaxGuard(matrix As %ArrayOfDataTypes) As %Integer
{
	set result = 0
	set maxSleep = 0
	
	set key = ""
    for {
	    set key = matrix.Next(key)
	    quit:key=""
	    set sleep = 0
	    set row = matrix.GetAt(key)
	    for i=1:1:60 {
		    set value = row.GetAt(i)
		    set sleep = sleep + value
	    }
	    if (sleep > maxSleep) {
		    set maxSleep=sleep
		    set result = key
	    }    
    }
    
    quit result
}

ClassMethod MaxSleep(guard As %ListOfDataTypes) As %Integer
{
	set max = 0
	set minute = 0
	
	for i=1:1:60 {
		set value = guard.GetAt(i)
		if value > max {
			set max = value
			set minute = (i - 1)
		}
	}
	quit minute
}

ClassMethod MaxSameMinute(matrix As %ArrayOfDataTypes) As %Integer
{
	set resultGuard = 0
	set resultMinute = 0
	set maxSleepOnMinute = 0
	
	set key = ""
    for {
	    set key = matrix.Next(key)
	    quit:key=""
	    set row = matrix.GetAt(key)
	    for i=1:1:60 {
		    set value = row.GetAt(i)
		    if (value > maxSleepOnMinute) {
			    set maxSleepOnMinute=value
			    set resultGuard = key
			    set resultMinute = i - 1
		    }
	    }
    }
    
    quit resultGuard * resultMinute
}

ClassMethod Two(input As %String = {..#InputFile}) As %Integer
{
	set matrix = ..InitMatrix(input)
       
	quit ..MaxSameMinute(matrix)
}

}
