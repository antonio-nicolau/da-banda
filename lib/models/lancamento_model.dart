// To parse this JSON data, do
//
//     final lancamentoModel = lancamentoModelFromJson(jsonString);

import 'dart:convert';

List<LancamentoModel> lancamentoModelFromJson(String str) => List<LancamentoModel>.from(json.decode(str).map((x) => LancamentoModel.fromJson(x)));

class LancamentoModel {
  LancamentoModel({
    this.url,
    this.img,
    this.title,
    this.currentPage,
    this.limPages,
  });

  String url;
  String img;
  String title;
  String currentPage;
  String limPages;

  factory LancamentoModel.fromJson(Map<String, dynamic> json) => LancamentoModel(
    url: json["url"],
    img: json["img"],
    title: json["title"],
    currentPage: json["currentPage"],
    limPages: json["limPages"],
  );
}
