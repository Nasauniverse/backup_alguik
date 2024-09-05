import 'package:alguik/others/Colors.dart';
import 'package:alguik/provider/camera_view_model.dart';
import 'package:alguik/provider/encrypt_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Sekolah bel",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w800,
                          color: ColorTheme.blue,
                          fontSize: 20),
                    ),
                    Text(
                      "um terverifikasi ",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w800,
                          color: ColorTheme.blueMuda,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active_outlined,
                        color: ColorTheme.blue,
                        size: 35,
                      ),
                      Text("L'",
                          style: TextStyle(
                              fontSize: 35,
                              color: ColorTheme.blue,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text("GUIK",
                      style: TextStyle(
                        fontSize: 30,
                        color: ColorTheme.blueSuperMuda,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  // Provider.of<EncryptViewModel>(context, listen: false)
                  //     .finaldecode();
                  // Navigator.pushNamed(context, ujilagiRoute);
                  Provider.of<CameraViewModel>(context, listen: false)
                      .scanQR(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorTheme.blue,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black38,
                            offset: Offset(0, 4))
                      ]),
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_2_sharp,
                        color: ColorTheme.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Scan QR Code",
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Image.asset("assets/images/sekolahan_id.png"),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.copyright_outlined,
                color: Colors.black38,
                size: MediaQuery.of(context).size.width / 100 * 3,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "2024 Sekolahan.id",
                style: TextStyle(color: Colors.black38),
              ),
            ],
          ),
        )
      ],
    );
  }
}
