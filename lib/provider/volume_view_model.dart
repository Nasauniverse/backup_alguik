import 'dart:async';
import 'package:flutter/material.dart';
import 'package:volume_watcher/volume_watcher.dart';

class VolumeViewModel extends ChangeNotifier {
  Timer? _timer;
  final Duration _interval = Duration(seconds: 1); // Interval pengecekan

  void startMonitoring() {
    setMaxVolume(); // Pastikan volume maksimal diatur pada awal

    _timer = Timer.periodic(_interval, (timer) async {
      try {
        double currentVolumeInt = await VolumeWatcher
            .getCurrentVolume; 
        double currentVolume =
            currentVolumeInt / 100.0; 
        if (currentVolume < 1.0) {
          await setMaxVolume();
        }
      } catch (e) {
        print('Error getting volume: $e');
      }
    });
  }

  Future<void> setMaxVolume() async {
    try {
      await VolumeWatcher.setVolume(100.0); 
      print('Volume set to max');
    } catch (e) {
      print('Error setting volume: $e'); 
    }
  }

  void stopMonitoring() {
    _timer?.cancel(); 
  }
}
