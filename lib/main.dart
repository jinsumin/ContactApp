import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainNavigation());
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentPageIndex = 0;

  var name = [
    '김길동',
    '이길동',
    '박길동',
    '홍길동',
  ];
  var like = [0, 0, 0, 0];

  int total = 4;

  addOne() {
    setState(() {
      total++;
    });
  }

  addName(text) {
    setState(() {
      name.add(text);
      like.add(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return DialogUI(addOne: addOne, addName: addName);
              });
        },
      ),
      appBar: AppBar(
        leading: Image.asset('assets/sangsangin_logo.png'),
        backgroundColor: Color.fromRGBO(0, 167, 167, 1),
        title: Text('Demo Contact App $total',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400)),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.phone),
            label: 'Phone',
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.cyan,
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
            color: Colors.white38,
            alignment: Alignment.center,
            child: ListView.builder(
              itemCount: name.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child:
                        Image.asset('assets/sangsangin_logo.png', height: 50),
                  ),
                  title: Text("${name[index]} ${like[index]}"),
                  trailing: ElevatedButton(
                    child: Text('좋아요'),
                    onPressed: () {
                      setState(() {
                        like[index]++;
                      });
                    },
                  ),
                );
              },
            )),
      ][currentPageIndex],
    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne, this.addName}) : super(key: key);
  final addOne;
  final addName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
            width: 300,
            height: 250,
            child: Column(children: [
              TextField(controller: inputData,),
              TextButton(
                  child: Text('등록'),
                  onPressed: () {
                    addOne();
                    addName(inputData.text);
                    Navigator.pop(context);
                  }),
              TextButton(
                child: Text('취소'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ])));
  }
}
