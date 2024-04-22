import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:obj_demo/boxStore_demo.dart';
import 'package:obj_demo/generated/objectbox.g.dart';
import 'package:obj_demo/model.dart';
import 'package:obj_demo/myJson.dart';
import 'package:objectbox/objectbox.dart';

late ObjectBox objectbox;
List<User> users = [];
List<Orders> myOrders = [];
void main() async {
  // This is required so ObjectBox can get the application directory
  // to store the database in.
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  // items.forEach((k) {
  //   users.add(User.fromJson(k));
  //   print('${k["name"]} added to list');
  // });
  // var userBox = objectbox.store.box<User>();
  // users.forEach((e) {
  //   userBox.put(e);
  // });
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
  var controller = TextEditingController();
  var userBox = objectbox.store.box<User>();
  var orderBox = objectbox.store.box<Orders>();
  List<User> searchRes = [];

  search(String string) async {
    setState(() {
      final query = (userBox
          .query(User_.name.contains(string, caseSensitive: false))
          .build());
      final result = query.find();
      // searchRes = userBox.getAll();

      searchRes = [...result];
      query.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              for (var e in users) {
                userBox.put(e, mode: PutMode.insert);
                print("${e.name} Saved!!");
              }
            },
            child: const Icon(Icons.safety_check),
          ),
          FloatingActionButton(
            onPressed: () {
              for (var k in items) {
                users.add(User.fromJson(k));
                print('${k["name"]} added to list');
              }
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              for (var e in orders) {
                var n = Orders.fromJson(e);
                myOrders.add(n);
                orderBox.put(n);
                print("${n.description} Saved!!");
              }
            },
            child: const Icon(Icons.online_prediction_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "search for user"),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                search(controller.text);
              },
              child: const Text("Search")),
          const Text("Results"),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(18.0),
                itemCount: searchRes.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[200],
                    child: ListTile(
                      title: Text("${searchRes[index].name}"),
                      subtitle: Text('age: ${searchRes[index].age}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            userBox.remove(searchRes[index].id!);
                            searchRes.remove(searchRes[index]);
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          searchRes[index].age = 99;
                        });
                        userBox.put(searchRes[index]);
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
