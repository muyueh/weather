require! [async]

action = for let m from 1 to 12
	for let d from 1 to 12
		(p) ->
			p null, (m + "-" + d)
		# console.log(m + "-" + d)

err, data <- async.series action
console.log data



# action = for let m from 1 to 12
# 	(p) ->
# 		p null, m

# err, data <- async.series action

# console.log data