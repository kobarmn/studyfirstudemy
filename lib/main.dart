import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


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
      home: const _BookMarkMainPage(),
    );
  }
}


class _BookMarkMainPage extends StatefulWidget {
  const _BookMarkMainPage({super.key});

  @override
  State<_BookMarkMainPage> createState() => _BookMarkMainPageState();
}

class _BookMarkMainPageState extends State<_BookMarkMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ブックマーク'),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text('Flutter'),
            ),
            ListTile(
              title: Text('Google'),
            ),
            ListTile(
              title: Text('Youtube'),
            )
          ],
        ),
      ),
    );
  }
}
