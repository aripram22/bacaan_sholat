import 'dart:convert';
import 'package:bacaan_sholat/model/model_surat_pendek.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class SuratPendek {
  final String name;
  final String arabic;
  final String latin;
  final String terjemahan;

  SuratPendek({
    required this.name,
    required this.arabic,
    required this.latin,
    required this.terjemahan,
  });

  factory SuratPendek.fromJson(Map<String, dynamic> json) {
    return SuratPendek(
      name: json['name'] ?? '',
      arabic: json['arabic'] ?? '',
      latin: json['latin'] ?? '',
      terjemahan: json['terjemahan'] ?? '',
    );
  }
}

class SuratPendekList extends StatefulWidget {
  const SuratPendekList({Key? key}) : super(key: key);

  @override
  _SuratPendekListState createState() => _SuratPendekListState();
}

class _SuratPendekListState extends State<SuratPendekList> {
  late Future<List<SuratPendek>> _data;

  @override
  void initState() {
    super.initState();
    _data = _readSuratPendekJson();
  }

  Future<List<SuratPendek>> _readSuratPendekJson() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/data/suratpendek.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => SuratPendek.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surat Pendek Al-Qur\'an'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<SuratPendek>>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              var items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(items[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Arabic: ${items[index].arabic}'),
                          Text('Latin: ${items[index].latin}'),
                          Text('Terjemahan: ${items[index].terjemahan}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
