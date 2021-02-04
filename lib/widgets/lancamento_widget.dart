import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musica_download/models/lancamento_model.dart';
import 'package:musica_download/pages/lancamento_detail_page.dart';
import 'package:musica_download/services/api.dart';

class LancamentoWidget extends StatefulWidget {
  @override
  _LancamentoWidgetState createState() => _LancamentoWidgetState();
}

class _LancamentoWidgetState extends State<LancamentoWidget> {
  bool _isLoading = true;
  Api _api;
  List<LancamentoModel> _myLancamentos;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _api = Api();
    _api.fetchLancamentos().then((value) {
      if (value != null) {
        _myLancamentos = value;
        _isLoading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Últimos lançamentos',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: 300.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _myLancamentos.length,
                  itemBuilder: (context, index) {
                    LancamentoModel lancamento = _myLancamentos[index];

                    return GestureDetector(
                      onTap: () => Get.to(LancamentoDetail(lancamento)),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: 210.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              bottom: 0.0,
                              child: Container(
                                height: 120.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      '${lancamento.title}',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 6.0,
                                    ),
                                  ]),
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: lancamento.url,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        height: 180.0,
                                        width: 180.0,
                                        image:
                                            NetworkImage('${lancamento.img}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
