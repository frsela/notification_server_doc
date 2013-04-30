
var lt = require("../src/common/logtraces.js").logtraces;

function document_logtrace(l) {
  console.log('    <section>');
  console.log('      <title> ID ' +
    l.id.toString(16) +
    ' - ' + l.m + '</title>');
  if (l.doc) {
    console.log('      <para>' +
      l.doc + '</para>');
  } else {
    console.log('      <para>' +
      'No detailed description yet</para>');
  }
  console.log('    </section>');
}

function main() {
  console.log('<?xml version="1.0" encoding="utf-8"?>');
  console.log('<chapter xml:id="logtraces"');
  console.log('      xmlns="http://docbook.org/ns/docbook"');
  console.log('      version="5.0" xml:lang="en">');
  console.log('  <!-- THIS IS A GENERATED DOCUMENT, DON\'T EDIT IT ! -->');
  console.log('  <title>Log traces</title>');
  console.log('  <para>This chapter describes each log message</para>');

  console.log('  <section>');
  console.log('    <title>NOTIFY level</title>');
  Object.keys(lt).forEach(function(k) {
    if ( (lt[k].id >= 0x1000) && (lt[k].id < 0x2000) ) {
      document_logtrace(lt[k]);
    }
  });
  console.log('  </section>');

  console.log('  <section>');
  console.log('    <title>ERROR level</title>');
  Object.keys(lt).forEach(function(k) {
    if ( (lt[k].id >= 0x2000) && (lt[k].id < 0x3000) ) {
      document_logtrace(lt[k]);
    }
  });
  console.log('  </section>');

  console.log('  <section>');
  console.log('    <title>CRITICAL level</title>');
  Object.keys(lt).forEach(function(k) {
    if ( (lt[k].id >= 0x3000) && (lt[k].id < 0x4000) ) {
      document_logtrace(lt[k]);
    }
  });
  console.log('  </section>');
  console.log('</chapter>');
}

main();
