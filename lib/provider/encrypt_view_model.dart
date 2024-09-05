import 'dart:convert';
import 'package:alguik/model/decrypt_data.dart';
import 'package:alguik/others/Colors.dart';
import 'package:alguik/routes/routes.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'dart:developer' as dev;
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EncryptViewModel extends ChangeNotifier {
  WebViewController? _controller;

  String? _tanggal;
  String? _namaSekolah;
  String? _poto;
  String? _versi;
  String? get versi => _versi;
  String? get poto => _poto;
  String? get namaSekolah => _namaSekolah;
  String? get tanggal => _tanggal;
  WebViewController? get controller => _controller;

  DecryptedDataModel? _decryptedDataModel;

  DecryptedDataModel? get decryptedDataModel => _decryptedDataModel;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  finaldecode(context, String scannedData) {
    //varible yang meyimpan private key
    String privateKeyPem = '''-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDditz8aqVLqp++
3Z8c0e29nN8k2AZHLvO+MhaGNUpdTDwlhgQNkpbQEtdSzIzblx4Btt/ROYR31DNg
ZdMiBEPAZx8uhXVM5o3j4iLZJiVIdqtETDecIJZBGq9+5HHLeqaJA9oZ6TEoSQyl
aE/FaKeyVbLB/NI+DxLGqRXCcICfwtbOVTSi5UwVnhIVKkM4pI7GA2pPPiXu4c4Z
GWYeawh86WCZH6BzQ5KqpnjDnHNybfsQ28RGN5ENjFJc4rkvbI0bqR5SgfX7wYsX
ZZMM/4gobCfgzjIc/zZa1IaKHczAIssnYDRqlikOmR+zEL0WHktVP6crQ+jHj6zF
Y2pcWjfFAgMBAAECggEANLqFjM1cMLV4Rm8MnQkpDslsweHpop0d9c2Jl2FNJQYN
RbgPNGTIoNbvKV2Wg/hEc8+BF1TbfsLChKXPmefOcVeJ8CJjEA3KxSuQNENUOdpG
up9yV+ZYpL+zd93q6K11QCSqzyJ1qPsz95VrcRaO3U7w2CNyrcMcKqzZSTlKH9vI
M8IOMZJfzLX63G6GMThuyKp5Q1vblEfkRz4jWvdzG79oSv29Ibj2lFEZ1kS4vNXe
Rwv7TTWMtAlbEI/OSoAd8L5ynD8asB5UQvIyUDapfGlZav5qVZVn+4FLQsb8Gr8m
dcOaTHXDEsGP5B0L0vCE4YYBsUTcyEGc7gWKtS+74QKBgQDuxbZ6fuZNLSSxjMk8
EMsmwismyDM7/1wTMTBakbuOfjh3edhTSBdZZo/KhZZ0qtQHE7G4wC8rZSF53Kq3
uEIcfc5QBK/Ud0FU342alqEdl+LmkP9If0DN4nbjBsy8VlXHKzOF6PCom+MJkDR6
fJI3UEJ0vD5fycIw1dMII5nt4QKBgQDthucdC8hzxe0aCThPxWUmsXjrOqRwDIXl
uQ0SeUb5ssKeXeLUI2VdnC11RiA88qHVSIUuBdP6ccbDnA9Wxk9+y3twBHSJtMS+
Eq3bYbGvElNinU4H+5FbFV4ZFoqcaKXXMZlXTcd3TmbBlQ+XC1wEsJy5IJmAbB9W
Hr/OiJ8eZQKBgQDWksj09jtimbIC+OES4IigMRf0Ry97uHT3Llok2hgx6o42GEJm
PT/2cGvB9SELgUT/gxxQSi1Zkw1tZPfqGGUZE5mnYT7d8bm9WxT3Gmx5mrgmuaEg
dnM3Uk/Cn6a3jeKSFOm9amNzMnvqaTQv6ui/WpoOK+jlzft8RXvbMZswIQKBgFPl
TkRoIQkjY7fKgeVLJ4sfLEKJmAMrqS+WyRM5WuRfS3Z8Wt3rEqaZv0So3EIqwRaA
Yun6jQDspvP4b0KLEREL9jF+oVrySnuIRXgzbXsU0fcG8MTJCnJNfcsGtza/j7QO
hMbdZhKx0oGVkMgc7weJChIpfY5qojbc7YqZnvoxAoGBAOPQtXraXVbFWirvsLHS
bhwThQz0/PfJFG7RrjObZdvhn1YhAVax3YYPvBGwuugrEo8MwdkTK2D8amRdJkY/
pbCVxNGERdVCML2Kott6WjIb+9o7rSxjosMjQvUk1CG8msxwjjU1VAnX+4HduvsY
ON/QAnj7gVnB8xbCRqQXDUtY
-----END PRIVATE KEY-----
''';

    //proses mendecode data dari barcode
    try {
      List<int> decodedBytes = base64Decode(scannedData);
      String decodedString = utf8.decode(decodedBytes, allowMalformed: true);
      dev.log('Decoded string: $decodedString');
      //proses pengambilan hasil decode dan masuk kedalam proses dekrip
      // ignore: unused_local_variable
      DecryptedDataModel? decryptedData =
          decryptData(context, Uint8List.fromList(decodedBytes), privateKeyPem)
              as DecryptedDataModel?;
    } catch (e) {
      print('Error decoding Base64 string: $e');
    }
  }

  decryptData(context, Uint8List decodedBytes, String privateKeyPem) async {
    try {
      dev.log('Memulai proses dekripsi...');

      RSAPrivateKey privateKey =
          CryptoUtils.rsaPrivateKeyFromPem(privateKeyPem);
      final cipher = OAEPEncoding(RSAEngine())
        ..init(false, PrivateKeyParameter<RSAPrivateKey>(privateKey));

      final decryptedBytes = cipher.process(decodedBytes);
      String decryptedText = utf8.decode(decryptedBytes);
      dev.log('Hasil dekripsi: $decryptedText');

      //memisahkan data yang diterima dari hasil dekrip barcode
      List<String> parts = decryptedText.split('-');
      dev.log('Bagian hasil split: ${parts.length} bagian');
      if (parts.length == 5) {
        String namaSma = parts[0];
        String tanggalString = parts[1];
        String link = parts[2];
        String poto = parts[3];
        String versi = parts[4];
        await getData(namaSma, tanggalString, link, poto, versi);

        dev.log('namaSma: $namaSma');
        dev.log('tanggal: $tanggalString');
        dev.log('link: $link');
        dev.log("poto: $poto");
        dev.log("versi $versi");
        notifyListeners();
        updateUi(context); // Panggil method updateUi setelah notifyListeners
      } else {
        dev.log('Data hasil dekripsi tidak sesuai format yang diharapkan.');
      }
    } catch (e) {
      dev.log('Kesalahan saat dekripsi: $e');
    }
  }

  Future<void> cekStatusData() async {
    final simpan = await SharedPreferences.getInstance();
    _isLoggedIn = simpan.getBool("isLoggedIn") ?? false;
    notifyListeners();
  }

  Future<void> getData(String namaSma, String tanggal, String link, String poto,
      String versi) async {
    final simpan = await SharedPreferences.getInstance();
    await simpan.setBool('isLoggedIn', true);
    await simpan.setString('namaSekolah', namaSma);
    await simpan.setString('tanggal', tanggal);
    await simpan.setString('link', link);
    await simpan.setString('poto', poto);
    await simpan.setString('versi', versi);
  }

  void updateUi(context) async {
    try {
      final simpan = await SharedPreferences.getInstance();
      String? savedNamaSekolah = simpan.getString('namaSekolah');
      String? savedTanggal = simpan.getString('tanggal');
      String? savedLink = simpan.getString('link');
      String? savedPoto = simpan.getString('poto');
      String? savedVersi = simpan.getString('versi');

      if (savedTanggal != null) {
        bool isValidDate = testDateParsing(context, savedTanggal);

        // Jika tanggal valid, jalankan logika berikutnya
        if (isValidDate) {
          if (savedNamaSekolah != null) {
            nameSekolah(savedNamaSekolah);
          }
          if (savedLink != null) {
            loadWebView(savedLink);
          }
          if (savedPoto != null) {
            linkPoto(savedPoto);
          }
          if (savedVersi != null) {
            dataVersi(savedVersi);
          }
          dev.log('data berhasil di simpan');
          Navigator.pushReplacementNamed(context, halamanRoute);
        } else {
          dev.log('Tanggal tidak valid. Proses update UI dihentikan.');
        }
      } else {
        dev.log('Tanggal tidak ditemukan. Proses update UI dihentikan.');
      }
    } catch (e) {
      dev.log('Kesalahan saat update UI: $e');
    }
  }

  Future<void> logout() async {
    final simpan = await SharedPreferences.getInstance();
    await simpan.clear();
    _isLoggedIn = false;
    notifyListeners();
    dev.log('data shared telah berhasil di hapus');
  }

  resetDataDekrip() async {
    // _namaSekolah = null;
    // _poto = null;
    // _versi = null;
    // _controller = null;
    SharedPreferences hapus = await SharedPreferences.getInstance();
    hapus.remove('namaSekolah');
    hapus.remove('link');
    hapus.remove('tanggal');
    hapus.remove('poto');
    hapus.remove('versi');
    notifyListeners();
  }

  alertLogout(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Pemberitahuan!",
              style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w800, color: ColorTheme.blueMuda),
            ),
            content: Text(
              "Apakah anda yakin akan melakukan logout?",
              style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.w700),
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
                      Navigator.pop(context);
                      logout();
                      Navigator.pushReplacementNamed(context, initRoute);
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
                  ))
                ],
              )
            ],
          );
        });
  }

  bool testDateParsing(context, String tanggal) {
    String tanggalString = tanggal;
    if (tanggalString.length != 8) {
      dev.log('Panjang string tanggal tidak sesuai: $tanggalString');
      return false;
    }

    try {
      int year = int.parse(tanggalString.substring(0, 4));
      int month = int.parse(tanggalString.substring(4, 6));
      int day = int.parse(tanggalString.substring(6, 8));

      // Validasi bulan dan hari
      if (month < 1 || month > 12 || day < 1 || day > 31) {
        throw FormatException('Tanggal tidak valid: $tanggalString');
      }
      DateTime tanggal = DateTime(year, month, day);
      if (DateTime.now().isAfter(tanggal)) {
        Navigator.pushReplacementNamed(context, webviewRoute);

        dev.log('Tanggal sudah kadaluarsa');
        dev.log('tanggal $tanggal');
        return false;
      } else {
        dev.log('Tanggal masih berlaku');
        return true;
      }
    } catch (e) {
      dev.log('Gagal memproses tanggal: $e');
      return false;
    }
  }

  dataVersi(String versi) {
    _versi = versi;
    notifyListeners();
  }

  linkPoto(String linkPoto) {
    _poto = linkPoto;
    notifyListeners();
  }

  nameSekolah(String namaSekolah) {
    _namaSekolah = namaSekolah;
    notifyListeners();
  }

  void loadWebView(String link) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('$link'));
    notifyListeners();
  }
}
