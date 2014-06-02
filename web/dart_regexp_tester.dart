import 'dart:html';

TextAreaElement textarea = querySelector('#textarea');
DivElement divarea = querySelector('#divarea');
DivElement status = querySelector('#status');
InputElement input = querySelector('#input');

bool  selected = false;
String currentContent = '';

void main() {

 var button = querySelector('#button');
  button.onClick.listen((e) {
    checkText();
  });

  var clear = querySelector('#clear');
  clear.onClick.listen((e) {
    clearText();
  });

  var demo1 = querySelector('#demo1');
  demo1.onClick.listen((e) {
    clearText();
    input.value = "\\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}\\b";
    textarea.value = "Catch email addresses\nthis.should@not\nwww.domain.com\nbob@twnp.ks\nnice@try.buddy\nRoadhouse\nalmost@mail\n123456\ndale.cooper62@fbi.ks";
  });

  var demo2 = querySelector('#demo2');
  demo2.onClick.listen((e) {
    clearText();
    input.value = "\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b";
    textarea.value = "Valid IPs:\n11.255.008.2\nHi\n20.52.599.50\n127.0.0.1\n1.1.1.1\n255.OO5.50.9";
  });

  var demo3 = querySelector('#demo3');
  demo3.onClick.listen((e) {
    clearText();
    input.value = "A|D|E|I|M|O|R|S|T|W";
    textarea.value = "DART IS AWESOME";
  });

  divarea.onClick.listen((e) {
    selected = false;
    toggleViews();
    updateStatus(0,"Ready");
  });

  updateStatus(0,"Ready");

}

int checkText(){

  if (input.value!=''){


    if ( input.value.contains(new RegExp('[^.]\\*') )){
      updateStatus(2,"<b>Warning!</b><br/>"
                   "Your expression contains a pattern that is known to <b>freeze the browser</b> with Javascript compiled version.<br/>"
                   "Consider replacing \"*\" with \".*\" (dot and asterisk)<br/>"
                   "See <a href=\"http://github.com/claudiodangelis/dart_regular_expression_tester/issues/2\">Issue #2</a> on GitHub repository");
      return 1;
    }

    RegExp re = new RegExp(input.value);

    if( re.hasMatch(textarea.value) ) {

      List<List> matchesPositions = [];

      for (var match in re.allMatches(textarea.value)) {
        matchesPositions.add([match.start,match.end]);
      }

      doSelection(matchesPositions,textarea);
      colorize();
      toggleViews();
      updateStatus(1,"${matchesPositions.length} matches found.");

    } else {

      selected = false;
      toggleViews();
      updateStatus(2,"No matches found.");
    }
  }

  return 0;
}

void toggleViews() {

  if (selected){
    textarea.style.visibility='hidden';
    textarea.style.display = 'none';

    divarea.style.visibility='visible';
    divarea.style.display='inline-block';

  } else {

    textarea.style.visibility = 'visible';
    textarea.style.display = 'inline-block';

    divarea.style.visibility='hidden';
    divarea.style.display = 'none';

  }

}

void doSelection(List<List> matchesPositions, TextAreaElement textarea){

  selected = true;

  List<String> slices = [];
  int lastPos = 0;
  String plain = textarea.value;

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

  divarea.innerHtml = plain.replaceAll('\n', '<br/>');
  currentContent = plain;

}

void colorize(){

  // dart logo colors: [0,216,197] [0,150,210] [102,229,204] [0,152,223]
  List<String> leColors = ['#00D8C5','#0096D2','#66E5CC','#0098DF'];
  var allSelections = querySelectorAll('.selection');
  for( var i = 0; i<allSelections.length;i++){
    allSelections[i].style.backgroundColor=leColors[i%leColors.length];
    allSelections[i].style.color='#ffffff';
  }
}

deColorize(){
  if (selected){
    textarea.innerHtml=textarea.innerHtml.replaceAll(new RegExp('</?[span][^>]*>'),'');
    selected=false;
  }
}

clearText() {

  selected = false;
  toggleViews();
  textarea.value="";
  updateStatus(0,"Ready");
  input.value="";
  divarea.innerHtml="";

}

updateStatus(int value, String text){

  List<String> values = ['alert-info','alert-success','alert-error'];
  status
      ..innerHtml='<p>$text</p>'
      ..classes=['alert',values[value]];

}