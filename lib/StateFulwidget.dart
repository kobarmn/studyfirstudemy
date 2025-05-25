import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
      home: const NumberGuessGame(),
    );
  }
}


//NumberGuessGame
class NumberGuessGame extends StatefulWidget {
  const NumberGuessGame({super.key});

  @override
  State<NumberGuessGame> createState() => _NumberGuessGameState();
}

class _NumberGuessGameState extends State<NumberGuessGame> {

  //変数定義・初期化
  int _numberToGuess = Random().nextInt(100) +1;
  String _message = '私が思い浮かべている数字は何でしょうか。(1~100)';
  final TextEditingController _controller = TextEditingController();
  int _count = 0;

  //数字当て関数 値を受け取り、答えの表示を行う。
  void _guessNumber(){
    int? userGuess = int.tryParse(_controller.text);

    if (userGuess == null || userGuess < 1 || userGuess > 100) {
      //ユーザが数字でない文字列や、1~100 の範囲外の数字を入れた時の処理
      _message = '1から100の数値を入れてください。';
      return ;
    } else if (userGuess == _numberToGuess) {
      _count++;
      _message = 'おめでとうございます!「$userGuess」で正解です！\n「$_count」回目で当てました。\n新しい数字を思い浮かべます。';
      _numberToGuess = Random().nextInt(100) +1;
      _count = 0;
    } else if (userGuess <= _numberToGuess) {
      _count++;
      _message = '「$userGuess」は小さすぎます！\nもう一度違う値で試してみてください。';
    } else {
      _count++;
      _message = '「$userGuess」は大きすぎます！\nもう一度違う値で試してみてください。';
    }

    setState(() {
      _controller.clear();
    });

    print('$_message');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数字当てゲーム'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_message, style: TextStyle(fontSize: 22),),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'あなたの予想を入力してください'
              ),
            ),
            ElevatedButton(onPressed: _guessNumber, child: Text('予想を回答する。'))
          ],
        ),
      ),
    );
  }
}




//StopWatch App
class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {

  //変数定義・初期化
  Timer _timer = Timer(Duration.zero, () {});
  final Stopwatch _stopwatch = Stopwatch();
  String _time = '00:00:000';

  //StopWatch Start
  void _startTimer() {
    if(! _stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
        setState(() {
          final Duration elapsed = _stopwatch.elapsed;
          final String minute    = elapsed.inMinutes.toString().padLeft(2, '0');
          final String sec = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
          final String millisec= (elapsed.inMilliseconds % 60).toString().padLeft(2, '0');
          _time = '$minute:$sec:$millisec';
        });
      });
    }
  }

  //StopWatch Stop
  void _stopTimer(){
    if(_stopwatch.isRunning){
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  //StopWatch Reset
  void _resetTimer(){
    _stopwatch.reset();
    _time = '00:00:000';
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ストップウォッチ'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('経過時間'),
                Text(
                  '$_time',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: _startTimer, child: Text('開始')),
                      const SizedBox(width: 10),
                      ElevatedButton(onPressed: _stopTimer, child: Text('停止')),
                      const SizedBox(width: 10),
                      ElevatedButton(onPressed: _resetTimer, child: Text('クリア')),
                    ]
                )
              ]
          )
      ),
    );
  }
}



// SliderApp
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




//CheckBox App
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
