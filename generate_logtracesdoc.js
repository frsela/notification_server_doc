
var lt = null;
try {
  lt = require("../src/common/logtraces.js").logtraces;
} catch(e) {
  lt = {}
}

function document_logtrace(l) {
  console.log('  <section>');
  console.log('    <title> ID 0x' +
    l.id.toString(16) +
    ' - ' + l.m + '</title>');
  if (l.doc) {
    console.log('    <para>' +
      l.doc + '</para>');
  } else {
    console.log('    <para>' +
      'No detailed description yet</para>');
  }
  console.log('  </section>');
}

function main(level) {
  var levelDesc = "";
  switch (level) {
  case 1:
    levelDesc = "NOTIFY";
    break;
  case 2:
    levelDesc = "ERROR";
    break;
  case 3:
    levelDesc = "CRITICAL";
    break;
  default:
    process.exit(-1);
  }

  console.log('<?xml version="1.0" encoding="utf-8"?>');
  console.log('<section xml:id="logtraces_'+levelDesc+'_generated"');
  console.log('      xmlns="http://docbook.org/ns/docbook"');
  console.log('      version="5.0" xml:lang="en">');
  console.log('  <!-- THIS IS A GENERATED DOCUMENT, DON\'T EDIT IT ! -->');

  console.log('  <title>'+levelDesc+' level</title>');
  Object.keys(lt).forEach(function(k) {
    if ( (lt[k].id >= level<<12) && (lt[k].id < (level+1)<<12) ) {
      document_logtrace(lt[k]);
    }
  });
  console.log('</section>');
}

if (!process.argv[2]) {
  console.log('Please, specify the log level:');
  console.log(' ' + process.argv[1] + ' [1=NOTIFY | 2=ERROR | 3=CRITICAL]');
  return;
}
if (!isNaN(process.argv[2]))
  main(parseInt(process.argv[2]));
