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
    colorize();

    query('#status').text = "${matchesPositions.length} matches found.";
    query('#status').classes = ['alert','alert-success'];

    //query('#textarea').innerHTML = selectedText;


  } else {

    query('#status').text = "No matches found.";
    query('#status').classes = ['alert','alert-error'];
  }
  }
}

void doSelection(List<List> matchesPositions, DivElement txt){

  List<String> slices = [];
  int lastPos = 0;
  String plain = txt.innerHTML;


  if ( matchesPositions[0][0] == 0){
    slices.add(plain.substring(0,matchesPositions[0][0]));
    lastPos = matchesPositions[0][1];
  }

  for ( var match in matchesPositions) {
    slices.add(plain.substring(lastPos, match[0]));
    slices.add("<span class='selection'>");
    slices.add(plain.substring(match[0], match[1]));
    slices.add('</span>');
    lastPos = match[1];
  }

  if (matchesPositions[matchesPositions.length-1][1] != plain.length){
    slices.add(plain.substring(lastPos,plain.length));
  }

  plain='';

  for ( var slice in slices) {
    plain="${plain}${slice}";
  }

  txt.innerHTML = plain;

}

void colorize(){

  // dart logo colors: [0,216,197] [0,150,210] [102,229,204] [0,152,223]
List<String> leColors = ['#00D8C5','#0096D2','#66E5CC','#0098DF'];
var allSelections = queryAll('.selection');
for( var i = 0; i<allSelections.length;i++){
  allSelections[i].style.backgroundColor=leColors[i%leColors.length];
  allSelections[i].style.color='#ffffff';
}

}

void main() {


  var button = query('#button');
  button.on.click.add(function(Event event){
    checkText();
  });

  var clear = query('#clear');
  clear.on.click.add(function(Event event){
    clearText();
  });


  var demo1 = query('#demo1');
  demo1.on.click.add(function(Event event){
    InputElement input = query('#input');
    input.value = "[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z0-9.-]*";

    DivElement textarea = query('#textarea');
    textarea.innerHTML = "<div>// Grep email addresses [still buggy]</div><div>this.should@not</div><div>www.domain.com</div><div></div><div>bob@twnp.ks</div><div></div><div>nice@try</div><div>Roadhouse</div><div>almost@mail</div><div></div><div>98789</div><div></div><div>dale.cooper62@fbi.ks</div>";

  });

  var demo2 = query('#demo2');
  demo2.on.click.add(function(Event event){
    InputElement input = query('#input');
    input.value = "\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b";

    DivElement textarea = query('#textarea');
    textarea.innerHTML = "Valid IPs:<br>11.255.008.2<br>Hi<br>20.52.599.50<br>127.0.0.1<br>1.1.1.1<br>255.OO5.50.9";

  });


  var demo3 = query('#demo3');
  demo3.on.click.add(function(Event event){
    InputElement input = query('#input');
    input.value = "(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])";

    DivElement textarea = query('#textarea');
    textarea.innerHTML = "Valid dates:<br>2012-13-11<br>1985-10-11<br>2008-08-06<br>1000-10-80";

  });


  query('#status').text="Ready";
  query('#status').classes=['alert','alert-info'];

}

clearText() {
  query('#textarea').text="";
  query('#input').value="";
  query('#status').text="Ready";
  query('#status').classes=['alert','alert-info'];
}

