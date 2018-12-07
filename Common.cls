Class AOC.Common [ Abstract ]
{

ClassMethod PartOne(args...) As %Status
{
		set start = $piece($zts, ",", 2)
		set result = ..One(args...)
		set end = $piece($zts, ",", 2)
		
		write !, $$$FormatText("Result: %1", result)
		write !, $$$FormatText("Time: %1 sec.", end - start)
		
		quit $$$OK
}

ClassMethod PartTwo(args...) As %Status
{
		set start = $piece($zts, ",", 2)
		set result = ..Two(args...)
		set end = $piece($zts, ",", 2)
		
		write !, $$$FormatText("Result: %1", result)
		write !, $$$FormatText("Time: %1 sec.", end - start)
		
		quit $$$OK
}

}
