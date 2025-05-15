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
      home: const MyHomePage(title: '電話帳アプリ'),
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

  List<Map<String, String>> contacts = [
    {'name': '山田 太郎', 'number': '070-1234-5678', 'address' : '東京都'},
    {'name': '鈴木 一郎', 'number': '080-1234-5678', 'address' : '神奈川県'},
    {'name': '佐藤 花子', 'number': '090-1234-5678', 'address' : '大阪府'},
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              leading:  Icon(Icons.telegram),
              title:    Text(contacts[0]['name'] ?? '名前が未登録です。'),
              subtitle: Text(contacts[0]['number'] ?? '電話番号が未登録です。'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading:  Icon(Icons.telegram),
              title:    Text(contacts[1]['name'] ?? '名前がありません。'),
              subtitle: Text(contacts[1]['number'] ?? '電話番号が未登録です。'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading:  Icon(Icons.telegram),
              title:    Text(contacts[2]['name'] ?? '名前がありません。'),
              subtitle: Text(contacts[2]['number'] ?? '電話番号が未登録です。'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
