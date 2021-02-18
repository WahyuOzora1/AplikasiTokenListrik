import 'package:aplikasi_kebutuhan_listrik_pln/Screen/screen_beli_token.dart';
import 'package:aplikasi_kebutuhan_listrik_pln/Screen/screen_simulasi.dart';
import 'package:aplikasi_kebutuhan_listrik_pln/Screen/screen_simulator_kwh.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedTab = 0; //digunakan untuk membuat index pada listpage

  void _onTapedTab(int index) {
    setState(() {
      _selectedTab =
          index; //dengan menggunakan setState fungsi ini akan di render ulang dan mengikuti apa yang diinginkan user
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      SimKwhScreen(),
      SimPasangScreen(),
      SimBeliToken(),
    ];

    final _menuItem = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.mobile_screen_share), title: Text("Daya")),
      BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on_outlined),
          title: Text("Pasang Baru")),
      BottomNavigationBarItem(icon: Icon(Icons.nfc), title: Text("Beli Baru")),
    ];

    final _bottomBar = BottomNavigationBar(
      items:
          _menuItem, //property items akan kita isi dengan _menuItem yang kita isi di bottomnaviation bar
      currentIndex: _selectedTab, //property current index diisi dengan pilihan
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onTapedTab, //property onTap akan memanggil method_onTapedTab
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(
          Icons.apps,
          color: Colors.amber,
        ),
        title: Text("Stroom Simulator V1.0"),
      ),
      body: Center(
        child: _listPage[_selectedTab],
      ),
      bottomNavigationBar: _bottomBar,
    );
  }
}
