require! [fs]
{join, drop} = require "prelude-ls"

# fs.writeFile "./cmpl_ls/a.tsv", "hi", -> console.log it

date-from-day = (y, d)->
	date = new Date y, 0
	new Date date.setDate d

# console.log date-from-day 2013, 365
# console.log date-from-day 2012, 366


yr = [1990 to 2014]

nm-ls = ["evap" "precp" "solar" "temp_max" "temp_min" "temp"]
# nm = "evap"


idx = 0
reading = -> 
	err, data <- fs.readFile "./" + nm-ls[idx] + ".tsv", "utf-8"

	rslt = []
	(drop 1 (data.split "\n")).map -> 
		d = null
		it.split "\t" .map (it, i) ->
			if i is 0
				d := it
			# else if it is not '' and it is not '-'
			dt = date-from-day(yr[i - 1], d)
			rslt.push {"d": dt,"v": it}

	fs.writeFile ("./cmpl_ls/" + nm-ls[idx] + ".tsv"), (join "\n" rslt.sort((a, b)-> a.d - b.d).map -> it.d + "\t" + it.v), -> 
		if it then console.log it
		else
			if ++idx < nm-ls.length then reading!


reading!



	
	
