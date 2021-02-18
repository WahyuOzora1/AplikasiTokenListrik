import 'package:flutter/material.dart';

class SimBeliToken extends StatefulWidget {
  @override
  _SimBeliTokenState createState() => _SimBeliTokenState();
}

class _SimBeliTokenState extends State<SimBeliToken> {
  double nilaiKwh = 0.0;

  TextEditingController nominalController = TextEditingController();
  TextEditingController tarifController = TextEditingController();
  TextEditingController ppjController = TextEditingController();
  TextEditingController adminController = TextEditingController();

  _hitungkWh(double nominal, double tarif, double ppj, double admin) {
    double kwh = 0.0;
    kwh = ((nominal - admin) / ((100 + ppj) / 100)) / tarif;
    print("Nilai kWh : $kwh");
    setState(() {
      nilaiKwh = kwh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          TextFormField(
            controller: nominalController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: "Nominal Token (Rp)",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: tarifController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: "Tarif berlaku (Rp/kWh)",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: ppjController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: "Pajak Penerangan Jalan (PPJ) (%)",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: adminController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: "Admin Bank/PPOB (Rp)",
                border: OutlineInputBorder()),
          ),
          MaterialButton(
              color: Colors.green[900],
              child: Text(
                "Hitung kWh",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _hitungkWh(
                  double.parse(nominalController.text),
                  double.parse(tarifController.text),
                  double.parse(ppjController.text),
                  double.parse(adminController.text))),
          Divider(
            height: 10.0,
          ),
          SizedBox(height: 30),
          Text(
            "Total kWh yang di dapat: ${nilaiKwh.toStringAsFixed(2)} kWh",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
