import 'dart:async';

import 'package:alguik/provider/encrypt_view_model.dart';
import 'package:alguik/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

class SplashScreenViewModel extends ChangeNotifier {
  String route = "/dashboard";
  bool _isLoggedIn = false;

  SplashScreenViewModel() {
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    notifyListeners();
  }

  dynamicSplach(context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Timer(Duration(seconds: 2), () {
        _isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
        if (_isLoggedIn) {
          Provider.of<EncryptViewModel>(context, listen: false)
              .updateUi(context);
          Navigator.pushReplacementNamed(context, halamanRoute);
        } else {
          dev.log('data kosong');
          Navigator.pushReplacementNamed(context, initRoute);
        }
        notifyListeners();
      });
    } catch (e) {
      print('Error: $e'); // or handle the error in a more robust way
    }
  }
}
