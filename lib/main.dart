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
      home: const MySlider(),
    );
  }
}


class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _currentSliderValue = 20;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Slider Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100,
                divisions: 10, //0~100 を何段階で表すか。
                label: _currentSliderValue.round().toString(), //スライダーの値を表示する。
                onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;  
              });
              print('Value Selected : [$_currentSliderValue]');
            })
          ],
        ),
      ),
    );
  }
}





class MyCheckBox extends StatefulWidget {
  const MyCheckBox({Key? key}) : super(key: key); //コンストラクタ

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool isChecked = false;

  void _toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
      print('_toggleCheckBox isChecked=[$isChecked]');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyCheckBox Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('利用規約に同意する'),
                value: isChecked,
                onChanged: (value) {
                  _toggleCheckbox();
                },
              ),
            ),
            Text('isChecked = [$isChecked]'),
          ],
        ),
      ),
    );
  }
}
