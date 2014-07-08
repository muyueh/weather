require! [fs]
{join, drop} = require "prelude-ls"


err, data <- fs.readFile "./cmpl_ls/merged.tsv", "utf-8"

change-date = ->
	it.getFullYear! + "-" + (it.getMonth! + 1) + "-" + it.getDate!

os = ""

data = data.split "\n" .filter (it, i)->
	if i > 0
		s = it.split "\t"
		blank = true

		ns = s.map (d, j)->
			if j is 0 then  return change-date(new Date d)
			if j > 0 and not (d is "-" or d is '') then blank := false
			return d

		if blank
			return false 
		else 
			os += (join "\t" ns) + "\n"
			return true

	else # keep header
		os += it + "\n"
		return true


console.log os