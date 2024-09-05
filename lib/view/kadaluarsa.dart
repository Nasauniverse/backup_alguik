import 'package:flutter/material.dart';

import '../others/Colors.dart';

class KadaluarsaPage extends StatelessWidget {
  const KadaluarsaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(color: ColorTheme.blue,),
        iconTheme: IconThemeData(color: ColorTheme.white),
      ),
      body: Center(child: Container(
        child: Text("Halaman ujian sudah kadaluarsa! tolong perpangjang kembali", style: TextStyle(
          fontSize: MediaQuery.of(context).size.width /100*2, color: ColorTheme.blue
        ),),
      ),),
    );
  }
}