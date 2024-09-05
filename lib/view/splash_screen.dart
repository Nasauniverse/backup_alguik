import 'dart:async';
import 'package:alguik/others/Colors.dart';
import 'package:alguik/provider/splash_screen_view_model.dart';
import 'package:alguik/routes/routes.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashScreenViewModel>(context, listen: false).dynamicSplach(context);
    return Scaffold(
      backgroundColor: ColorTheme.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.3),
            child: Column(
              children: [
                FadeInLeft(
                    child: Container(
                        child: Text(
                  "WELLCOME TO",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.blue),
                ))),
                //
                FadeInRight(
                  child: Row(
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
                ),
              ],
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "2024 Sekolahan.id",
              style: TextStyle(color: Colors.black38),
            ),
          )
        ],
      ),
    );
  }
}
