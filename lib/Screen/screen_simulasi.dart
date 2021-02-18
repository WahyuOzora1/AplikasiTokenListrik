import 'package:flutter/material.dart';

class SimPasangScreen extends StatefulWidget {
  @override
  _SimPasangScreenState createState() => _SimPasangScreenState();
}

class _SimPasangScreenState extends State<SimPasangScreen> {
  String _keterangan = "";
  TextEditingController dayaController = TextEditingController();

  _hitungBiaya(double daya) {
    double d = 0.0;

    if (daya <= 450) {
      d = 421000;
    } else if (daya >= 900 && daya <= 2200) {
      d = daya * 937;
    } else if (daya >= 10500 && daya <= 197000) {
      d = daya * 775;
    }

    setState(() {
      _keterangan =
          "Nilai BP yang harus dibayarkan : \n Rp.${d.toStringAsFixed(0)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: dayaController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blue,
              labelText: "Masukkan Daya (VA)",
              border: OutlineInputBorder(),
            ),
          ),
          MaterialButton(
            onPressed: () {
              _hitungBiaya(double.parse(dayaController.text));
            },
            color: Colors.green[900],
            child: Text(
              "Hitung nilai Biaya Penyambungan (BP)",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(
            height: 3,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            _keterangan.isNotEmpty ? _keterangan : "",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
