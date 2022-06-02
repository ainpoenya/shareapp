import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ShareAppFirebaseUser {
  ShareAppFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ShareAppFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ShareAppFirebaseUser> shareAppFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ShareAppFirebaseUser>(
            (user) => currentUser = ShareAppFirebaseUser(user));
