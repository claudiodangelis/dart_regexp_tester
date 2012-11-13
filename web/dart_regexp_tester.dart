import 'dart:html';

void checkText(){
  InputElement input = query("#input");

  if (input.value!=''){
  DivElement txt = query("#textarea");
  RegExp re = new RegExp(input.value);


  if( re.hasMatch(txt.innerHTML) ) {

    List<List> matchesPositions = [];

    for (var match in re.allMatches(txt.innerHTML)) {
      matchesPositions.add([match.start,match.end]);
    }

    doSelection(matchesPositions,txt);

    query('#status').classes = ['alert','alert-success'];
    query('#status').text = 'Success';

    //query('#textarea').innerHTML = selectedText;


  } else {

    query('#status').classes = ['alert','alert-error'];
    query('#status').text = 'No success';

  }
  }
}

void doSelection(List<List> matchesPositions, DivElement txt){
  String selectedText ='';
  int lastIndex = 0;
  for ( var match in matchesPositions){
    selectedText = '${selectedText}${txt.innerHTML.substring(lastIndex, match[0])}<span class=\"selection\">${txt.innerHTML.substring(match[0], match[1])}</span>';
    lastIndex=match[1];
  }
  selectedText='${selectedText}${txt.innerHTML.substring(lastIndex,txt.innerHTML.length)}';

  txt.innerHTML=selectedText;
}

void colorize(){

}

void main() {


  var button = query('#button');
  button.on.click.add(function(Event event){
    checkText();
  });


  var demo1 = query('#demo1');
  demo1.on.click.add(function(Event event){
    InputElement input = query('#input');
    input.value = "[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]";

    DivElement textarea = query('#textarea');
    textarea.innerHTML = "<p>// Grep email addresses</p><p></p><p>www.domain.com</p><p></p><p>bob@twnp.ks</p><p></p><p>aoisdj</p><p>oaijsd</p><p>ioajsdi</p><p></p><p>98789</p><p></p><p>dale.cooper62@fbi.ks</p><p></p><p>III00099I ";

  });

  var demo2 = query('#demo2');
  demo2.on.click.add(function(Event event){
    InputElement input = query('#input');
    input.value = "\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b";

    DivElement textarea = query('#textarea');
    textarea.innerHTML = "11.255.008.2<br>Hi<br>20.52.599.50<br>127.0.0.1<br>1.1.1.1<br>255.OO5.50.9";

  });


  var demo3 = query('#demo3');
  demo3.on.click.add(function(Event event){
    InputElement input = query('#input');
    input.value = "(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])";

    DivElement textarea = query('#textarea');
    textarea.innerHTML = "2012-13-11<br>1985-10-11<br>2008-08-06<br>1000-10-80";

  });


  query('#loading').style.visibility = 'hidden';
  query('#loading').style.display = 'none';
  query('#status').style.visibility='visible';
  query('#status').style.display='inline';
  query('#status').classes=['alert','alert-info'];
  query('#status').text="";
}

