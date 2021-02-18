import 'package:flutter/material.dart';

class SimKwhScreen extends StatefulWidget {
  @override
  _SimKwhScreenState createState() => _SimKwhScreenState();
}

class _SimKwhScreenState extends State<SimKwhScreen> {
  TextEditingController alatController =
      TextEditingController(); //initialisasi controller

  TextEditingController dayaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  var listElektronik = [];
  var totalDaya = 0.0; //untuk kasih total daya

  void _tambahData(String nama, int daya, int jumlah) {
    double va;
    va = _hitungVa(daya, jumlah);

    setState(() {
      listElektronik.add(
          {"namaAlat": nama, "daya": daya, "jumlah": jumlah, "jumlahVa": va});
      totalDaya = totalDaya + va;
    });
  }

  void _hapusData(int index) {
    double va;
    va = listElektronik[index]['jumlahVa'];
    setState(() {
      listElektronik.removeAt(index);
      totalDaya = totalDaya - va;
    });
  }

  double _dayaPLN(double daya) {
    double d = 0.0;

    if (daya <= 450.0) {
      d = 450;
    } else if (daya > 450.0 && daya <= 900) {
      d = 1300;
    } else if (daya > 900.0 && daya <= 1300.0) {
      d = 2200;
    } else if (daya > 1300.0 && daya <= 2200.0) {
      d = 3500;
    } else if (daya > 2200.0 && daya <= 3500.0) {
      d = 4400;
    } else if (daya > 3500.0 && daya <= 4400.0) {
      d = 5500;
    }

    return d;
  }

  void _clearScreen() {
    setState(() {
      listElektronik.clear();
      alatController.clear();
      dayaController.clear();
      jumlahController.clear();
      totalDaya = 0.0;
    });
  }

  void _rekomendasiDaya(double daya) {
    var vaPLN;
    vaPLN = _dayaPLN(daya);

    //menerima variabel daya
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Rekomendasi PLN"),
            content: Text(
                "Total daya Anda butuhkan adalah ${daya.toStringAsFixed(0)} VA.\nAnda dapat berlangganan daya ${vaPLN.toStringAsFixed(0)}"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _clearScreen();
                  },
                  child: Text("Tutup"))
            ],
          );
        });
  }

  // ignore: missing_return
  double _hitungVa(int daya, int jumlah) {
    double hasil;
    hasil = (daya * jumlah / 0.85);
    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: alatController, //harus di inisialisasi
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[50],
                        labelText: "Alat Elektronik",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: dayaController, //harus di inisialisasi
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[50],
                        labelText: "Daya(Watt)",
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: jumlahController, //harus di inisialisasi
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[50],
                        labelText: "Jumlah Unit",
                        border: OutlineInputBorder()),

                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total Kebutuhan Anda"),
                      Text(
                        "${totalDaya.toStringAsFixed(0)} VA",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      MaterialButton(
                        onPressed: () {
                          _tambahData(
                              alatController.text,
                              int.parse(dayaController.text),
                              int.parse(jumlahController.text));
                        },
                        color: Colors.orange[900],
                        child: Text(
                          "TAMBAH",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                          minWidth: 10, //memaksa tombol lebarnya 10 pixel
                          onPressed: () {
                            _rekomendasiDaya(totalDaya);
                          },
                          color: Colors.orange[900],
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listElektronik.length,
                itemBuilder: (context, pos) {
                  return Card(
                    elevation: 3,
                    color: Colors.green[50],
                    child: ListTile(
                      title: Text(
                          "Nama Alat : ${listElektronik[pos]['namaAlat']}"), //tulis nama sesuai key yang benar
                      subtitle:
                          Text("Jumlah : ${listElektronik[pos]['jumlah']}"),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Colors.blue[300],
                            ),
                            child: Center(
                              child: Text(listElektronik[pos]['jumlahVa']
                                  .toStringAsFixed(
                                      0)), //untuk membatasi jumlah angka di belakang koma, 0 agar tidak ad angka dibelakang koma
                            ),
                            //menampilkan harus sebuah string
                          ),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _hapusData(pos);
                              })
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
