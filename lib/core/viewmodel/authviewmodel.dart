import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sparrowconnected_homework/core/services/authservices.dart';
import 'package:sparrowconnected_homework/locator.dart';

// ignore: constant_identifier_names
enum ViewState { Idle, Busy }

class AuthViewModel extends ChangeNotifier{
  ViewState _state = ViewState.Idle;
  User? _user;
  final AuthServices _authServices = locator<AuthServices>();
  User? get user => _user;
  ViewState get state => _state;
  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }
  AuthViewModel() {
    currentUser();
  }
  Future<User?> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _authServices.currentUser();
      if (_user != null) {
        return _user!;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("AuthViewModel current user error:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _authServices.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("AuthViewModel current user error:" + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  Future<User?> singInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _authServices.singInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("AuthViewModel current user error:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }
}