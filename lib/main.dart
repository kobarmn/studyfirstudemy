import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

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
        useMaterial3: true,
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
  TextEditingController controller = TextEditingController();
  List<String> items = [];
  String errorMessage = '';


  //非同期関数
  Future<void> loadZipCode(String zipCode) async {

    setState(() {
      errorMessage = 'APIレスポンス待ち' //待機メッセージをセット
    });

    //レスポンスが来るまで待機
    final response = await http.get(
      Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode')
    );

    if(response.statusCode !=200){
      //失敗
      return;
    }
    //成功
    final body = json.decode(response.body) as Map<String, dynamic>;
    final results = (body['results'] ?? []) as List<dynamic>;

    if(results.isEmpty) {
      setState(() {
        errorMessage = 'そのような郵便番号の住所はありません。';
      });
    }
     else {
       errorMessage = '';
       items = result.map((result => '$result['address1']'))
    }

  }


  //初期処理
  // @override
  // void initState() {
  //   super.initState();
  //   controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..loadRequest(Uri.parse('https://www.youtube.com/watch?v=RA-vLF_vnng'));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}