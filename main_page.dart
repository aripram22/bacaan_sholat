// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:bacaan_sholat/page/ayat_kursi_page.dart';
import 'package:bacaan_sholat/page/bacaan_sholat_page.dart';
import 'package:bacaan_sholat/page/niat_sholat_page.dart';
import 'package:bacaan_sholat/page/todo.dart';
import 'package:bacaan_sholat/page/surat_pendek_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NiatSholat(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/ic_niat.png"),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Niat Sholat",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.all(10),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>BacaanSholat(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/ic_doa.png"),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Bacaan Sholat",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.all(10),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AyatKursi(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/ic_bacaan.png"),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Ayat Kursi",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.all(10),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoListPage(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/ic_todo.png"),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "To-Do List",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 40),
              Container(
                margin: EdgeInsets.all(10),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>BacaanSholat(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/ic_surat.png"),
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Surat Pendek",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
