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
  List<String> itemsKana = [];
  String errorMessage = '';


  //非同期関数
  Future<void> loadZipCode(String zipCode) async {

    setState(() {
      errorMessage = 'APIレスポンス待ち'; //待機メッセージをセット
    });

    //レスポンスが来るまで待機
    final response = await http.get(
      Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode'));

    if(response.statusCode !=200){
      //失敗
      setState(() {
        errorMessage = '通信エラーが発生しました';
        items = [];
        itemsKana = [];
      });
      return;
    }
    //成功
    final body = json.decode(response.body) as Map<String, dynamic>;  //httpリクエストから返却された全体の値
    final results = (body['results'] ?? []) as List<dynamic>;         //bodyの内、resultを取得する

    if(results.isEmpty) {
      setState(() {
        errorMessage = '郵便番号を入力してください。';
      });
    } else
       setState(() {
         errorMessage = '';
         items     = results.map((result) => "${result['address1']}${result['address2']}${result['address3']}").toList(growable: false);
         itemsKana = results.map((result) => "${result['kana1']}${result['kana2']}${result['kana3']}").toList(growable: false);
       });
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
      appBar: AppBar(
        title: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.isNotEmpty) {
              loadZipCode(value);
            }
          },
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            if (errorMessage.isNotEmpty) {
              return ListTile(title: Text(errorMessage));
            } else {
              return ListTile(title: Text(items[index]), leading: Icon(Icons.home), subtitle: Text(itemsKana[index]));
            }
          },
        itemCount: items.length,
      )
    );
  }
}