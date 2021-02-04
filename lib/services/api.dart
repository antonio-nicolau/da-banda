import 'package:dio/dio.dart';
import 'package:musica_download/configuration.dart';
import 'package:musica_download/models/detail_lancamento_model.dart';
import 'package:musica_download/models/lancamento_model.dart';

class Api {
  Future<List<LancamentoModel>> fetchLancamentos() async {
    Response response = await Dio().get(lancamentoUrl);
    return lancamentoModelFromJson(response.data);
  }

  Future<DetailLancamentoModel> fetchLancamentoDetail(String url) async {
    Response response = await Dio().get(detailLancamentoUrl + '?url=$url');
    return detailModelFromJson(response.data);
  }
}
