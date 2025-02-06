import 'package:ai_chat_bot/chat/data/claude_api_service.dart';
import 'package:ai_chat_bot/chat/model/message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChatProvider with ChangeNotifier{
  //Claude api service
  final _apiService = ClaudeApiService(apiKey: "YOUR_API_KEY");

  //mesage & Loading..
  final List<Message> _message = [];
  bool _isLoading = false;

  //Getters
  List<Message> get message => _message;
  bool get isLoading => _isLoading;

  get messages => null;

  // Send message
  Future<void> sendMessage(String content) async{
    //prevent empty sends
    if(content.trim().isEmpty) return;

    //user message
    final userMessage = Message(
      content: content,
      isUser:true,
      timestamp:DateTime.now(),
      );

    //add user message to chat
    _message.add(userMessage);

    //update UI
    notifyListeners();

    //start loading..
    _isLoading = true;

    //update UI
    notifyListeners();
    
    //send message & receive response
    try{
      final response = await _apiService.sendMessage(content);

      //response message from AI
      final responseMessage =  Message(
        content: content,
        isUser: false,
        timestamp: DateTime.now(),
      );

      //add to chat
      _message.add(responseMessage);
    }

    //erroe
    catch (e) {
      //error message
      final errorMessage = Message(
        content: "Sorry,I encountered an issue.. $e",
        isUser: false,
        timestamp: DateTime.now(),
      );


      //add message to chat
      _message.add(errorMessage);

      //finished loading
      _isLoading = false;

      //updated UI
      notifyListeners();


    }

  }
}