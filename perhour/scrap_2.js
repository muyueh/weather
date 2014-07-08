// Generated by LiveScript 1.2.0
var request, cheerio, async, ref$, listsToObj, flatten, join, id, lsDate, lsEasyDate, i$, y, j$, m, k$, d, action, res$, to$;
request = require('request');
cheerio = require('cheerio');
async = require('async');
ref$ = require("prelude-ls"), listsToObj = ref$.listsToObj, flatten = ref$.flatten, join = ref$.join;
request = request.defaults({
  jar: true
});
id = ["46688", "46690", "46691", "46692", "46693", "46694", "46695", "46699", "46705", "46706", "46708", "46711", "46730", "46735", "46741", "46744", "46748", "46749", "46753", "46754", "46755", "46757", "46759", "46761", "46762", "46765", "46766", "46777", "46799"];
lsDate = [];
lsEasyDate = [];
for (i$ = 2013; i$ <= 2014; ++i$) {
  y = i$;
  for (j$ = 1; j$ <= 12; ++j$) {
    m = j$;
    for (k$ = 1; k$ <= 31; ++k$) {
      d = k$;
      lsDate.push(y + "" + (m < 10 ? "0" + m : m) + (d < 10 ? "0" + d : d));
      lsEasyDate.push(y + "-" + m + "-" + d);
    }
  }
}
res$ = [];
for (i$ = 0, to$ = lsDate.length - 1; i$ <= to$; ++i$) {
  res$.push((fn$.call(this, i$)));
}
action = res$;
async.series(action, function(err, data){
  return console.log(join("\n", data.map(function(it){
    return join("\n", it.map(function(it){
      return join("\t", it);
    }));
  })));
});
function fn$(idx){
  return function(p){
    return request("http://www.cwb.gov.tw/V7/climate/30day/Data/46692_" + lsDate[idx] + ".htm", function(err, res, body){
      var dayResult, $, row, s, r;
      dayResult = [];
      $ = cheerio.load(body);
      row = $("table table tr").first().next();
      s = "";
      while (row.text()) {
        r = row.children().map(fn$);
        r.unshift(lsEasyDate[idx]);
        dayResult.push(
        r);
        row = row.next();
      }
      return p(null, dayResult);
      function fn$(){
        return this.text().replace("\r\n", "");
      }
    });
  };
}