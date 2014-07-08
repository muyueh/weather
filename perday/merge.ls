require! [request, cheerio, async, fs]

{join} = require "prelude-ls"

lsfl = ["evap" "precp" "solar" "temp_max" "temp_min" "temp"]
l = lsfl.length

all = {}
all-ls = []

change-date = ->
	it.getFullYear! + "-" + (it.getMonth! + 1) + "-" + it.getDate!

printing = ->
	nndf = -> if it is undefined or it is "undefined" then 0 else it

	s = ""
	all-ls := all-ls.map -> s += (change-date it.dt) + "\t" + nndf(it.evap) + "\t" + nndf(it.precp) + "\t" + nndf(it.solar) + "\t" + nndf(it.temp_max) + "\t" + nndf(it.temp_min) + "\t" + nndf(it.temp) + "\n"

	console.log s

flcnt = 0
merging = ->

	for dt of all
		itm = all[dt]
		itm.dt = new Date(dt)
		all-ls.push itm

	all-ls := (all-ls.sort (a, b)-> a.dt - b.dt)

	console.log all-ls

	# printing!	

	

lsfl.map (d,i)->
	err, data <- fs.readFile "./" + d + "_ls.tsv", "utf-8"
	
	ls-data = data.split "\n"

	datacnt = 0
	ls-data.map (it, j)->
		s = it.split "\t"
		ld = new Date(s[0])
		dt = ld
		v = s[1]

		if all[dt] is undefined 
			all[dt] = {}

		all[dt][d] := v

		if ++datacnt is (ls-data.length - 1)
			if ++flcnt is (lsfl.length - 1)
				# merging!
				all |> JSON.stringify _, null, "	" |> console.log
	# 	all[d] = 0

	# console.log i
	# console.log all
	# if (i is lsfl.length - 1) then console.log all
		


		# console.log d
		

		# l = data.length

		# if (j is ls-data.length - 1) and (i is lsfl.length - 1)
		# 	all |> JSON.stringify _, null, "	" |> console.log

	# all |> JSON.stringify _, null, "	" |> console.log

	# merging!

		# all |> JSON.stringify _, null, "	" |> console.log



		# join "\n" all.map -> it
		
		
		# console.log join "\n" data.map -> 
		# 	it.evap + "\t" + it.precp + "\t" + it.solar + "\t" + it.temp_max + "\t" + it.temp_min + "\t" + it.temp

		# join "\n" (it.map -> join "\t" it)
