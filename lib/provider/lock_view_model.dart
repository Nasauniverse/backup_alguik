import 'dart:async';

import 'package:alguik/controllers/volumne_controller.dart';
import 'package:alguik/others/Colors.dart';
import 'package:alguik/provider/encrypt_view_model.dart';
import 'package:alguik/provider/volume_view_model.dart';
import 'package:alguik/routes/routes.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:developer' as dev;
import 'package:kiosk_mode/kiosk_mode.dart';

class LockViewModel extends ChangeNotifier with WidgetsBindingObserver {
  bool _isInKioskMode = false; // Variabel untuk melacak status Kiosk

  // Getter untuk mendapatkan status Kiosk
  bool get isInKioskMode => _isInKioskMode;
  //
  static const platform = MethodChannel('com.example.alguik/locktask');
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription =
      Stream<BluetoothAdapterState>.empty().listen((_) {});

  Future<void> kunciLayar() async {
    try {
      await startKioskMode();
      _isInKioskMode = true;
      notifyListeners();
      dev.log("berhasil mengunci layar");
    } catch (e) {
      print("Failed to start lock task: '${e.toString()}'.");
      dev.log("berhasil mengunci layar ");
    }
  }

  Future<void> bukaKunciLayar() async {
    try {
      await stopKioskMode();
      _isInKioskMode = false;
      notifyListeners();
      dev.log("berhasil membuka kunci layar");
    } catch (e) {
      dev.log("gagal membuka kunci layar");
    }
  }

  @override
  final AudioPlayer audioPlayer = AudioPlayer();
  final VolumeViewModel volumeViewModel = VolumeViewModel();
  void startsistem(context) {
    handleAjaib(context);
    // startLockTask();
    kunciLayar();
    WidgetsBinding.instance.addObserver(this);
    volumeViewModel.startMonitoring(); // kalau sundanamah meh rada soak
    print('memulai sistem.............'); // untuk melihar perubahan
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.dispose();
    volumeViewModel.stopMonitoring();
    bukaKunciLayar();
    print('WidgetsBindingObserver removed');
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print('AppLifecycleState changed: $state');
    if (state == AppLifecycleState.paused) {
      print('App minimized');
      await playSound('sound/sirine.mp3', Duration(seconds: 5));
      volumeViewModel
          .startMonitoring(); 
    } else if (state == AppLifecycleState.resumed) {
      dev.log('App resumed'); 
      await audioPlayer.stop();
      kunciLayar();
      await playSound('sound/sirine.mp3', Duration(seconds: 5));
      volumeViewModel
          .startMonitoring(); 
    }
  }

  Future<void> playSound(String path, Duration duration) async {
    try {
      print('Playing sound: $path');
      await audioPlayer.play(AssetSource(path));
      await Future.delayed(duration);
      await audioPlayer.stop();
      print('Sound stopped after ${duration.inSeconds} seconds');
    } catch (e) {
      print('Error playing sound: $e'); 
    }
  }

  Future<void> startLockTask() async {
    try {
      await platform.invokeMethod('startLockTask');
    } on PlatformException catch (e) {
      print("Failed to start lock task: '${e.message}'.");
    }
  }

  Future<void> stopLockTask() async {
    try {
      await platform.invokeMethod('stopLockTask');
    } on PlatformException catch (e) {
      print("Failed to stop lock task: '${e.message}'.");
    }
  }

  alertClose(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Pemberitahuan!",
            style: GoogleFonts.robotoCondensed(
                fontWeight: FontWeight.w800, color: ColorTheme.blueMuda),
          ),
          content: Text(
            "Apakah anda yakin akan keluar aplikasi?",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: ColorTheme.redAlert,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Tidak",
                          style: GoogleFonts.roboto(
                            color: ColorTheme.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Provider.of<EncryptViewModel>(context, listen: false)
                      //     .resetDataDekrip();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, halamanRoute);
                      // Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: ColorTheme.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Setuju",
                          style: GoogleFonts.roboto(color: ColorTheme.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  handleAjaib(context) {
    bool _isDialogShowing = false;

    _adapterStateStateSubscription?.cancel();

    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;

      if (state == BluetoothAdapterState.on) {
        _isDialogShowing = true;
        showDialog(
          context: context,
          barrierDismissible: false, // tidak dapat di-back
          builder: (context) {
            return PopScope(
              canPop: false,
              child: AlertDialog(
                title: Text(
                  "Pemberitahuan!",
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w800, color: ColorTheme.blueMuda),
                ),
                content: Text(
                  "Matikan Bluetotth agar dapat melanjutkan ujian",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
                ),
              ),
            );
          },
        );
        print("Bluetooth aktif");
      } else if (state == BluetoothAdapterState.off && _isDialogShowing) {
        Navigator.of(context, rootNavigator: true)
            .pop(); // otomatis navigator pop
        _isDialogShowing = false;
        print("Bluetooth mati");
      }
    });
  }

  drawer(context) {}
}
