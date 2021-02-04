import 'package:flutter/material.dart';
import 'package:musica_download/widgets/lancamento_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestPermition();

  }
  @override
  Widget build(BuildContext context) {
    int _currentTab = 0;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          _currentTab = value;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Definições',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'O que gostaria de encontrar?',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            LancamentoWidget(),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  requestPermition() async{
    if(await Permission.storage.request().isGranted){
      print('Accepted Permition');
    }

  }
}
