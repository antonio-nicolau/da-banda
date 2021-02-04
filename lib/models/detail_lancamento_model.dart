// To parse this JSON data, do
//
//     final detailModel = detailModelFromJson(jsonString);

import 'dart:convert';

DetailLancamentoModel detailModelFromJson(String str) =>
    DetailLancamentoModel.fromJson(json.decode(str));

class DetailLancamentoModel {
  DetailLancamentoModel({
    this.title,
    this.artist,
    this.category,
    this.anoLancamento,
    this.downloadUrl,
  });

  String title;
  String artist;
  String category;
  String anoLancamento;
  String downloadUrl;

  factory DetailLancamentoModel.fromJson(Map<String, dynamic> json) => DetailLancamentoModel(
        title: json["title"],
        artist: json["artist"],
        category: json["category"],
        anoLancamento: json["anoLancamento"],
        downloadUrl: json["downloadUrl"],
      );
}
