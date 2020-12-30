import 'package:flutter/material.dart';
import 'package:flutter_socket_io_chat_call/ChatModel.dart';
import 'package:flutter_socket_io_chat_call/HomeScreen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChatModel>(
      model: ChatModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Socket IO chat call',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
