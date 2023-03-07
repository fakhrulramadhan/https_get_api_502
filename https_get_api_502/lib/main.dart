import 'dart:convert';

import 'package:flutter/material.dart';
//import package httpnya dulu
import 'package:http/http.dart' as httpku; //namanya httpku

void main() {
  runApp(const MyApp());
}

//pakai tools pubspec assist utk menginstall package http
//f1 -> pubspec assist

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Beranda(),
    );
  }
}

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
//variabel utk menampilkan data get apinya
  //late String body;

  //variabel utk menampilkan id, nama,email
  late String id;
  late String name;
  late String email;

  //utk tampilan awal
  @override
  void initState() {
    //body = "Belum mendapatkan data";
    id = "";
    name = "";
    email = "";
    // TODO: implement initState
    super.initState();
  }

  //kalau simpan database di aplikaisnya berat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Get Reqres.in"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   //"teks ambil data"
            //   body, //data teks body get api ditaruh disini
            //   style: TextStyle(fontSize: 14, color: Colors.black),
            // ),
            //$ = String interpolation
            Text(
              "Id :  $id",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            Text(
              "Email: $email",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            Text(
              "Name:  $name",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            // Text(
            //   body,
            //   style: TextStyle(fontSize: 14, color: Colors.black),
            // ),
            SizedBox(
              height: 19,
            ),
            ElevatedButton(
                onPressed: () async {
                  //pakai web reqres.in
                  //kalau ngeget url get, maka akan dapat datanya
                  //butuh tipe datanya uri

                  //await menunggu koneksi internet,harus pakai async dulu
                  //berhasil
                  // var responseku = await httpku
                  //     .get(Uri.parse("https://reqres.in/api/users?page=2"));
                  //utk meresponse data sesuai id urlnya
                  var responseku = await httpku
                      .get(Uri.parse("https://reqres.in/api/users/7"));

                  //gagal
                  // var responseku = await httpku
                  //     .get(Uri.parse("https://reqrest.in/api/users?page=5"));

                  print(responseku); //bentuknya masih objek

                  //yang terpenting statuscode sama bodynya
                  print(responseku.statusCode); //kalau status 200 artinya skss
                  print("-----");
                  print(responseku.headers);
                  print("-----");
                  print(responseku.body);

                  //akan muncul dtanya kalau status code 200 (sukses)
                  if (responseku.statusCode == 200) {
                    //sukses dapat data
                    print("Berhasil dapat data");

                    //cara merubah mengekstrak string body
                    //json decode=> merubah string menjadi suatu objek
                    //agar bisa menjadi data dinamis,  nama varnya dataku
                    //setelah dapat objek, maka lakukanlah mapping
                    Map<String, dynamic> dataku =
                        json.decode(responseku.body) as Map<String, dynamic>;

                    print(dataku["data"]); //menampilkn data lengkap orangnya
                    setState(() {
                      //mengambil isian field data berdaarkan urlnya
                      //konvert ke string
                      //body = dataku["data"].toString();
                      //kalau mau mengambil data field emailnya saja di
                      //body = dataku["data"]["email"].toString();

                      id = dataku["data"]["id"].toString();
                      email = dataku["data"]["email"].toString();
                      //${} ini artinya string interpolation
                      name =
                          "${dataku["data"]["first_name"]} ${dataku["data"]["last_name"]}";

                      //awalnya gagal karena url api getnya salah
                      //body = dataku["data"]["email"].toString();
                      //body = dataku["per_page"].toString();
                    });
                  } else {
                    //gagal dapat data
                    print("error ${responseku.statusCode}");

                    // setState(() {
                    //   body = "error ${responseku.statusCode}";
                    // });
                  }
                },
                child: Text("Get Data"))
          ],
        ),
      ),
    );
  }
}
