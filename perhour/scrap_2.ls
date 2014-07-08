require! [request, cheerio, async]
{lists-to-obj, flatten, join} = require "prelude-ls"

request = request.defaults jar: true

id = ["46688" "46690" "46691" "46692" "46693" "46694" "46695" "46699" "46705" "46706" "46708" "46711" "46730" "46735" "46741" "46744" "46748" "46749" "46753" "46754" "46755" "46757" "46759" "46761" "46762" "46765" "46766" "46777" "46799" ]

ls-date = []
ls-easy-date = []

for y from 2013 to 2014
	for m from 1 to 12
		for d from 1 to 31
			ls-date.push (y + "" + (if m < 10 then ("0" + m) else m) + (if d < 10 then "0" + d else d))
			ls-easy-date.push (y + "-" + m + "-" + d)


action = for let idx from 0 to (ls-date.length - 1) #need the let	
	(p) ->
		err, res, body <- request "http://www.cwb.gov.tw/V7/climate/30day/Data/46692_" + ls-date[idx] + ".htm" 

		day-result = []

		$ = cheerio.load body 
		row = $ "table table tr"  .first!.next!

		s = ""

		while row.text!
			r = (row.children!.map -> @text!.replace "\r\n", "")
			r.unshift(ls-easy-date[idx])
			r |> day-result.push

			row = row.next!

		p null, day-result


err, data <- async.series action


# ### to .tsv file
console.log join "\n" data.map -> join "\n" (it.map -> join "\t" it)
