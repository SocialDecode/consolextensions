var millisecondsToStr=function(r){function o(r){return r>1?"s":""}var t=Math.floor(r/1e3),e=Math.floor(t/31536e3);if(e)return e+" year"+o(e);var n=Math.floor((t%=31536e3)/86400);if(n)return n+" day"+o(n);var a=Math.floor((t%=86400)/3600);if(a)return a+" hour"+o(a);var f=Math.floor((t%=3600)/60);if(f)return f+" minute"+o(f);var u=t%60;return u?u+" second"+o(u):"less than a second"};
var timers = {
  start : function (cual,showme){
    if(showme)
      console.info(cual.yellow+': Timer started');
    var hrtime = process.hrtime();
    if (!timers[cual]) timers[cual] = 0;
    return function(showme,code){
      var hr = process.hrtime(hrtime);
      var mstime = (hr[0]*1000) + (hr[1]/1000000);
      timers[cual] += mstime;
      if (typeof showme !== 'undefined') {
        var out = '';
        if(typeof code !== 'undefined'){
          out = code+' - ';
        }
        out+=cual.green+': Took '+millisecondsToStr(timers[cual]);
        console.info(out);
        delete timers[cual];
      }
    };
  }
};
module.exports = timers;