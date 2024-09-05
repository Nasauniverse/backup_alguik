// import 'dart:async';
import 'dart:io';

import 'package:alguik/others/Colors.dart';
import 'package:alguik/provider/encrypt_view_model.dart';
import 'package:alguik/provider/lock_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:developer' as dev;

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LockViewModel>(
      create: (context) => LockViewModel()..startsistem(context),
      // dispose: (context, modelLock) => modelLock.dispose(),
      child: Consumer2<LockViewModel, EncryptViewModel>(
          builder: (context, modelLock, modelEncrypt, _) {
        // Debug: Print nilai dari modelEncrypt
        dev.log('namaSekolah dari modelEncrypt: ${modelEncrypt.namaSekolah}');
        dev.log('poto dari modelEncrypt: ${modelEncrypt.poto}');
        dev.log('versi dari modelEncrypt: ${modelEncrypt.versi}');

        return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (await modelEncrypt.controller!.canGoBack()) {
                await modelEncrypt.controller!.goBack();
              }
            },
            child: Scaffold(
                appBar: AppBar(
                  actions: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        right: 15,
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: modelEncrypt.poto == null
                            ? null
                            : CachedNetworkImage(
                                imageUrl: modelEncrypt.poto!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                      ),
                    )
                  ],
                  iconTheme: IconThemeData(color: ColorTheme.blueMuda),
                  title: Center(
                    child: Text(
                      modelEncrypt.namaSekolah ?? " ",
                      style: GoogleFonts.robotoCondensed(
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.blueMuda),
                    ),
                  ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(color: ColorTheme.white),
                  ),
                ),
                drawer: Container(
                  // width: MediaQuery.of(context).size.width / 2,
                  child: Drawer(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 7,
                              // width: MediaQuery.of(context).size.width / 2,
                              child: modelEncrypt.poto == null
                                  ? null
                                  : CachedNetworkImage(
                                      imageUrl: modelEncrypt.poto!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                            ),
                            Text(
                              modelEncrypt.namaSekolah ?? "Nama Sekolah",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                  color: ColorTheme.blue),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.notifications_active_outlined,
                                        color: ColorTheme.blue,
                                        size: 25,
                                      ),
                                      Text("L'",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: ColorTheme.blue,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Text("GUIK",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: ColorTheme.blueSuperMuda,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child:
                                  Image.asset("assets/images/sekolahan_id.png"),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  modelEncrypt.versi ?? "",
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          modelLock.alertClose(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorTheme.blue,
                              borderRadius: BorderRadius.circular(20)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          height: MediaQuery.of(context).size.height / 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                size: 25,
                                color: ColorTheme.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Klik dan keluar dari halaman",
                                style: GoogleFonts.roboto(
                                    color: ColorTheme.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          modelEncrypt.alertLogout(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorTheme.blue,
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: MediaQuery.of(context).size.height / 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                size: 25,
                                color: ColorTheme.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Log Out",
                                style: GoogleFonts.roboto(
                                    color: ColorTheme.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                body: modelEncrypt.controller == null
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Qr Code ini sudah kadaluarsa!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height /
                                    100 *
                                    2,
                                color: ColorTheme.blue),
                          ),
                        ),
                      )
                    : WebViewWidget(
                        controller: modelEncrypt.controller!,
                      )));
      }),
    );
  }
}
//  WebViewWidget(
//                 controller: modelEncrypt.controller!,