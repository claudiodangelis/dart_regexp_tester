import 'dart:html';

void checkText(){
  InputElement input = query("#input");
  DivElement textarea = query("#textarea");




  RegExp re = new RegExp(input.value);


  if( re.hasMatch(textarea.text) ) {

    print(textarea.text);
    print(textarea.innerHTML);

    String selectedText = '';

    for (var match in re.allMatches(textarea.text)) {

      String finalText = '';
      if (selectedText==''){
        finalText=selectedText;
      }


      print(match.group(0));
      print(match.start);
      print(match.end);

      String intermedio;

      int position = 0;
      int actual = 0;
      int looking = match.start;
      bool count = true;


      for (var character in textarea.innerHTML.splitChars() ){

        if(character=="<"){count = false;}
        if(character==">"){count = true;}
        if(count==true && character!=">"){
          print(character);
          actual++;
        }

        if(actual==looking){break;}
        position++;
      }
      print(actual);
      print(position);



      for( var x = 0; x < position; x++){
        finalText='$finalText${textarea.innerHTML[x]}';
      }
      finalText='$finalText<span class=\"selection\">';


          for (var x = 0;x<(match.end - match.start);x++)
          {
            finalText='$finalText${textarea.innerHTML[position+x]}';
          }

          finalText='$finalText</span>';

      for ( var x = position + (match.end-match.start); x<textarea.innerHTML.length; x++){
        finalText='$finalText${textarea.innerHTML[x]}';
      }


      textarea.innerHTML=finalText;
      selectedText = finalText;

    }


    query('#status').classes = ['alert','alert-success'];
    query('#status').text = 'Success';

    query('#textarea').innerHTML = selectedText;


  } else {

    query('#status').classes = ['alert','alert-error'];
    query('#status').text = 'No success';

  }

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
    textarea.innerHTML = "// Grep email addresses  www.domain.com  bob@twnp.ks  aoisdj oaijsd ioajsdi  98789  dale.cooper62@fbi.ks  III00099II  ";

  });

  query('#loading').style.visibility = 'hidden';
  query('#loading').style.display = 'none';
  query('#status').classes=['alert','alert-info'];
  query('#status').text="Insert a RegExp and a text, and try it out.";
}

