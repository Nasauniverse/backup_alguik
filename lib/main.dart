// import 'dart:async';
import 'package:alguik/provider/camera_view_model.dart';
import 'package:alguik/provider/encrypt_view_model.dart';
import 'package:alguik/provider/lock_view_model.dart';
import 'package:alguik/provider/splash_screen_view_model.dart';
import 'package:alguik/provider/volume_view_model.dart';
import 'package:alguik/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VolumeViewModel>(
            create: (context) => VolumeViewModel()),
        // ChangeNotifierProvider<LockViewModel>(
        //     create: (context) => LockViewModel()),
        ChangeNotifierProvider<LockViewModel>(
            create: (context) => LockViewModel()),
        ChangeNotifierProvider<EncryptViewModel>(
            create: (context) => EncryptViewModel()),
        ChangeNotifierProvider<CameraViewModel>(
            create: (context) => CameraViewModel()),
        ChangeNotifierProvider<SplashScreenViewModel>(
            create: (context) => SplashScreenViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AlGuik',
        onGenerateRoute: Routes.generateRoute,
        initialRoute: splashScreenRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
