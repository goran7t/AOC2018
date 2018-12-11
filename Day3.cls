Class AOC.Day3 Extends AOC.Common
{

Parameter InputFile = "C:\Advent\input3.txt";

ClassMethod One(input As %String = {..#InputFile}) As %Integer
{
	kill ^temp("Advent")
	set result = 0
	
	set file = ##class(%File).%New(input)
    set sc = file.Open("R") 
    if $$$ISERR(sc) quit

    while 'file.AtEnd {
	    set sqr=file.ReadLine()
	    set x = +$zstrip($piece(sqr,"@",2),"<>W")
	    set y = +$piece(sqr,",",2)
	    set dx = +$zstrip($piece(sqr,":",2),"<>W")
	    set dy = +$piece(sqr,"x",2)
	    for i=x:1:x+dx-1 {
		    for j=y:1:y+dy-1 {
			    set ^temp("Advent",i,j)=$data(^temp("Advent",i,j))
		    }
	    }
    }
    
    do file.Close()
    
    // Count overlapped squares
    set (xkey, ykey) = ""
    for {
	    set xkey = $order(^temp("Advent",xkey))
	    quit:xkey=""
	    //w !, "x = " _ xkey
	    for {
		    set ykey = $order(^temp("Advent",xkey,ykey))
		    quit:ykey=""
		    //w !, "y = " _ ykey
		    //w !, "number = " _ ^temp("Advent",xkey,ykey)
		    set result = result + ^temp("Advent",xkey,ykey)
	    }
    }
       
	quit result
}

ClassMethod Two(input As %String = {..#InputFile}) As %Integer
{
	// populate matrix
	do ..One()
	set returnId = 0
	
	set file = ##class(%File).%New(input)
    set sc = file.Open("R") 
    if $$$ISERR(sc) quit
    
    while 'file.AtEnd {
	    set result = 0
	    set sqr=file.ReadLine()
	    set id = +$zstrip($piece(sqr,"#",2),"<>W")
	    set x = +$zstrip($piece(sqr,"@",2),"<>W")
	    set y = +$piece(sqr,",",2)
	    set dx = +$zstrip($piece(sqr,":",2),"<>W")
	    set dy = +$piece(sqr,"x",2)
	    for i=x:1:x+dx-1 {
		    for j=y:1:y+dy-1 {
			    set result=result + ^temp("Advent",i,j)
		    }
	    }
	    if result=0 {
		    set returnId = id
		    quit
	    }
    }
    
    do file.Close()
       
	quit returnId
}

}
              