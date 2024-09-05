class DecryptedDataModel {
  final String dataNamaSma;
  final String dataTanggal;
  final String dataLink;
  final String dataPoto;
  final String dataVersi;

  DecryptedDataModel({
    required this.dataNamaSma,
    required this.dataTanggal,
    required this.dataLink,
    required this.dataPoto,
    required this.dataVersi,
  });

  @override
  String toString() {
    return 'DecryptedDataModel(dataNamaSma: $dataNamaSma, dataTanggal: $dataTanggal, dataLink: $dataLink, dataPoto: $dataPoto, dataVersi $dataVersi)';
  }
}
