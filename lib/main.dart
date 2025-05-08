import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  //変数定義
  double _height = 0.0;
  double _weight = 0.0;
  double _bmi = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('身長(cm)'),
            TextField(
              onChanged: (value) {
                _height = (double.tryParse(value) ?? 0) / 100;
              },
            ),
            SizedBox(height: 16),
            Text('体重(kg)'),
            TextField(
              onChanged: (value) {
                _weight = (double.tryParse(value) ?? 0);
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_height <= 0) {
                  setState(() {
                    _bmi = 0;
                  });
                  return;
                }

                if (_weight <= 0) {
                  setState(() {
                    _bmi = 0;
                  });
                  return;
                }

                setState(() {
                  _bmi = _weight / (_height * _height);
                });
              },
              child: Text('計算する'),
            ),
            Text('あなたのBMIは$_bmiです'),
          ],
        ),
      ),
    );
  }
}
