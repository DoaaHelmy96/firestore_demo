import 'package:cloud_firestore/cloud_firestore.dart';

class myfirestoredata {
  var users = FirebaseFirestore.instance.collection('Users');

  Future<List> fetchdata() async {
    var usersref = FirebaseFirestore.instance.collection('Users');
    var query = await usersref.get();
    List mydocs = query.docs;
    return mydocs;
  }

  AddData() async {
    users.add({'Name': 'Doaa', 'Age': '26'});
  }

  ReplaceData() async {
    // will remove all the data and replace it with
    users.doc('123456789').set({'Name': 'Marwa', 'Age': '30'});
  }

  UpdateData() async {
    // will just update this data and keep everything else unchanged
    users.doc('123456789').update({'Name': 'Hala'});
  }

  Deletedata(String docid) async {
    // will just update this data and keep everything else unchanged
    users.doc(docid).delete();
  }
}
