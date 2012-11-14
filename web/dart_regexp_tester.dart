import 'dart:html';

DivElement textarea = query('#textarea');
DivElement status = query('#status');
InputElement input = query('#input');

bool  selected = false;

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
    input.value = "[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z0-9.-]*";
    textarea.innerHTML = "<div>Catch email addresses</div><div>this.should@not</div><div>www.domain.com</div><div></div><div>bob@twnp.ks</div><div></div><div>nice@try</div><div>Roadhouse</div><div>almost@mail</div><div></div><div>98789</div><div></div><div>dale.cooper62@fbi.ks</div>";
  });

  var demo2 = query('#demo2');
  demo2.on.click.add(function(Event event){
    input.value = "\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b";
    textarea.innerHTML = "Valid IPs:<br>11.255.008.2<br>Hi<br>20.52.599.50<br>127.0.0.1<br>1.1.1.1<br>255.OO5.50.9";
  });

  var demo3 = query('#demo3');
  demo3.on.click.add(function(Event event){
    input.value = "(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])";
    textarea.innerHTML = "Valid dates:<br>2012-13-11<br>1985-10-11<br>2008-08-06<br>1000-10-80";
  });

  textarea.on.click.add(function(Event event){
    deColorize();
  });

  status.text="Ready";
  status.classes=['alert','alert-info'];

}

clearText() {

  textarea.text="";
  input.value="";
  status.text="Ready";
  status.classes=['alert','alert-info'];

}

void checkText(){

  if (input.value!=''){
  RegExp re = new RegExp(input.value);

  textarea.innerHTML=textarea.innerHTML.replaceAll(new RegExp('</?[span][^>]*>'),'');

  if( re.hasMatch(textarea.innerHTML) ) {

    List<List> matchesPositions = [];

    for (var match in re.allMatches(textarea.innerHTML)) {
      matchesPositions.add([match.start,match.end]);
    }

    doSelection(matchesPositions,textarea);
    colorize();

    status.text = "${matchesPositions.length} matches found.";
    status.classes = ['alert','alert-success'];

  } else {

    status.text = "No matches found.";
    status.classes = ['alert','alert-error'];
  }
  }
}

void doSelection(List<List> matchesPositions, DivElement textarea){

  selected = true;

  List<String> slices = [];
  int lastPos = 0;
  String plain = textarea.innerHTML;

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

  textarea.innerHTML = plain;

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

deColorize(){
  if (selected){
    textarea.innerHTML=textarea.innerHTML.replaceAll(new RegExp('</?[span][^>]*>'),'');
    selected=false;
  }
}