import 'package:firestore_demo/Authentication_demo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firestore_demo/Firestore_Data.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  List listofdata = [];
  myfirestoredata mydata = myfirestoredata();
  auth myauth = auth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Firestore Demo"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await myauth.Sign_up();
                      },
                      child: Text("Sign up")),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await myauth.Sign_in();
                      },
                      child: Text("Sign in")),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await myauth.Sign_out();
                      },
                      child: Text("Sign out")),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: mydata.fetchdata(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      listofdata = snapshot.data!;
                      return ListView.builder(
                          itemCount: listofdata.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: IconButton(
                                    onPressed: () {
                                      myfirestoredata mydata =
                                          myfirestoredata();
                                      mydata.Deletedata(listofdata[index].id);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete)),
                                title:
                                    Text(listofdata[index].data()['UserName']),
                                subtitle:
                                    Text(listofdata[index].data()['Email']),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("Hard Luck");
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
