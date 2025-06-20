import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';
  String room = '';

  // エラー表示
  void showError(String message) {}

  //　入室処理
  void enter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('チャットシステム')),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              decoration: InputDecoration(hintText: 'あなたの名前'),
              onChanged: (value) {
                name = value;
              },
            ),
          ),
          ListTile(
            title: TextField(
              decoration: InputDecoration(hintText: '部屋名'),
              onChanged: (value) {
                room = value;
              },
            ),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                enter();
              },
              child: Text('入室する'),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({required this.name, required this.room, super.key});

  final String name;

  final String room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.room)));
  }
}
