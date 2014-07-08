require! [request, cheerio, async]
{lists-to-obj, flatten, join} = require "prelude-ls"


request = request.defaults jar: true

action = for let i from 1 to 9 #need the let

	(p) ->
		err, res, body <- request "http://www.cwb.gov.tw/V7/climate/30day/Data/46692_2014060" + i + ".htm" 

		# header = ["time", "hpa", "c", "humid", "windms", "winddir", "precp", "sunh"]

		day-result = []

		$ = cheerio.load body 
		row = $ "table table tr"  .first!.next!

		s = ""

		while row.text!
			(row.children!.map -> @text!.replace "\r\n", "") |> day-result.push
			
			# s += (join '\t' (row.children!.map -> @text!.replace "\r\n", "")) + '\n'
			row = row.next!


		p null, day-result


err, data <- async.series action

# data |> console.log
data |> flatten |> JSON.stringify |> console.log