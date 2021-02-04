import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:musica_download/models/detail_lancamento_model.dart';
import 'package:musica_download/models/lancamento_model.dart';
import 'package:musica_download/services/api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


play(String url) async {
  AudioPlayer audioPlayer = AudioPlayer();
  int result = await audioPlayer.play(url);
  if (result == 1)
    print('PLAYING...');
  else
    print('FAILED');
}

class LancamentoDetail extends StatefulWidget {
  LancamentoModel _lancamento;

  LancamentoDetail(this._lancamento);

  @override
  _LancamentoDetailState createState() => _LancamentoDetailState();
}

class _LancamentoDetailState extends State<LancamentoDetail> {
  bool _isPlaying = false;
  bool _isLoading = true;
  double downloadProgress = 0;
  DetailLancamentoModel _detailModel;
  String downloadPath;
  Api _api;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _api = Api();
    _api.fetchLancamentoDetail(widget._lancamento.url).then((value) {
      if (value != null) {
        _detailModel = value;
        _isLoading = false;

        setState(() {});
      }
    }).catchError((e) => print(e));

    getDownloadPath().then((value) => downloadPath = value.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 10.0),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.chevronDown),
                onPressed: () => Get.back(),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x46000000),
                      offset: Offset(0, 20),
                      spreadRadius: 0.0,
                      blurRadius: 30.0,
                    ),
                    BoxShadow(
                      color: Color(0x11000000),
                      offset: Offset(0, 10),
                      spreadRadius: 0.0,
                      blurRadius: 30.0,
                    ),
                  ]),
              child: Hero(
                tag: widget._lancamento.url,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage('${widget._lancamento.img}'),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Text(
                        '${_detailModel.title}',
                        style: TextStyle(fontSize: 20.0),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${_detailModel.artist}',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            SizedBox(
              height: 20.0,
            ),
            Slider(
              value: downloadProgress,
              max: 100.0,
              min: 0.0,
              activeColor: Color(0xFF5E35B1),
              onChanged: (val) {},
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.shareAlt,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 50,
                  icon: Icon(
                    _isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                    color: Color(0xFF5E35B1),
                  ),
                  onPressed: () {
                    play(
                        'https://matimba-news.com/wp-content/uploads/2020/12/C4-Pedro-Nossas-Coisas.mp3');

                    /*playMusic(
                        'https://www.vicentenews.com/wp-content/uploads/2020/10/Helio-Baiano-So-Deus-feat.-Deezy-e-Mendez.mp3'
                        );*/
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.download),
                  onPressed: (){
                    downloadFile(_detailModel.downloadUrl);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    ));
  }

  Future<Directory> getDownloadPath() async {
    return DownloadsPathProvider.downloadsDirectory;
  }

  downloadFile(url) async{
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );

    final taskId = FlutterDownloader.enqueue(
      url: url,
      showNotification: true,
      openFileFromNotification: true,
      savedDir: downloadPath,
    );

    FlutterDownloader.registerCallback((id, status, progress) {
      downloadProgress = double.parse(progress.toString());
      print('> ' + status.toString());
      setState(() {});
    });
  }
}
