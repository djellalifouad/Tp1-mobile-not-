import 'package:flutter/material.dart';
import 'package:tp4/tweetDetails.dart';

import 'models/tweet.model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController titleCOntroller = TextEditingController(text: "");
  List<Tweet> tweetList = [];
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Form(
                          key: _formKey,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text('Quoi du neuf '),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "vous devez remplir le titre";
                                }
                                return null;
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Titre',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "vous devez remplir la descpriotn";
                                }
                                return null;
                              },
                              controller: titleCOntroller,
                              decoration: InputDecoration(
                                hintText: 'Description',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  tweetList.add(Tweet(
                                      name: nameController.text,
                                      date: DateTime.now().toString(),
                                      title: titleCOntroller.text));
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  }
                                  _key.currentState!.insertItem(0,
                                      duration: const Duration(seconds: 1));

                                  nameController.text = "";
                                  titleCOntroller.text = "";
                                  setState(() {});
                                },
                                child: Text('Tweeter'))
                          ]),
                        ),
                      ));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/Twitter_Bird.png',
                height: 30,
                width: 30,
              ),
            ),
          )
        ],
      ),
      body: // This trailing comma makes auto-formatting nicer for build methods.
          AnimatedList(
        key: _key,
        initialItemCount: 0,
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index, animation) {
          return SizeTransition(
              key: UniqueKey(),
              sizeFactor: animation,
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TweetDetails(tweetList[index])));
                  },
                  onLongPress: () {
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          return AlertDialog(
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.auto_delete_rounded),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('Suppression'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Vouler vous vraiment supprimer le tweet ?'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            if (!Navigator.canPop(context)) {
                                              return;
                                            }
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Text('Non')),
                                      TextButton(
                                          onPressed: () {
                                            if (!Navigator.canPop(context)) {
                                              return;
                                            }
                                            _key.currentState!.removeItem(index,
                                                (_, animation) {
                                              return SizeTransition(
                                                sizeFactor: animation,
                                                child: const Card(
                                                  margin: EdgeInsets.all(10),
                                                  elevation: 10,
                                                  color: Colors.purple,
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.all(15),
                                                    title: Text("En supression",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24)),
                                                  ),
                                                ),
                                              );
                                              ;
                                            },
                                                duration:
                                                    const Duration(seconds: 1));
                                            tweetList.removeAt(index);
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: Text('Oui'))
                                    ],
                                  )
                                ]),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 400),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {
                          return Container();
                        });
                  },
                  leading: Image.asset(
                    'assets/Twitter_Bird.png',
                    height: 30,
                    width: 30,
                  ),
                  title: Text(tweetList[index].title),
                  subtitle: Text(tweetList[index].name),
                ),
              ));
        },
      ),
    );
  }
}
