import 'package:alguik/provider/encrypt_view_model.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class CameraViewModel extends ChangeNotifier {
  Future<void> scanQR(context) async {
    String barcodeScanRes = "";
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#036A8D', 'Batal', true, ScanMode.QR);
      if (barcodeScanRes != '-1') {
        Provider.of<EncryptViewModel>(context, listen: false)
            .finaldecode(context, barcodeScanRes);
      } else {
        dev.log('gagal melakukan pengamnbilan data');
      }
      dev.log(barcodeScanRes);
    } catch (e) {
      dev.log("error $e");
    }
  }
}
