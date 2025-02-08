import 'dart:convert';
import 'package:http/http.dart' as http;

/*

Service class to handle all Clude API stuff

*/

class ClaudeApiService{
  //API Constants
  static const String _baseUrl = 'https://api.anthropic.com/v1/messages';
  static const String _apiVersion = '2023-06-01';
  static const String _model = 'claude-3-opus-20240229';
  static const int _maxTokens = 1024;

  //Strore the API key security
  final String _apiKey;

  //Require API KEY
  ClaudeApiService({required String apiKey}) : _apiKey = apiKey;

  /*
  Send a message to Claude API & return the response

  */
Future<String> sendMessage(String content) async {
  try{
    //Make POST request to Claude API
    final response = await http.post(
    Uri.parse(_baseUrl),
    headers:_getHeaders(),
    body: _getRequestBody(content),
    );


  //check request was succsffful
  if(response.statusCode ==200){
    final data = jsonDecode(response.body); // parse json respons
    return data['content'][0]['text']; // extract claude's response text
  }

  //Handle unsuccessful response
  else{
    throw Exception('Faild to get response from : ${response.statusCode}');
  }
    }catch (e) {
      //handel any errors during
      throw Exception('API Error $e');
    }
  }

//create required headers for claude API
    Map<String,String>_getHeaders () =>{
      'Content-Type':'application/json',
      'x-api-key': _apiKey,
      'anthropic-version': _apiVersion,
    };

  //format request body according to Claude API specs
  String _getRequestBody(String content) => jsonEncode({
    'model' : _model,
    'messages': [
      //format message in Claude's required structure
      {'role':'user','content': content}
    ],
    'max_tokens' : _maxTokens,
  });

}