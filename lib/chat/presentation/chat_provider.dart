import 'package:ai_chat_bot/chat/data/claude_api_service.dart';
import 'package:ai_chat_bot/chat/model/message.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  //Claude api service
  final _apiService = ClaudeApiService(
      apiKey:
          "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");

  //mesage & Loading..
  final List<Message> _messages = [];
  bool _isLoading = false;

  //Getters
  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  // Send message
  Future<void> sendMessage(String content) async {
    //prevent empty sends
    if (content.trim().isEmpty) return;

    //user message
    final userMessage = Message(
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    //add user message to chat
    _messages.add(userMessage);

    //update UI
    notifyListeners();

    //start loading..
    _isLoading = true;

    //update UI
    notifyListeners();

    //send message & receive response
    try {
      final response = await _apiService.sendMessage(content);

      //response message from AI
      final responseMessage = Message(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      //add to chat
      _messages.add(responseMessage);
    }

    //error
    catch (e) {
      //error message
      final errorMessage = Message(
        content: "Sorry,I encountered an issue.. $e",
        isUser: false,
        timestamp: DateTime.now(),
      );

      //add message to chat
      _messages.add(errorMessage);

      //finished loading
      _isLoading = false;

      //updated UI
      notifyListeners();
    }
  }
}
