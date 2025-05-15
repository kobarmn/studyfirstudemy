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
        // useMaterial3: true, // Material 3 を使う場合は有効に
      ),
      home: const MyHomePage(title: '体調管理アプリ'),
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

  void _pushPage() {
    Navigator.push(
      context, // State オブジェクトの context プロパティを使用
      MaterialPageRoute(
        builder: (context) {
          return NextPage(id: 1, name: 'エニタイムフィットネス');
        },
      ),
    );
  }

  // _modalPage は定義されていますが使用されていません。必要なければ削除しても構いません。
  void _modalPage() {
    Navigator.push(
      context, // State オブジェクトの context プロパティを使用
      MaterialPageRoute(
        builder: (context) {
          return NextPage(id: 2, name: '腹筋ローラー');
        },
        fullscreenDialog: true,
      ),
    );
  }

  //変数定義
  double _height = 0.0;
  double _weight = 0.0;
  double _bmi = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('身長(cm)'), // const を追加
            TextField(
              keyboardType: TextInputType.number, // 数字キーボードを表示
              onChanged: (value) {
                // 入力が数字に変換できない場合は 0 とし、メートルに変換
                _height = (double.tryParse(value) ?? 0) / 100;
              },
            ),
            const SizedBox(height: 16), // const を追加
            const Text('体重(kg)'), // const を追加
            TextField(
              keyboardType: TextInputType.number, // 数字キーボードを表示
              onChanged: (value) {
                // 入力が数字に変換できない場合は 0 とし、そのまま kg
                _weight = (double.tryParse(value) ?? 0);
              },
            ),
            ElevatedButton(
              onPressed: () {
                // 身長または体重が 0 以下なら BMI を 0 にする
                if (_height <= 0 || _weight <= 0) { // 条件を少し整理
                  setState(() {
                    _bmi = 0;
                  });
                  // return; // BMI が 0 の場合も下のTextは更新されるため return は不要
                } else {
                  // 身長と体重が正の値なら BMI を計算
                  setState(() {
                    _bmi = _weight / (_height * _height);
                  });
                }
              },
              child: Text('計算する'),
            ),
            Text('あなたのBMIは ${_bmi.toStringAsFixed(2)} です'), // 小数点以下2桁で表示
            ElevatedButton(
                onPressed: () {
                  // NextPage へ遷移
                  _pushPage();
                },
                child: Text('おすすめのジムはこちら')
            ),
            ElevatedButton(onPressed: () {
              _modalPage();
            }, child: Text('おすすめのダイエットグッズはこちら'))
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  //コンストラクタで受け取る引数を追加
  NextPage({required this.id, required this.name});

  //受け取る引数の変数を定義
  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細情報'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '詳細ページです。id=[$id] name=[$name]',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            ElevatedButton(
                onPressed: () {
                  // 前のページに戻る処理
                  Navigator.pop(context);
                },
                child: Text(id == 1 ? '戻る' : '閉じる')
            ),
          ],
        ),
      ),
    );
  }
}