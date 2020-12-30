import 'package:flutter/material.dart';
import 'package:flutter_socket_io_chat_call/ChatModel.dart';
import 'package:flutter_socket_io_chat_call/ChatPage.dart';
import 'package:flutter_socket_io_chat_call/Models/User.dart';
import 'package:scoped_model/scoped_model.dart';

class AllChatsPage extends StatefulWidget {
  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
  @override
  void initState() {
    super.initState();
  }

  void friendClicked(User friend) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChatPage(friend);
        },
      ),
    );
  }

  Widget buildAllChatList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return ListView.builder(
          itemCount: model.friendList.length,
          itemBuilder: (BuildContext context, int index) {
            User friend = model.friendList[index];
            return ListTile(
              title: Text(friend.name),
              onTap: () => friendClicked(friend),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScopedModel.of<ChatModel>(context).init();
    return Scaffold(
      appBar: AppBar(
        title: Text('All Chats'),
      ),
      body: buildAllChatList(),
    );
  }
}
