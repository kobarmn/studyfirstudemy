import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

//ユーザごとにcollectionKeyを配布し、各ユーザIDが主キーとなってデータが格納されている。
const collectionKey = 'UverWorld';

class _MyHomePageState extends State<MyHomePage> {

  List<Item> items =[];
  final TextEditingController textEditingController = TextEditingController();
  late FirebaseFirestore firestore;

  @override
  void initState(){
    super.initState();
    firestore = FirebaseFirestore.instance;
    watch();
  }

  //データ更新監視
  //データが変更されると、その新しいデータをitemsリストに格納し、setStateメソッドで状態更新を実施する。
  Future<void> watch() async {
    firestore.collection(collectionKey).snapshots().listen((event) {
      setState(() {
        items = event.docs.reversed
            .map(
              (document) =>
              Item.fromSnapshot(
                document.id,
                document.data(),
              ),
        )
            .toList(growable: false);
      });
    });
  }

  //保存する
  Future<void> save() async {
    final collection = firestore.collection(collectionKey);
    final now = DateTime.now(); //時間を発行する。

    //発行した時間をmsで表したモノをユニークキーとして、時間と入力項目を保存する。
    await collection.doc(now.millisecondsSinceEpoch.toString()).set({
      "data": now,
      "text": textEditingController.text,
    });
    //保存された後、入力項目欄をクリアする。
    textEditingController.text = "";
  }

  //完了・未完了に変更する
  Future<void> complete(Item item) async {
    final collection = firestore.collection(collectionKey);
    await collection.doc(item.id). set ({
      'completed': !item.completed, //itemのcompetedがtrue→false, false → true
    }, SetOptions(merge: true)); //completed以外のフィールドは変更しない。
  }

  //削除する
  Future<void> delete(String id) async {
    final collection = firestore.collection(collectionKey);
    await collection.doc(id).delete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODOアプリ')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          //一行目は入力欄
          if (index == 0) {
            return ListTile(
              title: TextField(
                controller: textEditingController,
              ),
              trailing: ElevatedButton(
                onPressed: (){
                  save();
                },
                child: Text('保存'),
              ),
            );
          }
          final item = items[index - 1];
          return Dismissible(
            key: Key(item.id),
            //対象をスワイプした時、削除する。
            onDismissed: (direction) {
              delete(item.id);
            },
            child: ListTile(
              leading: Icon(
                item.completed ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              onTap: (){
                complete(item);
              },
              title: Text(item.text),
              subtitle: Text(item.date.toString().replaceAll('-', '/').substring(0, 19)),
            ),
          );
        },
        itemCount: items.length + 1,
      ),
    );
  }
}

class Item {
  const Item({
    required this.id,
    required this.text,
    required this.completed,
    required this.date,
  });

  final String id;
  final String text;
  final bool completed;
  final DateTime date;

  factory Item.fromSnapshot(String id,
      Map<String, dynamic> document) {
    return Item(
        id: id,
        text: document['text'].toString() ?? '',
        completed: document['completed'] ?? false,
        date: (document['date'] as Timestamp?)?.toDate() ?? DateTime.now()
    );
  }

}