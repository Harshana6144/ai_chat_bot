import 'package:ai_chat_bot/chat/presentation/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            //Top section : chat messages
            Expanded(
              child:Consumer<ChatProvider>(
              builder: (context,chatProvider,child){
                //empty
               if (chatProvider.message.isEmpty) {
                      return const Center(
                      child: Text("Start a conversation..."),
                    );
                 }
        
                 //chat messages
                 return ListView.builder(
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context,index){
                    //get each message
                    final message = chatProvider.messages[index];
        
                    //return message
                    return Text(message.content);
                  },
                 );
               },
              ),
            ),
              
        
            //user input boxes
            Row(
              children: [
                //LEFT -> Text box
                Expanded(child: TextField()),

                //RIGHT -> send button
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.send),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}