import 'package:http/http.dart' as http;

Future<String> getRates() async{
  http.Response resonse = await http.get(Uri.parse('https://currency-converter-api.mrgaming717.repl.co'));
  if(resonse.statusCode==404){
    return 'nothing found';
  }
  print(resonse.statusCode);
  return resonse.body;
}