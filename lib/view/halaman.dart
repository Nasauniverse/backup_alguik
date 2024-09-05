import 'package:alguik/others/Colors.dart';
import 'package:alguik/provider/encrypt_view_model.dart';
import 'package:alguik/provider/lock_view_model.dart';
import 'package:alguik/routes/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HalamanPage extends StatelessWidget {
  const HalamanPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<LockViewModel>(context, listen: false).handleAjaib(context);
    return Consumer<EncryptViewModel>(
      builder: (context, modelEncrypt, _) => Scaffold(
        body: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3),
                  child: Column(
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
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
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
                          Row(
                            children: [
                              Icon(
                                Icons.notifications_active_outlined,
                                color: ColorTheme.blue,
                                size: 45,
                              ),
                              Text("L'",
                                  style: TextStyle(
                                      fontSize: 45,
                                      color: ColorTheme.blue,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text("GUIK",
                              style: TextStyle(
                                fontSize: 40,
                                color: ColorTheme.blueSuperMuda,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Provider.of<LockViewModel>(context, listen: false)
                    //     .handleAjaib(context);
                    Navigator.pushReplacementNamed(context, webviewRoute);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: ColorTheme.blue,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black38,
                              offset: Offset(0, 4))
                        ]),
                    child: Center(
                      child: Text(
                        "Masuk halaman ujian",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            color: ColorTheme.white),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset("assets/images/sekolahan_id.png"),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    modelEncrypt.versi ?? "",
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                Text(
                  "2024 Sekolahan.id",
                  style: TextStyle(color: Colors.black38),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
