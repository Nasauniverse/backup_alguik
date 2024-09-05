// import 'package:alguik/view/dashboard.dart';
import 'package:alguik/controllers/encrypt.dart';
import 'package:alguik/controllers/fast_rsa.dart';
import 'package:alguik/view/camera.dart';
import 'package:alguik/view/dashboard.dart';
import 'package:alguik/view/halaman.dart';
import 'package:alguik/view/kadaluarsa.dart';
import 'package:alguik/view/splash_screen.dart';
// import 'package:alguik/view/splash_screen.dart';
import 'package:alguik/view/webview.dart';
import 'package:flutter/material.dart';

const String splashScreenRoute = '/';
const String initRoute = "/dashboard";
const String halamanRoute = "/halaman";
const String webviewRoute = '/webview';
const String cameraRoute = "/camera";
const String kadaluarsaRoute = "/kadaluarsa";

class Routes {
  static Route<dynamic> generateRoute(RouteSettings sett) {
    switch (sett.name) {
      case splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case halamanRoute:
        return MaterialPageRoute(builder: (_) => const HalamanPage());
      case initRoute:
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case kadaluarsaRoute:
        return MaterialPageRoute(builder: (_) => KadaluarsaPage());
      // case ujilagiRoute:
      //   return MaterialPageRoute(builder: (_) => MyWidget());
      case webviewRoute:
        return MaterialPageRoute(builder: (_) => const WebViewScreen());
      // case cameraRoute:
      //   return MaterialPageRoute(builder: (_) => const Camerapage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                '404 Not Found !! \n${sett.name}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
    }
  }
}
