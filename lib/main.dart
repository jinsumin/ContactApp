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
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {},
      ),
      appBar: AppBar(
        leading: Image.asset('assets/sangsangin_logo.png'),
        backgroundColor: Color.fromRGBO(0, 167, 167, 1),
        title: Text('Demo Contact App',
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
            color: Colors.blue,
            alignment: Alignment.center,
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset('assets/sangsangin_logo.png'),
                  ),
                  title: Text('홍길동 $index'),
                );
              },
            )),
      ][currentPageIndex],
    );
  }
}
