require('./index.js')();

console.inline(['inline','testing']);
setTimeout(function(){
  time1 = console.timer('Test time',true);
  sleep = 1000;
  setTimeout(function(){console.log('console.log(\'test\');');},sleep);
  sleep = sleep+1000;
  setTimeout(function(){console.debug('console.debug(\'test\');');},sleep);
  sleep = sleep+1000;
  setTimeout(function(){console.inline(['inline','testing more']);},sleep);
  sleep = sleep+1000;
  setTimeout(function(){console.inline(['inline2','testing even more']);},sleep);
  sleep = sleep+1000;
  setTimeout(function(){console.info('console.info(\'test\');');},sleep);
  sleep = sleep+1000;
  setTimeout(function(){console.warn('console.warn(\'test\');');},sleep);
  sleep = sleep+1000;
  setTimeout(function(){console.error('console.error(\'test\');');},sleep);
  sleep = sleep+1000;
  setTimeout(function(){time1(true);},sleep);
  sleep = sleep+1000;
  setTimeout(function(){console.inlineEnd();},sleep);
},1000);
