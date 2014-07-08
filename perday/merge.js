// Generated by LiveScript 1.2.0
var request, cheerio, async, fs, join, lsfl, l, all, allLs, changeDate, printing, flcnt, merging;
request = require('request');
cheerio = require('cheerio');
async = require('async');
fs = require('fs');
join = require("prelude-ls").join;
lsfl = ["evap", "precp", "solar", "temp_max", "temp_min", "temp"];
l = lsfl.length;
all = {};
allLs = [];
changeDate = function(it){
  return it.getFullYear() + "-" + (it.getMonth() + 1) + "-" + it.getDate();
};
printing = function(){
  var nndf, s;
  nndf = function(it){
    if (it === undefined || it === "undefined") {
      return 0;
    } else {
      return it;
    }
  };
  s = "";
  allLs = allLs.map(function(it){
    return s += changeDate(it.dt) + "\t" + nndf(it.evap) + "\t" + nndf(it.precp) + "\t" + nndf(it.solar) + "\t" + nndf(it.temp_max) + "\t" + nndf(it.temp_min) + "\t" + nndf(it.temp) + "\n";
  });
  return console.log(s);
};
flcnt = 0;
merging = function(){
  var dt, itm;
  for (dt in all) {
    itm = all[dt];
    itm.dt = new Date(dt);
    allLs.push(itm);
  }
  allLs = allLs.sort(function(a, b){
    return a.dt - b.dt;
  });
  return console.log(allLs);
};
lsfl.map(function(d, i){
  return fs.readFile("./" + d + "_ls.tsv", "utf-8", function(err, data){
    var lsData, datacnt;
    lsData = data.split("\n");
    datacnt = 0;
    return lsData.map(function(it, j){
      var s, ld, dt, v;
      s = it.split("\t");
      ld = new Date(s[0]);
      dt = ld;
      v = s[1];
      if (all[dt] === undefined) {
        all[dt] = {};
      }
      all[dt][d] = v;
      if (++datacnt === lsData.length - 1) {
        if (++flcnt === lsfl.length - 1) {
          return console.log(
          JSON.stringify(all, null, "	"));
        }
      }
    });
  });
});