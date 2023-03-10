import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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
  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('permission granted!');
      var contacts = await ContactsService.getContacts();
      print(contacts);
      name = contacts;
      print(name[0].givenName);
      setState(() {
        total = contacts.length;
      });
    } else if (status.isDenied) {
      print('permission denied..');
      Permission.contacts.request();
      openAppSettings();
    }
  }

  int currentPageIndex = 0;

  var name = [];
  // var like = [0, 0, 0, 0];

  int total = 0;

  addOne() {
    setState(() {
      total++;
    });
  }

  addName(newContact) {
    setState(() {
      name.add(newContact);
      // like.add(0);
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
        title: Text('Total Friends : $total',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400)),
        actions: [
          IconButton(
              onPressed: () {
                getPermission();
              },
              icon: Icon(Icons.contacts))
        ],
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
                  title: Text(name[index].givenName ?? "????????????"),
                  trailing: ElevatedButton(
                    child: Text('?????????'),
                    onPressed: () {
                      setState(() {
                        // like[index]++;
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
              TextField(
                controller: inputData,
              ),
              TextButton(
                  child: Text('??????'),
                  onPressed: () {
                    var newContact = Contact();
                    newContact.givenName = inputData.text;
                    ContactsService.addContact(newContact);
                    addName(newContact);
                    addOne();
                    Navigator.pop(context);
                  }),
              TextButton(
                child: Text('??????'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ])));
  }
}
