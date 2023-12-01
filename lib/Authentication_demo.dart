import 'package:firebase_auth/firebase_auth.dart';

class auth {
  Sign_in() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'doaammimh1996@icloud.com',
        password: '1234qwer&',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Sign_up() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'doaammimh1996@icloud.com',
        password: '1234qwer&',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Sign_out() async {
    await FirebaseAuth.instance.signOut();
  }
}
