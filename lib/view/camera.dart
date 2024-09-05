// import 'package:alguik/others/Colors.dart';
// import 'package:alguik/routes/routes.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class Camerapage extends StatefulWidget {
//   const Camerapage({super.key});

//   @override
//   State<Camerapage> createState() => _CamerapageState();
// }

// class _CamerapageState extends State<Camerapage> {
//     final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: ColorTheme.white),
//         title: Text(
//           "Scan QR",
//           style: GoogleFonts.roboto(
//               color: ColorTheme.white, fontWeight: FontWeight.bold),
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//               color: ColorTheme.blue, borderRadius: BorderRadius.circular(20)),
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (result != null)
//                   ? Text(
//                       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//                   : Text('Scan a code'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }