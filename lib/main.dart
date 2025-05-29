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
  List<List<String>> items = [
    ['Flutter','https://flutter.dev/' ],
    ['Google','https://www.google.co.jp/' ],
    ['Youtube','https://www.youtube.com/' ],
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ブックマーク'),
      ),
      body: ListView.builder (
        itemBuilder: (context, index) {
          final item = items[index];
          final title = item[0] ?? '';
          final url = item[1] ?? '';
          return ListTile(
            title: Text(title),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WebViewPage(title: title, url: url);
              }));
            },
          );
        },
          itemCount: items.length
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  State<WebViewPage> createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;
  
  @override
  void initState(){
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
      Uri.parse(widget.url),
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

