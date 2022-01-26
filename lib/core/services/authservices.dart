import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<User?> currentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return user;
    } catch (e) {
      return null;
    }
  }
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<User?> singInAnonymously() async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInAnonymously();
      return sonuc.user;
    } catch (e) {
      return null;
    }
  }
}